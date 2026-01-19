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
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "--installdeps", "."
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "."

    (bin/"greple").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/greple" "$@"
    SH
    (bin/"greple").chmod 0755

    man1.install libexec/"man/man1/greple.1"
  end

  test do
    pipe_output("#{bin}/greple -e test", "test\n", 0)
  end
end
