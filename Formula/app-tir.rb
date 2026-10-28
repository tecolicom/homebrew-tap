class AppTir < Formula
  desc "Kitchen timer command with notification, speech, and countdown"
  homepage "https://github.com/kaz-utashiro/tir"
  url "https://github.com/kaz-utashiro/tir/archive/refs/tags/v0.11.tar.gz"
  sha256 "7acad8de6dcd786851acce1b18340d76bf90eb669dbff7309cad35eed9dffbdd"
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
