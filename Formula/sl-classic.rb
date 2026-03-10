class SlClassic < Formula
  desc "sl runs across your terminal when you type sl"
  homepage "https://github.com/tecolicom/sl"
  url "https://github.com/tecolicom/sl/archive/refs/tags/v2026.7.tar.gz"
  sha256 "39c87a3742627141bb81bee11ff2b9ebe2d2ccc52c2784ad255cf5971ff569bd"
  license "BSD-2-Clause"
  version "2026.7"

  resource "sl-modern" do
    url "https://github.com/mtoyoda/sl/archive/923e7d7ebc5c1f009755bdeb789ac25658ccce03.tar.gz"
    sha256 "0b90e669db80437b106c49536b89a5364b47e6a55d0a0164a8dda5d2dbd2aab0"
  end

  depends_on "bash"
  uses_from_macos "ncurses"

  def install
    flags = ["-std=c89", "-Wno-implicit-int", "-Wno-implicit-function-declaration"]
    if ENV.compiler == :clang
      flags << "-Wno-incompatible-function-pointer-types"
      flags << "-Wno-deprecated-non-prototype"
      flags << "-Wno-return-type"
    end

    binaries = []
    if quiet_system ENV.cc, *flags,
                    "-include", "term.h", "-DCM=cursor_address",
                    "-o", "sl-1985", "src/sl.c", "-lcurses"
      binaries << "sl-1985"
    else
      opoo "Failed to build sl-1985; installing sl-2010 and sl-2023 only"
    end

    system "make", "-C", "src", "sl-2010", "sl-2023", "sl-2026"
    binaries += ["src/sl-2010", "src/sl-2023", "src/sl-2026"]
    (libexec/"sl-classic").install *binaries
    (libexec/"sl-classic").install "src/getoptlong.sh"
    (libexec/"sl-classic").install "src/sl-1985.sh"
    (libexec/"sl-classic").install "src/sl-screen.sh"
    (libexec/"sl-classic").install "src/sl-sweep.sh"
    (libexec/"sl-classic").install "src/lib"
    resource("sl-modern").stage do
      system ENV.cc, "-O", "-Wall", "-o", "sl-modern", "sl.c", "-lncurses"
      (libexec/"sl-classic").install "sl-modern"
    end

    bin.install "src/sl" => "sl"
    man1.install "src/sl.1"
  end

  test do
    assert_predicate bin/"sl", :executable?
    if (libexec/"sl-classic/sl-1985").exist?
      assert_predicate libexec/"sl-classic/sl-1985", :executable?
    end
    assert_predicate libexec/"sl-classic/sl-2010", :executable?
    assert_predicate libexec/"sl-classic/sl-2023", :executable?
    assert_predicate libexec/"sl-classic/sl-2026", :executable?
    assert_predicate libexec/"sl-classic/sl-modern", :executable?
  end
end
