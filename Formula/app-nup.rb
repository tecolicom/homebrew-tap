class AppNup < Formula
  desc "n-up, multi-column paged output for commands and files"
  homepage "https://github.com/tecolicom/App-nup"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-nup-1.24.tar.gz"
  sha256 "d4b805ee79d6e0bf16cdbbaf631bf622668eaa57fa0ff6d4dd32e33b3acbf049"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]
  # rebuilt for App::ansicolumn 1.72, which keeps the rows of a table
  # of mdee from being divided between panes
  revision 2

  depends_on "autoconf" => :build
  depends_on "cpm"
  # The highlighter of files, by default since 1.20, and that of the
  # code blocks of mdee.  It has no bottle on Intel macOS and on Sonoma
  # or older, where it is built with GHC: nup works without it, with no
  # colors (--without-pandoc).
  depends_on "pandoc" => :recommended
  uses_from_macos "ncurses"

  # The less of this tap, for nup alone: it is put in libexec/less, not
  # linked, so it does not conflict with the less of Homebrew.  Keep it
  # the same as Formula/less.rb.
  resource "less" do
    url "https://github.com/kaz-utashiro/less/archive/82a7a5e7c5245bac3fcd78b6f3f2757bef9602dc.tar.gz"
    version "713x.5"
    sha256 "a24607e35764444fdbcc82afb4f9b917a6ddaaa8a7f8aa27f343f140deb36859"
  end

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    # Built as in Formula/less.rb
    resource("less").stage do
      with_env(SOURCE_DATE_EPOCH: nil) do
        system "make", "-f", "Makefile.aut", "funcs.h", "help.c", "lessmsg.inc",
               "less.nro", "lesskey.nro", "lessecho.nro"
      end
      system "autoheader"
      system "autoconf"
      system "./configure", "--prefix=#{libexec}/less"
      system "make"
      system "make", "install"
    end

    (bin/"nup").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export PATH="#{libexec}/less/bin:#{libexec}/bin:$PATH"
      exec "#{libexec}/bin/nup" "$@"
    SH
    (bin/"nup").chmod 0755

    man1.install libexec/"man/man1/nup.1"
  end

  test do
    system bin/"nup", "--version"
    # nup finds the less of libexec/less, which has --align-shift
    system libexec/"less/bin/less", "--align-shift", "-V"
  end
end
