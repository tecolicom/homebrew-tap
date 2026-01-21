class AppGrepleXlate < Formula
  desc "Greple module for translation support"
  homepage "https://github.com/kaz-utashiro/App-Greple-xlate"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-xlate-0.9924.tar.gz"
  sha256 "15660c8576766390dbb20e5ccb095c15ed4017ecf7a1e00a28cbf4795e763d99"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus" => :build
  depends_on "tecolicom/tap/app-greple"

  def install
    system "cpanm", "--notest", "--installdeps", "."
    system "cpanm", "--notest", "-l", libexec, "."
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mxlate", "--version"
  end
end
