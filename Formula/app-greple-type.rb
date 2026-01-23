class AppGrepleType < Formula
  desc "Greple module for file type handling"
  homepage "https://github.com/kaz-utashiro/greple-type"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-type-1.0301.tar.gz"
  sha256 "985c452eff363d2e70b57414c5297258a71f3ec52f7c3dbb745bebfff2b6492e"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-greple"


  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-greple"].opt_libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::Greple::type*.3"]
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mtype", "--version"
  end
end
