class AppSdif < Formula
  desc "Side-by-side diff viewer with ANSI color support"
  homepage "https://github.com/tecolicom/App-sdif"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-sdif-4.41.tar.gz"
  sha256 "1516f3c863ad19c3b5a3e074d0480f422b73d3ab647dd3f589f0c0602bc0190c"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "--installdeps", "."
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "."

    %w[sdif cdif watchdiff].each do |cmd|
      (bin/cmd).write <<~SH
        #!/bin/bash
        export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
        exec "#{libexec}/bin/#{cmd}" "$@"
      SH
      (bin/cmd).chmod 0755
    end

    man1.install Dir[libexec/"man/man1/{sdif,cdif,watchdiff}.1"]
  end

  test do
    pipe_output("#{bin}/sdif", "test\n", 0)
  end
end
