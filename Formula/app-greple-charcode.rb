class AppGrepleCharcode < Formula
  desc "Greple module for character code handling"
  homepage "https://github.com/kaz-utashiro/greple-charcode"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-charcode-0.9909.tar.gz"
  sha256 "1e486e33f017a5d57f66a506b7c36fc016d47ed9d02a90b356af54bdab21e966"
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
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mcharcode -e test", "test\n", 0)
  end
end
