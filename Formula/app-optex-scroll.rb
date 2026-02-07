class AppOptexScroll < Formula
  desc "optex scroll region module"
  homepage "https://github.com/kaz-utashiro/optex-scroll"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-scroll-0.9902.tar.gz"
  sha256 "178c61ea5e3273021e44054b42626343887df6afb3755a33f7d6054bd6236ff9"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-optex"

  def install
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-optex"].opt_libexec/"lib/perl5"

    system "cpm", "install", "--home", buildpath.parent/".cpm", "-L", libexec, "."
  end

  test do
    system Formula["app-optex"].bin/"optex", "-Mscroll", "--version"
  end
end
