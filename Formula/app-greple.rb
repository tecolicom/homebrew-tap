class AppGreple < Formula
  desc "Extensible grep with lexical expression and region handling"
  homepage "https://github.com/kaz-utashiro/greple"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-10.02.tar.gz"
  sha256 "56b73445b31a53499ff5b5a997f701ba1bb9e445978c1c6a03fa93f34a3fb624"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--notest", "--installdeps", "."
    system "perl", "cpanm", "--notest", "-l", libexec, "."

    (bin/"greple").write_env_script(libexec/"bin/greple", PERL5LIB: ENV["PERL5LIB"])
  end

  test do
    system bin/"greple", "--version"
  end
end
