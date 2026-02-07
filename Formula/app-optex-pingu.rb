class AppOptexPingu < Formula
  desc "optex make-everything-pingu filter"
  homepage "https://github.com/kaz-utashiro/optex-pingu"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-pingu-1.03.tar.gz"
  sha256 "f934eb4858e3735d800ea057d1822c7257aa51821d0fed0482b9f00dbb246b39"
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
    system Formula["app-optex"].bin/"optex", "-Mpingu", "--version"
  end
end
