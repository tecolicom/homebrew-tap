class AppGrepleFrame < Formula
  desc "Greple module to display text in decorative frame"
  homepage "https://github.com/kaz-utashiro/greple-frame"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-frame-1.03.tar.gz"
  sha256 "b3848df3d7c570825f8743448517d34d07c02ff84143cfee82b972627eea9e4b"
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
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mframe -e test", "test\n", 0)
  end
end
