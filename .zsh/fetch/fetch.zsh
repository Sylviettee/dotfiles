function confirmation-prompt() {
  local answer

  while [ "$answer" != 'y' -a "$answer" != 'n' ]; do
    >&2 echo -n "$1 (y/n): "
    read answer
  done

  echo "$answer"
}

function binary-locate() {
  to_install=( $@ )  

  if [ ${#to_install[@]} = 0 ]; then
    return
  fi

  if [ "$binary_locate_no_recurse" = 1 ]; then
    echo "recursive loop detected; please install wget"
    return
  fi

  if ! command -v wget >/dev/null 2>&1; then
    binary_locate_no_recurse=1
    check-tool wget
  fi

  source "${0:h}/binaries.zsh"
  arch=$(uname -m)
  pkgdir="$HOME/.local/bin"

  for cmd in ${to_install[@]}; do
    if ! typeset -f "source-$cmd" > /dev/null; then
      echo "command not found: $cmd, this is likely a bug"
      continue
    fi

    source-$cmd
    if [ ! -v "source_$arch" ]; then
      echo "command $cmd does not support architecture: $arch"
      continue
    fi

    source_arch="source_$arch"
    source=${(P)source_arch}
    sha256sums_arch="sha256sums_$arch"
    sha256sums=${(P)sha256sums_arch}

    download_dir=$(mktemp -d)

    pushd "$download_dir"

    wget "$source" -O "$output"

    if [[ "$output" == *.tar.gz ]]; then
      download_dir_inner="$download_dir/source"
      mkdir "$download_dir_inner"
      tar -xf "$output" -C "$download_dir_inner"
    else
      download_dir_inner="$download_dir"
    fi

    pushd "$download_dir_inner"

    install-$cmd

    popd; popd

    rm -rf "$download_dir"
  done
}

function arch-locate() {
  to_install=( $@ )

  # TODO; handle if the user cancelled
  if ! command -v pkgfile >/dev/null 2>&1; then
    echo "pkgfile not found, installing"
    sudo pacman -S --no-confirm pkgfile
    sudo pkgfile -u
  fi

  pkgs=()
  not_found=()

  for cmd in ${to_install[@]}; do
    pkg=$(pkgfile -b "$cmd" | head -n 1)
    if [ -z "$pkg" ]; then
      not_found+=("$cmd")
    else
      pkgs+=("$pkg")
    fi
  done

  echo "installing via pacman: $pkgs"
  sudo pacman -S $pkgs

  binary-locate $not_found
}

function debian-locate() {
  to_install=( $@ )

  # TODO; handle if the user cancelled
  if [ ! -e /var/lib/command-not-found/commands.db ]; then
    echo "command-not-found database not found, installing"
    sudo apt install -y command-not-found
    sudo /usr/lib/cnf-update-db
  fi

  pkgs=()
  not_found=()

  for cmd in ${to_install[@]}; do
    pkg+=$(sqlite3 \
      -readonly \
      /var/lib/command-not-found/commands.db \
      "SELECT packages.name FROM commands JOIN packages ON commands.pkgID=packages.pkgID WHERE commands.command=\"$cmd\" LIMIT 1"
    )
    if [ -z "$pkg" ]; then
      not_found+=("$cmd")
    else
      pkgs+=("$pkg")
    fi
  done

  echo "installing via apt: $pkgs"
  sudo apt install $pkgs

  binary-locate $not_found
}

function check-tool() {
  if [ -e "$HOME/.ignore-install" ]; then
    return
  fi

  local found=()
  local not_found=()

  for cmd in "$@"; do
    if command -v "$cmd" >/dev/null 2>&1; then
      found+=("$cmd")
    else
      not_found+=("$cmd")
    fi
  done

  if [ ${#not_found[@]} = 0 ]; then
    return
  fi

  echo "command(s) found: $found"
  echo "command(s) not found: $not_found"

  local install=$(confirmation-prompt "do you wish to install?")

  if [ "$install" = 'n' ]; then
    local ignore=$(confirmation-prompt "do you want to ignore all future install prompts?")

    if [ "$ignore" = 'y' ]; then
      echo "install prompts can be re-enabled by deleting ~/.ignore-install"
      touch "$HOME/.ignore-install"
    fi

    return
  fi

  source /etc/os-release

  case "${ID_LIKE:-$ID}" in
    arch)
      arch-locate $not_found
      ;;
    debian)
      debian-locate $not_found
      ;;
    *)
      binary-locate $not_found
      ;;
  esac
}
