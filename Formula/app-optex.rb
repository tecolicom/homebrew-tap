class AppOptex < Formula
  desc "General-purpose command option wrapper"
  homepage "https://github.com/kaz-utashiro/optex"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-1.07.tar.gz"
  sha256 "1afb21931da089179ae44e660d6cfb80ce29a11ca013d0227e236189a8ad8c3b"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"optex").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      for dir in "#{HOMEBREW_PREFIX}/opt"/app-optex-*/libexec/lib/perl5; do
        [ -d "$dir" ] && PERL5LIB="$dir:$PERL5LIB"
      done
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
