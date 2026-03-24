class AppSdif < Formula
  desc "Side-by-side diff viewer with ANSI color support"
  homepage "https://github.com/tecolicom/App-sdif"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-sdif-4.4501.tar.gz"
  sha256 "67838f74943de44b739db975ba4a946d5b9d4ea96064f43be93ca4e10cf394f0"
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
