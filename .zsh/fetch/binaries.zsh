function source-eza() {
  version="v0.21.4"
  output="eza.tar.gz"

  source_x86_64="https://github.com/eza-community/eza/releases/download/${version}/eza_x86_64-unknown-linux-musl.tar.gz"
  sha256sums_x86_64="82e1dde17d007c4903e88e9ee6e9dbd81f243616d547c71fe55cd3b0fa8739b0"

  # eza doesn't ship musl aarch64 binaries officially
  source_aarch64="https://binaries.gayest.systems/eza-${version}/eza_aarch64-unknown-linux-musl.tar.gz"
  sha256sums_aarch64="2f8861d17ebeea8f2a76ec1c4c8766da521567f0b1025526059c6665920efff9"
}

function install-eza() {
  install -Dm755 "./eza" "${pkgdir}/eza"
}

function source-bat() {
  version="v0.25.0"
  output="bat.tar.gz"

  source_x86_64="https://github.com/sharkdp/bat/releases/download/${version}/bat-${version}-x86_64-unknown-linux-musl.tar.gz"
  sha256sums_x86_64="93f47d76abe328c402ef712e9ac92aa6d5bc84d5adcbcaf0bbc5665e5275a941"
  source_aarch64="https://github.com/sharkdp/bat/releases/download/${version}/bat-${version}-aarch64-unknown-linux-musl.tar.gz"
  sha256sums_aarch64="ee0f12cf6006a79cf4ccf75d2ddcf9f6ba124644503244b1af909c2f72a2a9f7"
}

function install-bat() {
  install -Dm755 "./bat" "${pkgdir}/bat"
}

function source-starship() {
  version="v1.23.0"
  output="starship.tar.gz"

  source_x86_64="https://github.com/starship/starship/releases/download/${version}/starship-x86_64-unknown-linux-musl.tar.gz"
  sha256sums_x86_64="8d06d2cc67aedd6316ff58ab679fb80cded0d85de1dcd5727df0633d35356d57"
  source_aarch64="https://github.com/starship/starship/releases/download/${version}/starship-aarch64-unknown-linux-musl.tar.gz"
  sha256sums_aarch64="d37040138c68b5f3334bbe16d4615f0a83829deebecc5d014e779c302e8270d8"
}

function install-starship() {
  install -Dm755 "./starship" "${pkgdir}/starship"
}

function source-atuin() {
  version="v18.6.1"
  output="atuin.tar.gz"

  source_x86_64="https://github.com/atuinsh/atuin/releases/download/${version}/atuin-x86_64-unknown-linux-musl.tar.gz"
  sha256sums_x86_64="c781d5eeb4c407069fbc402ec3ad11a755f5a916f13220ac4612dccda42399ad"
  source_aarch64="https://github.com/atuinsh/atuin/releases/download/${version}/atuin-aarch64-unknown-linux-musl.tar.gz"
  sha256sums_aarch64="42b7d9bde8bf2d04832c1b2ceea1d3d89ecd762a40623d92a7197d2287fff82b"
}

function install-atuin() {
  install -Dm755 "./atuin" "${pkgdir}/atuin"
}

function source-zoxide() {
  version="v0.9.8"
  output="zoxide.tar.gz"

  source_x86_64="https://github.com/ajeetdsouza/zoxide/releases/download/${version}/zoxide-${version:1}-x86_64-unknown-linux-musl.tar.gz"
  sha256sums_x86_64="4092ee38aa1efde42e4efb2f9c872df5388198aacae7f1a74e5eb5c3cc7f531c"
  source_aarch64="https://github.com/ajeetdsouza/zoxide/releases/download/${version}/zoxide-${version:1}-aarch64-unknown-linux-musl.tar.gz"
  sha256sums_aarch64="078cc9cc8cedb6c45edb84c0f5bad53518c610859c73bdb3009a52b89652c103"
}

function install-zoxide() {
  install -Dm755 "./zoxide" "${pkgdir}/zoxide"
}

function source-carapace() {
  version="v1.3.2"
  output="carapace.tar.gz"

  source_x86_64="https://github.com/carapace-sh/carapace-bin/releases/download/${version}/carapace-bin_${version:1}_linux_amd64.tar.gz"
  sha256sums_x86_64="ad0e65304068d7f4853b151c01960d8e9cb49c8fa9cbf5872bfb7a897195ed4f"
  source_aarch64="https://github.com/carapace-sh/carapace-bin/releases/download/${version}/carapace-bin_${version:1}_linux_arm64.tar.gz"
  sha256sums_aarch64="ce3c67749faf929d11cb661061ef6afe769c2f952389e30bfc0c7752a88fc6bd"
}

function install-carapace() {
  install -Dm755 "./carapace" "${pkgdir}/carapace"
}

function source-direnv() {
  version="v2.36.0"
  output="direnv"

  source_x86_64="https://github.com/direnv/direnv/releases/download/${version}/direnv.linux-amd64"
  sha256sums_x86_64="604f3dc51f05620d7ea8d8360b3a18d72ccc842a181edabca4d7bd75b6784f88"
  source_aarch64="https://github.com/direnv/direnv/releases/download/${version}/direnv.linux-arm64"
  sha256sums_aarch64="c00a71cdb6ebb28e8232e70a7147dfab40c6f694406729c2d0430bdba79fce10"
}

function install-direnv() {
  install -Dm755 "./direnv" "${pkgdir}/direnv"
}
