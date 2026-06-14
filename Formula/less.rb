class Less < Formula
  desc "Pager less with --page-align to snap search results to record boundaries"
  homepage "https://github.com/kaz-utashiro/less"
  url "https://github.com/kaz-utashiro/less/archive/cf64e98cdadacbde98324d9c502a2f181b8a8260.tar.gz"
  version "705x"
  sha256 "c86dc44544ecfb9b1a4ef21aff5dcedff539a303b21622e09e24ded410e6377b"
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
    # Unset SOURCE_DATE_EPOCH for this step: the man-page rule feeds it to
    # `date -d@`, which macOS's BSD date rejects, blanking the man date.
    with_env(SOURCE_DATE_EPOCH: nil) do
      system "make", "-f", "Makefile.aut", "funcs.h", "help.c",
             "less.nro", "lesskey.nro", "lessecho.nro"
    end
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
