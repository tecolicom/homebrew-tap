class AppGrepleUpdate < Formula
  desc "Greple module to update file content"
  homepage "https://github.com/kaz-utashiro/greple-update"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-update-1.04.tar.gz"
  sha256 "4fadb3d1ad4106c365a1740957056be0b3bac9a33c0958afc79c03217f0fe010"
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
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mupdate -e test", "test\n", 0)
  end
end
