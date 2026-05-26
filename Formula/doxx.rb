class Doxx < Formula
  desc "Terminal document viewer for .docx files"
  homepage "https://github.com/bgreenwell/doxx"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/doxx/releases/download/v0.1.4/doxx-aarch64-apple-darwin.tar.xz"
      sha256 "0947e77dd5f2bc955cf860b54e82553fa58c85a30a62fef2a6bb80cffeb4e66d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/doxx/releases/download/v0.1.4/doxx-x86_64-apple-darwin.tar.xz"
      sha256 "438f4be310d0aa06faa38d55fc540cdf1833450b06e223e2ccecf3e174581704"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/doxx/releases/download/v0.1.4/doxx-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e401be69d0d6bd428d0b850317ed524656472849f50034d4b26f6725e43b8030"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/doxx/releases/download/v0.1.4/doxx-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ebac222bfe04ac3a776277c0fc9dd40f8564070bf020330f593ee77ac2b426e0"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "doxx", "generate_test_docs" if OS.mac? && Hardware::CPU.arm?
    bin.install "doxx", "generate_test_docs" if OS.mac? && Hardware::CPU.intel?
    bin.install "doxx", "generate_test_docs" if OS.linux? && Hardware::CPU.arm?
    bin.install "doxx", "generate_test_docs" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
