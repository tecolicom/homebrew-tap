class Tir < Formula
  desc "Kitchen timer command with notification, speech, and countdown"
  homepage "https://github.com/kaz-utashiro/tir"
  url "https://github.com/kaz-utashiro/tir/archive/refs/tags/v0.7.tar.gz"
  sha256 "8fe144622c8711a7a52801e3595b202cf4e335bcd4206f65d64896129f9a91fd"
  depends_on :macos

  def install
    bin.install "tir"
  end

  test do
    system bin/"tir", "-h"
  end
end
