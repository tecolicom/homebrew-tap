class AppAnsiecho < Formula
  desc "Echo command with ANSI terminal code support"
  homepage "https://github.com/tecolicom/App-ansiecho"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansiecho-1.10.tar.gz"
  sha256 "112fd52803e5f40be216baff3105e2c01dd9a44d0a152e42e9e4a389418fcc6e"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--notest", "-l", libexec, "."

    (bin/"ansiecho").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/ansiecho" "$@"
    SH
    (bin/"ansiecho").chmod 0755

    man1.install libexec/"man/man1/ansiecho.1"
  end

  test do
    system bin/"ansiecho", "--version"
  end
end
