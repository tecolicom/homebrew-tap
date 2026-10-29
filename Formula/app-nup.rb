class AppNup < Formula
  desc "n-up, multi-column paged output for commands and files"
  homepage "https://github.com/tecolicom/App-nup"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-nup-1.09.tar.gz"
  sha256 "d962821365fc6d3705021789a4344ca3cfe0878365452ed24e5667a44dc1f886"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"nup").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export PATH="#{libexec}/bin:$PATH"
      exec "#{libexec}/bin/nup" "$@"
    SH
    (bin/"nup").chmod 0755

    man1.install libexec/"man/man1/nup.1"
  end

  test do
    system bin/"nup", "--version"
  end
end
