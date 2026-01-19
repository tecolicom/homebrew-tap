class AppGrepleUpdate < Formula
  desc "Greple module to update file content"
  homepage "https://github.com/kaz-utashiro/greple-update"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-update-1.04.tar.gz"
  sha256 "4fadb3d1ad4106c365a1740957056be0b3bac9a33c0958afc79c03217f0fe010"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "tecolicom/tap/app-greple"

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-greple"].opt_libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "--installdeps", "."
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "."
  end

  test do
    ENV["PERL5LIB"] = libexec/"lib/perl5"
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mupdate -e test", "test\n", 0)
  end
end
