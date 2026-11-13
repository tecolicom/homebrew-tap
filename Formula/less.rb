class Less < Formula
  desc "Pager less with --align-record to snap search results to record boundaries"
  homepage "https://github.com/kaz-utashiro/less"
  url "https://github.com/kaz-utashiro/less/archive/124faabbbfa3dd85b974e55d7f8622134fd099d1.tar.gz"
  version "713x"
  sha256 "a67209a91057ce0075258b45e2499d7aa9d8dacc92c07fc9d60fc17de8f5cf34"
  license any_of: ["GPL-3.0-or-later", "BSD-2-Clause"]

  depends_on "autoconf" => :build
  uses_from_macos "ncurses"

  conflicts_with "less", because: "both install a `less` binary"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    # A git checkout lacks files that are pre-generated in release tarballs:
    # funcs.h, help.c, lessmsg.inc, the nroff man pages, and the configure
    # script.
    # Unset SOURCE_DATE_EPOCH for this step: the man-page rule feeds it to
    # `date -d@`, which macOS's BSD date rejects, blanking the man date.
    with_env(SOURCE_DATE_EPOCH: nil) do
      system "make", "-f", "Makefile.aut", "funcs.h", "help.c", "lessmsg.inc",
             "less.nro", "lesskey.nro", "lessecho.nro"
    end
    system "autoheader"
    system "autoconf"

    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "less", shell_output("#{bin}/less --version")
    # --align-record is accepted (an unknown option would error out)
    system bin/"less", "--align-record=10", "-V"
  end
end
