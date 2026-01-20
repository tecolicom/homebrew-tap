class AppGrepleXlate < Formula
  desc "Greple module for translation support"
  homepage "https://github.com/kaz-utashiro/App-Greple-xlate"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-xlate-0.9924.tar.gz"
  sha256 "15660c8576766390dbb20e5ccb095c15ed4017ecf7a1e00a28cbf4795e763d99"
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
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mxlate -e test", "test\n", 0)
  end
end
