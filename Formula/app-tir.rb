class AppTir < Formula
  desc "Kitchen timer command with notification, speech, and countdown"
  homepage "https://github.com/kaz-utashiro/tir"
  url "https://github.com/kaz-utashiro/tir/archive/refs/tags/v0.9.tar.gz"
  sha256 "ca213f1e3f7ee9ea5678b75e89e6b3466aa9ee3abb366847d3388ec97de0ce0f"
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
