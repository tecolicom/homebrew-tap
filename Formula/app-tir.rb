class AppTir < Formula
  desc "Kitchen timer command with notification, speech, and countdown"
  homepage "https://github.com/kaz-utashiro/tir"
  url "https://github.com/kaz-utashiro/tir/archive/refs/tags/v0.8.tar.gz"
  sha256 "deb269825d551de20371b8aa23fc2ad24b5d137cea474f161ad9c2c2a28d781c"
  license "MIT"
  depends_on :macos

  def install
    bin.install "tir"
    man1.install "tir.1"
  end

  test do
    system bin/"tir", "-h"
  end
end
