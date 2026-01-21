class AppAnsicolumn < Formula
  desc "ANSI terminal sequence aware column command"
  homepage "https://github.com/tecolicom/App-ansicolumn"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansicolumn-1.50.tar.gz"
  sha256 "4696cd85d8d41fc2c1246b071d138e636d4766e0eb0a112a8273bd7d9af5c90f"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--notest", "-l", libexec, "."

    %w[ansicolumn ansicolrm ansicut].each do |cmd|
      (bin/cmd).write <<~SH
        #!/bin/bash
        export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
        exec "#{libexec}/bin/#{cmd}" "$@"
      SH
      (bin/cmd).chmod 0755
    end

    man1.install libexec/"man/man1/ansicolumn.1"
  end

  test do
    system bin/"ansicolumn", "--version"
  end
end
