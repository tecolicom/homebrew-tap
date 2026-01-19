class AppGrepleXp < Formula
  desc "Greple module for extended pattern handling"
  homepage "https://github.com/kaz-utashiro/greple-xp"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-xp-1.01.tar.gz"
  sha256 "a44268299306a6146eac2411115c83c6c669d1b9f69283cd14d558e02749fd4e"
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
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mxp -e test", "test\n", 0)
  end
end
