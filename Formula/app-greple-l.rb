class AppGrepleL < Formula
  desc "Greple module for line number handling"
  homepage "https://github.com/kaz-utashiro/greple-L"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-L-1.01.tar.gz"
  sha256 "6f218eee336f4f51d8c56d4c058ebf121d4ebccb177188267b99bd79dc4aa9c0"
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
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -ML -e test", "test\n", 0)
  end
end
