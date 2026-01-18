class AppAnsiTools < Formula
  desc "ANSI terminal sequence aware text processing tools"
  homepage "https://github.com/tecolicom"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansicolumn-1.50.tar.gz"
  sha256 "4696cd85d8d41fc2c1246b071d138e636d4766e0eb0a112a8273bd7d9af5c90f"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]
  version "1.0"

  depends_on "tecolicom/tap/app-ansicolumn"
  depends_on "tecolicom/tap/app-ansifold"
  depends_on "tecolicom/tap/app-ansiecho"
  depends_on "tecolicom/tap/text-ansi-printf"

  def install
    (prefix/"README").write <<~EOS
      This is a meta-package that installs all ANSI tools:
      - ansicolumn, ansicolrm, ansicut (from app-ansicolumn)
      - ansifold (from app-ansifold)
      - ansiecho (from app-ansiecho)
      - ansiprintf (from text-ansi-printf)
    EOS
  end

  test do
    system Formula["app-ansicolumn"].bin/"ansicolumn", "--version"
  end
end
