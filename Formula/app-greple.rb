class AppGreple < Formula
  desc "Extensible grep with lexical expression and region handling"
  homepage "https://github.com/kaz-utashiro/greple"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-10.03.tar.gz"
  sha256 "ace2ce01a766c937fb87da72249e0e8534148395e2ea14e9d05a2f80eb5358ce"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus" => :build
  depends_on "perl"

  def install
    system "cpanm", "--notest", "--installdeps", "."
    system "cpanm", "--notest", "-l", libexec, "."
    bin.install_symlink Dir["#{libexec}/bin/*"]
    man1.install libexec/"man/man1/greple.1"
  end

  test do
    system bin/"greple", "--version"
  end
end
