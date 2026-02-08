class AppOptexTextconv < Formula
  desc "optex module to replace document file by its text contents"
  homepage "https://github.com/kaz-utashiro/optex-textconv"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-textconv-1.07.tar.gz"
  sha256 "a3f7571fd6e61ee9bccfa1b1066023c17ee903b392ec80861c6e788445f53e3e"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-optex"

  def install
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::optex::textconv*.3"]
  end

  test do
    system Formula["app-optex"].bin/"optex", "-Mtextconv", "--version"
  end
end
