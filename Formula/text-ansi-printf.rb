class TextAnsiPrintf < Formula
  desc "ANSI sequence aware printf command"
  homepage "https://github.com/tecolicom/Text-ANSI-Printf"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Text-ANSI-Printf-2.07.tar.gz"
  sha256 "8be4b96b8a6081e87561725e867b8524b4818290ceb1174156f33aaeac867e46"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "--installdeps", "."
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "."

    (bin/"ansiprintf").write_env_script(libexec/"bin/ansiprintf", PERL5LIB: ENV["PERL5LIB"])
  end

  test do
    system bin/"ansiprintf", "--version"
  end
end
