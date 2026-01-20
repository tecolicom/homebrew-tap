class AppGrepleTee < Formula
  desc "Greple module to tee matched text to external command"
  homepage "https://github.com/kaz-utashiro/greple-tee"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-tee-1.0401.tar.gz"
  sha256 "b86dea7190c1faf4c92600f1930f2b151976551e68c5a923e50e59ef64e01299"
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
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mtee -e test", "test\n", 0)
  end
end
