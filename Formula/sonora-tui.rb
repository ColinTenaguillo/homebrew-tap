class SonoraTui < Formula
  desc "A terminal music player for TIDAL, Spotify, Apple Music, Deezer, YouTube Music, Subsonic and your own files"
  homepage "https://github.com/ColinTenaguillo/sonora-tui"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.7.0/sonora-tui-aarch64-apple-darwin.tar.xz"
      sha256 "27a46c12a532526bb73814aba8f3c45f584c37520f10e120b2e0a496011c555e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.7.0/sonora-tui-x86_64-apple-darwin.tar.xz"
      sha256 "d053882c125c264e52181156b2fc5f40878dfa0a36dff08b0e477da9fa1daa32"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.7.0/sonora-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "04f2d41b67e7e33966edc8901f476cd8974b8d8b6479059fe5d412cd120341ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.7.0/sonora-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d5f6e0dd8b1bfa43a8242a694f5b78835402dd341ffb717fbbacde0cfb1818b"
    end
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sonora-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sonora-tui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sonora-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sonora-tui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
