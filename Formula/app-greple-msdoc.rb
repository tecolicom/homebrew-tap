class AppGrepleMsdoc < Formula
  desc "Greple module to search Microsoft document files"
  homepage "https://github.com/kaz-utashiro/greple-msdoc"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-msdoc-1.07.tar.gz"
  sha256 "0466ceaa5c806b9a5095b4351d1d11561962509bd883caf90d3f832dd90435da"
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
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mmsdoc -e test", "test\n", 0)
  end
end
