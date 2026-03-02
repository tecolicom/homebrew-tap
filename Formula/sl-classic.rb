class SlClassic < Formula
  desc "Steam Locomotive runs across your terminal when you type sl"
  homepage "https://github.com/tecolicom/sl"
  url "https://github.com/tecolicom/sl/archive/refs/tags/v2026.tar.gz"
  sha256 "96d55beddac2cc5360e82b0a79f3f51872e64bcbc45cf5715dc917b87f4a1e2d"
  license "BSD-2-Clause"
  version "2026"

  uses_from_macos "ncurses"

  def install
    flags = ["-std=c89", "-Wno-implicit-int", "-Wno-implicit-function-declaration"]
    flags << "-Wno-incompatible-function-pointer-types" if ENV.compiler == :clang

    system ENV.cc, *flags,
           "-include", "term.h", "-DCM=cursor_address",
           "-o", "sl-1985", "src/sl.c", "-lcurses"
    system ENV.cc, "-o", "sl-2010", "src/sl-2010.c", "-lcurses"
    system ENV.cc, "-o", "sl-2023", "src/sl-2023.c", "-lcurses"
    (libexec/"sl-classic").install "sl-1985", "sl-2010", "sl-2023"
    bin.install "src/sl.sh" => "sl"
  end

  test do
    assert_predicate bin/"sl", :executable?
    assert_predicate libexec/"sl-classic/sl-1985", :executable?
    assert_predicate libexec/"sl-classic/sl-2010", :executable?
    assert_predicate libexec/"sl-classic/sl-2023", :executable?
  end
end
