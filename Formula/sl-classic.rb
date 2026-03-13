class SlClassic < Formula
  desc "sl runs across your terminal when you type sl"
  homepage "https://github.com/tecolicom/sl"
  url "https://github.com/tecolicom/sl/archive/refs/tags/v2026.8.1.tar.gz"
  sha256 "138c031027f1eed7364b2c35e04bdd9538493b70ef4dd210596c5bc6c770863e"
  license "BSD-2-Clause"
  version "2026.8.1"

  resource "sl-1992" do
    url "https://github.com/mtoyoda/sl/archive/923e7d7ebc5c1f009755bdeb789ac25658ccce03.tar.gz"
    sha256 "0b90e669db80437b106c49536b89a5364b47e6a55d0a0164a8dda5d2dbd2aab0"
  end

  depends_on "bash"
  uses_from_macos "ncurses"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

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

    # Install Perl dependencies into Cellar
    system "curl", "-sL", "https://cpanmin.us/", "-o", buildpath/"cpanm"
    system "perl", buildpath/"cpanm", "--notest",
           "-l", libexec/"sl-classic/perl5", "--installdeps", buildpath/"src"

    resource("sl-1992").stage do
      system ENV.cc, "-O", "-Wall", "-o", "sl-1992", "sl.c", "-lncurses"
      (libexec/"sl-classic").install "sl-1992"
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
    assert_predicate libexec/"sl-classic/sl-1992", :executable?
  end
end
