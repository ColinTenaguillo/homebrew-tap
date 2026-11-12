class SonoraTui < Formula
  desc "A terminal music player for TIDAL, Spotify, Apple Music, Deezer, YouTube Music, Subsonic and your own files"
  homepage "https://github.com/ColinTenaguillo/sonora-tui"
  version "0.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.16.0/sonora-tui-aarch64-apple-darwin.tar.xz"
      sha256 "b13f0d46f1b588a1fb37b97a3b476bed9c27a6da94c005abd97909b18d4512ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.16.0/sonora-tui-x86_64-apple-darwin.tar.xz"
      sha256 "34a4b5753942d07c8c70f7502c48cfb4fd70ca66aa388a46d12cadc40303a3e8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.16.0/sonora-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e535674416a3950113c66d355ff89111594d0e411d6dc7f05c8d78f278b7c6a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.16.0/sonora-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "77617050fd1e44f13e02cef8d8874601d1eaa342e7604a2c8f0d3e0155a80568"
    end
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
