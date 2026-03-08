class SlClassic < Formula
  desc "sl runs across your terminal when you type sl"
  homepage "https://github.com/tecolicom/sl"
  url "https://github.com/tecolicom/sl/archive/refs/tags/v2026.5.tar.gz"
  sha256 "5d9768f17ec9f07fc221b9410da55af2ff089a9bd8b0c6d70f8f81207ae4226e"
  license "BSD-2-Clause"
  version "2026.5"

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
    (libexec/"sl-classic").install "src/sl-screen.sh"
    (libexec/"sl-classic").install "src/sl-sweep.sh"
    (libexec/"sl-classic").install "src/lib"
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
  end
end
