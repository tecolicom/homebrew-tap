class AppGrepleTee < Formula
  desc "Greple module to tee matched text to external command"
  homepage "https://github.com/kaz-utashiro/greple-tee"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-tee-1.0401.tar.gz"
  sha256 "b86dea7190c1faf4c92600f1930f2b151976551e68c5a923e50e59ef64e01299"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-greple"


  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-greple"].opt_libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mtee", "--version"
  end
end
