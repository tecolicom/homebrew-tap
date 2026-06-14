class Less < Formula
  desc "Pager less with --page-align (aligned search results and line jumps)"
  homepage "https://github.com/kaz-utashiro/less"
  url "https://github.com/kaz-utashiro/less/archive/d1addda8f114824eac63c99a401b87237e33a916.tar.gz"
  version "705x"
  sha256 "4d928d8c9bf499339cb582267f216100a6824dde30374032e524cb32c59b06b1"
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
