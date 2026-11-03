class SonoraTui < Formula
  desc "A terminal music player for TIDAL, Spotify, Apple Music, Deezer, YouTube Music, Subsonic and your own files"
  homepage "https://github.com/ColinTenaguillo/sonora-tui"
  version "0.9.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.9.3/sonora-tui-aarch64-apple-darwin.tar.xz"
      sha256 "8f807fd40a786b8ada740cf741aee90f7f4ec0d87fd0fdcae3d9ca4f16ebeddb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.9.3/sonora-tui-x86_64-apple-darwin.tar.xz"
      sha256 "cbe4fa02462eae23449befdfdc25dc428a5a864a396cb1e90cb5036d387885d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.9.3/sonora-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1e9457f68f30bd25d19b4d5634bda91fcf2d738e307d8dd7dc90dd7b93234cbb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/sonora-tui/releases/download/v0.9.3/sonora-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a2a421cd7780595fa028e03d73caf1162e7f896137115522c43eb688db1ed8ba"
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
