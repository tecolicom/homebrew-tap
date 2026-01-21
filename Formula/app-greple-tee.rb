class AppGrepleTee < Formula
  desc "Greple module to tee matched text to external command"
  homepage "https://github.com/kaz-utashiro/greple-tee"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-tee-1.0401.tar.gz"
  sha256 "b86dea7190c1faf4c92600f1930f2b151976551e68c5a923e50e59ef64e01299"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus" => :build
  depends_on "tecolicom/tap/app-greple"

  def install
    system "cpanm", "--notest", "--installdeps", "."
    system "cpanm", "--notest", "-l", libexec, "."
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mtee", "--version"
  end
end
