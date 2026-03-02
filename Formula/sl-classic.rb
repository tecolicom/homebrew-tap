class SlClassic < Formula
  desc "Steam Locomotive runs across your terminal when you type sl"
  homepage "https://github.com/tecolicom/sl"
  url "https://github.com/tecolicom/sl/archive/refs/tags/v2023.tar.gz"
  sha256 "58c3dd3f8229ef99ef656a2e51f2f99d39ab095e2ce7fcb4bef8ce4724b66272"
  license "BSD-2-Clause"
  version "2023"

  uses_from_macos "ncurses"

  def install
    system ENV.cc, "-o", "sl", "src/sl-2023.c", "-lcurses"
    bin.install "sl"
  end

  test do
    assert_predicate bin/"sl", :executable?
  end
end
