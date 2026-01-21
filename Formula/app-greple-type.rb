class AppGrepleType < Formula
  desc "Greple module for file type handling"
  homepage "https://github.com/kaz-utashiro/greple-type"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-type-1.0301.tar.gz"
  sha256 "985c452eff363d2e70b57414c5297258a71f3ec52f7c3dbb745bebfff2b6492e"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus" => :build
  depends_on "tecolicom/tap/app-greple"

  def install
    system "cpanm", "--notest", "--installdeps", "."
    system "cpanm", "--notest", "-l", libexec, "."
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mtype", "--version"
  end
end
