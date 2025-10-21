class Doxx < Formula
  desc "Terminal document viewer for .docx files"
  homepage "https://github.com/bgreenwell/doxx"
  url "https://github.com/bgreenwell/doxx/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "3627e65f39e437d954e1d4f02c30911fef1c5c99388bf6098564e1e89722e80d"
  license "MIT"
  head "https://github.com/bgreenwell/doxx.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "doxx", shell_output("#{bin}/doxx --version")
  end
end
