class AppSdif < Formula
  desc "Side-by-side diff viewer with ANSI color support"
  homepage "https://github.com/tecolicom/App-sdif"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-sdif-4.43.tar.gz"
  sha256 "681c500fc56cb9cee083b82c52bf53d0305edba206c66629a5077937376373ac"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    %w[sdif cdif watchdiff].each do |cmd|
      (bin/cmd).write <<~SH
        #!/bin/bash
        export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
        export PATH="#{libexec}/bin:$PATH"
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
