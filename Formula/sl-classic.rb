class SlClassic < Formula
  desc "Steam Locomotive runs across your terminal when you type sl"
  homepage "https://github.com/tecolicom/sl"
  url "https://github.com/tecolicom/sl/archive/refs/tags/v2026.tar.gz"
  sha256 "4be7b6c62556ec245a668d6835a9294eac15c12a7aabfb8cb42340f1b87f042d"
  license "BSD-2-Clause"
  version "2026"

  uses_from_macos "ncurses"

  def install
    system ENV.cc, "-o", "sl-2023", "src/sl-2023.c", "-lcurses"
    (libexec/"sl-classic").install "sl-2023"
    bin.install "src/sl.sh" => "sl"
  end

  test do
    assert_predicate bin/"sl", :executable?
    assert_predicate libexec/"sl-classic/sl-2023", :executable?
  end
end
