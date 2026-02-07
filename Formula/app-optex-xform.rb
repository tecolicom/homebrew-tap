class AppOptexXform < Formula
  desc "data transform filter module for optex"
  homepage "https://github.com/kaz-utashiro/optex-xform"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-xform-1.05.tar.gz"
  sha256 "35ce207e9b4dd941d79d67cce8b850b1347ba3d643737b717490e610d8feec2d"
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
    system Formula["app-optex"].bin/"optex", "-Mxform", "--version"
  end
end
