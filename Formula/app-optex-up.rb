class AppOptexUp < Formula
  desc "optex module for multi-column paged output"
  homepage "https://github.com/kaz-utashiro/optex-up"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-up-1.05.tar.gz"
  sha256 "7d18b3ddabcf63bd68e73e3c0ce2a2632b8baf6405723d9adcffa4e307ab9980"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-optex"

  def install
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-optex"].opt_libexec/"lib/perl5"

    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::optex::up*.3"]
  end

  test do
    system Formula["app-optex"].bin/"optex", "-Mup", "--version"
  end
end
