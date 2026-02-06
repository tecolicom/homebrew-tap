class AppOptex < Formula
  desc "General-purpose command option wrapper"
  homepage "https://github.com/kaz-utashiro/optex"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-1.0601.tar.gz"
  sha256 "4c5989a62deabae2116064ae77c5630ef9e3908988fbc8216af2742202174827"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"optex").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export PATH="#{libexec}/bin:$PATH"
      export OPTEX_SCRIPT_PATH="#{HOMEBREW_PREFIX}/bin/optex"
      export OPTEX_INVOKED_AS="$0"
      exec "#{libexec}/bin/optex" "$@"
    SH
    (bin/"optex").chmod 0755

    man1.install libexec/"man/man1/optex.1"
  end

  test do
    system bin/"optex", "--version"
  end
end
