class AppSdif < Formula
  desc "Side-by-side diff viewer with ANSI color support"
  homepage "https://github.com/tecolicom/App-sdif"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-sdif-4.45.tar.gz"
  sha256 "926bce678b34f9d0be998a0963b9143d0993610b3e91bf1a05a68a96c2d1a1ab"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

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
