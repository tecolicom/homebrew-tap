class AppGrepleFrame < Formula
  desc "Greple module to display text in decorative frame"
  homepage "https://github.com/kaz-utashiro/greple-frame"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-frame-1.03.tar.gz"
  sha256 "b3848df3d7c570825f8743448517d34d07c02ff84143cfee82b972627eea9e4b"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-greple"


  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-greple"].opt_libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::Greple::frame*.3"]
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mframe", "--version"
  end
end
