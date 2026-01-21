class AppOptex < Formula
  desc "General-purpose command option wrapper"
  homepage "https://github.com/kaz-utashiro/optex"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-1.05.tar.gz"
  sha256 "4443ae9e0774b9a18da54adf7af8224f360b53ce3b9395559156701c999c0287"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--notest", "-l", libexec, "."

    (bin/"optex").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/optex" "$@"
    SH
    (bin/"optex").chmod 0755

    man1.install libexec/"man/man1/optex.1"
  end

  test do
    system bin/"optex", "--version"
  end
end
