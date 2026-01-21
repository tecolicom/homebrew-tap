class AppGrepleUpdate < Formula
  desc "Greple module to update file content"
  homepage "https://github.com/kaz-utashiro/greple-update"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-update-1.04.tar.gz"
  sha256 "4fadb3d1ad4106c365a1740957056be0b3bac9a33c0958afc79c03217f0fe010"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus" => :build
  depends_on "tecolicom/tap/app-greple"

  def install
    system "cpanm", "--notest", "--installdeps", "."
    system "cpanm", "--notest", "-l", libexec, "."
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mupdate", "--version"
  end
end
