class AppNup < Formula
  desc "N-up contents-aware page-layout command for paged output"
  homepage "https://github.com/tecolicom/App-nup"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-nup-0.9906.tar.gz"
  sha256 "10efdae9d14a2511550a9b3579873de8cfc0ec292fe2dceaa33c53b17893e5f7"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "--installdeps", "."
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "."

    (bin/"nup").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/nup" "$@"
    SH
    (bin/"nup").chmod 0755

    man1.install libexec/"man/man1/nup.1"
  end

  test do
    system bin/"nup", "--version"
  end
end
