class AppGrepleWordle < Formula
  desc "Greple module for Wordle game"
  homepage "https://github.com/kaz-utashiro/greple-wordle"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-wordle-1.00.tar.gz"
  sha256 "02c12616dddd3c6428e9188c38cb638305c13627d27d996c0e7a5d6c21afbc1e"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

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
