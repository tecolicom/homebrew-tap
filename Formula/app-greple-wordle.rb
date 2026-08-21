class AppGrepleWordle < Formula
  desc "Greple module for Wordle game"
  homepage "https://github.com/kaz-utashiro/greple-wordle"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-wordle-0.13.tar.gz"
  sha256 "813ba6eb62e8371f7d5402aeae09fcbdd231bba7d56342e261eb1a5278e49054"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]
  revision 1

  depends_on "cpm"
  depends_on "tecolicom/tap/app-greple"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    # Bit::Vector 7.4, pulled in by Date::Calc, declares "enum { false,
    # true }", which C23 rejects since those became keywords.  GCC 15 and
    # later default to C23.  MakeMaker builds XS with $Config{optimize},
    # not CFLAGS, so override it here.  The backslash keeps MakeMaker
    # from splitting the value on the space.
    ENV["PERL_MM_OPT"] = "OPTIMIZE=-O2\\ -std=gnu17"

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::Greple::wordle*.3"]
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mwordle", "--version"
  end
end
