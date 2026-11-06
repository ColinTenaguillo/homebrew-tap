class SonoraTui < Formula
  desc "A terminal music player for TIDAL, Spotify, Apple Music, Deezer, YouTube Music, Subsonic and your own files"
  homepage "https://github.com/ColinTenaguillo/sonora-tui"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.14.0/sonora-tui-aarch64-apple-darwin.tar.xz"
      sha256 "23a5b96713e941c7e82f00a2f416d588c85d0dca726e1f21a03854d3cc128851"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.14.0/sonora-tui-x86_64-apple-darwin.tar.xz"
      sha256 "4acd6ccad8d799c2edd8b63aeae450901cd40972aa4c36bd42ea1c4b421a8839"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.14.0/sonora-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4d28a25da4ce1ff51f61fa56a7be6b70a5bbbc4b8be1b0ac3fa021cf6b23059c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.14.0/sonora-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "23bd4be1e587ab42b7850b89150780254f993b82625292980b3dbd876ca9f9de"
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
