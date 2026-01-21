class AppGrepleL < Formula
  desc "Greple module for line number handling"
  homepage "https://github.com/kaz-utashiro/greple-L"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-L-1.01.tar.gz"
  sha256 "6f218eee336f4f51d8c56d4c058ebf121d4ebccb177188267b99bd79dc4aa9c0"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"
  depends_on "tecolicom/tap/app-greple"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-greple"].opt_libexec/"lib/perl5"
    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--notest", "-l", libexec, "."
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-ML", "--version"
  end
end
