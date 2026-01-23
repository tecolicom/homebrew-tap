class AppGrepleUpdate < Formula
  desc "Greple module to update file content"
  homepage "https://github.com/kaz-utashiro/greple-update"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-update-1.04.tar.gz"
  sha256 "4fadb3d1ad4106c365a1740957056be0b3bac9a33c0958afc79c03217f0fe010"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-greple"


  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-greple"].opt_libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::Greple::update*.3"]
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mupdate", "--version"
  end
end
