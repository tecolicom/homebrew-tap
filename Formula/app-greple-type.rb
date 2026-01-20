class AppGrepleType < Formula
  desc "Greple module for file type handling"
  homepage "https://github.com/kaz-utashiro/greple-type"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-type-1.0301.tar.gz"
  sha256 "985c452eff363d2e70b57414c5297258a71f3ec52f7c3dbb745bebfff2b6492e"
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
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mtype -e test", "test\n", 0)
  end
end
