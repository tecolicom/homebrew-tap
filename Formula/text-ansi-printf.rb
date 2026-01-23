class TextAnsiPrintf < Formula
  desc "ANSI sequence aware printf command"
  homepage "https://github.com/tecolicom/Text-ANSI-Printf"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Text-ANSI-Printf-2.07.tar.gz"
  sha256 "8be4b96b8a6081e87561725e867b8524b4818290ceb1174156f33aaeac867e46"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"


  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"ansiprintf").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/ansiprintf" "$@"
    SH
    (bin/"ansiprintf").chmod 0755

    man1.install libexec/"man/man1/ansiprintf.1"
  end

  test do
    system bin/"ansiprintf", "--version"
  end
end
