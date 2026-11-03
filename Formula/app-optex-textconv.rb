class AppOptexTextconv < Formula
  desc "optex module to replace document file by its text contents"
  homepage "https://github.com/kaz-utashiro/optex-textconv"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-textconv-1.08.tar.gz"
  sha256 "aa5b4a85f688576aae11a088f331cbac6c2b82d53990a4c2943c0d193b96826d"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-optex"

  def install
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::optex::textconv*.3"]
  end

  test do
    system Formula["app-optex"].bin/"optex", "-Mtextconv", "--version"
  end
end
