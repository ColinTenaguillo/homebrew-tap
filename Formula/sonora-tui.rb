class SonoraTui < Formula
  desc "A terminal music player for TIDAL, Spotify, Apple Music, Deezer, YouTube Music, Subsonic and your own files"
  homepage "https://github.com/ColinTenaguillo/sonora-tui"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.10.0/sonora-tui-aarch64-apple-darwin.tar.xz"
      sha256 "6e3f310fa791275ea70b05d2306d1f0937c3de593012badf868e189f88aba781"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.10.0/sonora-tui-x86_64-apple-darwin.tar.xz"
      sha256 "2d9aba96ad27b335b2bda83cf1f9efd82226192468ec904a70cfc4c89dcea1d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.10.0/sonora-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "207ef10453dbe83a7e4912b331c1f2d2590e2ff20cfc3481e10378d410c3831d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.10.0/sonora-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "07721057eb3dfb73da542da9d2c9f5830a8815655ee970defbdfa310c4bb1fe4"
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
