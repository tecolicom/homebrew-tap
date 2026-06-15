class Less < Formula
  desc "Pager less with --align-record to snap search results to record boundaries"
  homepage "https://github.com/kaz-utashiro/less"
  url "https://github.com/kaz-utashiro/less/archive/6ada0b5bb1102271d24664b0022bca4747b0062f.tar.gz"
  version "705x"
  sha256 "ce091a2ca5bebfce236b12957fcb80d13dfd19f1797f99059a796544a2ef16ed"
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
    # --align-record is accepted (an unknown option would error out)
    system bin/"less", "--align-record=10", "-V"
  end
end
