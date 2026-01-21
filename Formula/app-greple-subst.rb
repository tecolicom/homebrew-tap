class AppGrepleSubst < Formula
  desc "Greple module for text substitution"
  homepage "https://github.com/kaz-utashiro/greple-subst"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-subst-2.37.tar.gz"
  sha256 "90e1c1299e0ff0ffe444a7f1329c3f77e1b72a9cf237b5c542e02e005261c723"
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
    system Formula["app-greple"].opt_bin/"greple", "-Msubst", "--version"
  end
end
