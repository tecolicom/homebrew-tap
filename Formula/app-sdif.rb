class AppSdif < Formula
  desc "Side-by-side diff viewer with ANSI color support"
  homepage "https://github.com/tecolicom/App-sdif"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-sdif-4.42.tar.gz"
  sha256 "6651937c6af9a7e51f160a7ed51a1a5fc448cbfbe4299b09961cd497b3f1b189"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus" => :build
  depends_on "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpanm", "--notest", "-l", libexec, "."

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
    system bin/"sdif", "--version"
  end
end
