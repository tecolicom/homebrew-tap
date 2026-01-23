class AppAnsifold < Formula
  desc "ANSI terminal sequence aware text folding command"
  homepage "https://github.com/tecolicom/App-ansifold"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansifold-1.34.tar.gz"
  sha256 "57ad9ae2318822f57be973458e1c082f48e89c564ed6e712f523567af81148b9"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus"

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpanm", "--notest", "-l", libexec, "."

    (bin/"ansifold").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/ansifold" "$@"
    SH
    (bin/"ansifold").chmod 0755

    man1.install libexec/"man/man1/ansifold.1"
  end

  test do
    system bin/"ansifold", "--version"
  end
end
