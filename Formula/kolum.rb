class Kolum < Formula
  desc "A kanban client for the terminal, with vim keys and a Telescope-style picker"
  homepage "https://github.com/ColinTenaguillo/kolum"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/kolum/releases/download/v0.1.0/kolum-aarch64-apple-darwin.tar.xz"
      sha256 "99a5d07c83eda76f71a434cb38005765504360c77313367e0ffeda281b754bec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/kolum/releases/download/v0.1.0/kolum-x86_64-apple-darwin.tar.xz"
      sha256 "6f2adf06b0be301b5c1c17458460b89b9e2eacaf7d40541f37baef73aa757b89"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ColinTenaguillo/kolum/releases/download/v0.1.0/kolum-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9e80f20aa8eb2daca4d0ce8f9f581727e176633e931781ad392bb95d747ffee0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ColinTenaguillo/kolum/releases/download/v0.1.0/kolum-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "669618fb041fcc568cfff9ec538e56b16fe9f9ea067e9edd1ed4fc482188c383"
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
      bin.install "kolum"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kolum"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kolum"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kolum"
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
