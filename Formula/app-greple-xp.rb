class AppGrepleXp < Formula
  desc "Greple module for extended pattern handling"
  homepage "https://github.com/kaz-utashiro/greple-xp"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-xp-1.01.tar.gz"
  sha256 "a44268299306a6146eac2411115c83c6c669d1b9f69283cd14d558e02749fd4e"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus" => :build
  depends_on "tecolicom/tap/app-greple"

  def install
    system "cpanm", "--notest", "--installdeps", "."
    system "cpanm", "--notest", "-l", libexec, "."
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mxp", "--version"
  end
end
