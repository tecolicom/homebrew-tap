class AppGreplePw < Formula
  desc "Greple module for password handling"
  homepage "https://github.com/kaz-utashiro/greple-pw"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-pw-1.02.tar.gz"
  sha256 "c8bcf11b2cc0f8fe08d01ed20d08314e32bf4a69a7f447b19ff0495d9d954c7d"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-greple"


  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-greple"].opt_libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::Greple::pw*.3"]
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mpw", "--version"
  end
end
