class AppGrepleGit < Formula
  desc "Greple module for git integration"
  homepage "https://github.com/kaz-utashiro/greple-git"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-git-1.00.tar.gz"
  sha256 "46c2f0eee12645186337b600ce0595da0d996760da7632a0708d9382d4bb48ff"
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
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mgit -e test", "test\n", 0)
  end
end
