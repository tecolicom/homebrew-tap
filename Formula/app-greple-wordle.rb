class AppGrepleWordle < Formula
  desc "Greple module for Wordle game"
  homepage "https://github.com/kaz-utashiro/greple-wordle"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-wordle-0.13.tar.gz"
  sha256 "813ba6eb62e8371f7d5402aeae09fcbdd231bba7d56342e261eb1a5278e49054"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "tecolicom/tap/app-greple"

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", HOMEBREW_PREFIX/"lib/greple/lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--quiet", "--notest", "-l", HOMEBREW_PREFIX/"lib/greple", "--installdeps", "."
    system "perl", "cpanm", "--quiet", "--notest", "-l", HOMEBREW_PREFIX/"lib/greple", "."
  end

  test do
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mwordle -e test", "test\n", 0)
  end
end
