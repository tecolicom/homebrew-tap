class AppGrepleWordle < Formula
  desc "Greple module for Wordle game"
  homepage "https://github.com/kaz-utashiro/greple-wordle"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-wordle-0.13.tar.gz"
  sha256 "813ba6eb62e8371f7d5402aeae09fcbdd231bba7d56342e261eb1a5278e49054"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus" => :build
  depends_on "tecolicom/tap/app-greple"

  def install
    system "cpanm", "--notest", "--installdeps", "."
    system "cpanm", "--notest", "-l", libexec, "."
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mwordle", "--version"
  end
end
