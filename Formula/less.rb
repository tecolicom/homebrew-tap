class Less < Formula
  desc "Pager less with --page-align (aligned search results and line jumps)"
  homepage "https://github.com/kaz-utashiro/less"
  url "https://github.com/kaz-utashiro/less/archive/c0b2314a5b208e6d4afe8d103d9372451a5c0dd2.tar.gz"
  version "705x"
  sha256 "28543245849955555ace96c922b1e277f0749d9eb376a6bc0b70e3ed0df06e58"
  license any_of: ["GPL-3.0-or-later", "BSD-2-Clause"]

  depends_on "autoconf" => :build
  uses_from_macos "ncurses"

  conflicts_with "less", because: "both install a `less` binary"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    # A git checkout lacks files that are pre-generated in release tarballs:
    # funcs.h, help.c, the nroff man pages, and the configure script.
    system "make", "-f", "Makefile.aut", "funcs.h", "help.c",
           "less.nro", "lesskey.nro", "lessecho.nro"
    system "autoheader"
    system "autoconf"

    system "./configure", "--prefix=#{prefix}"
    system "make"

    bin.install "less", "lesskey", "lessecho"
    man1.install "less.nro"     => "less.1",
                 "lesskey.nro"  => "lesskey.1",
                 "lessecho.nro" => "lessecho.1"
  end

  test do
    assert_match "less", shell_output("#{bin}/less --version")
    # --page-align is accepted (an unknown option would error out)
    system bin/"less", "--page-align=10", "-V"
  end
end
