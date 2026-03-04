class AppWeek < Formula
  desc "Colorful calendar command with ANSI color support"
  homepage "https://github.com/kaz-utashiro/App-week"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-week-1.07.tar.gz"
  sha256 "6a4fcb32b6f5eb63ffece5cfe6aba10252889f7b0b5372b1f92b7334ff1a7425"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"week").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export PATH="#{libexec}/bin:$PATH"
      exec "#{libexec}/bin/week" "$@"
    SH
    (bin/"week").chmod 0755

    man1.install Dir[libexec/"man/man1/week.1"]
  end

  test do
    system bin/"week", "--version"
  end
end
