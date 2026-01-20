class AppGrepleJq < Formula
  desc "Greple module for JSON processing with jq"
  homepage "https://github.com/kaz-utashiro/greple-jq"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-jq-0.06.tar.gz"
  sha256 "033059613bc402cbc2ca2ccc242e205aa2e7b18a25b76ccba15a51012e219069"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "jq"
  depends_on "tecolicom/tap/app-greple"

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", HOMEBREW_PREFIX/"lib/greple/lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--quiet", "--notest", "-l", HOMEBREW_PREFIX/"lib/greple", "--installdeps", "."
    system "perl", "cpanm", "--quiet", "--notest", "-l", HOMEBREW_PREFIX/"lib/greple", "."
  end

  test do
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mjq -e test", '{"test":"value"}', 0)
  end
end
