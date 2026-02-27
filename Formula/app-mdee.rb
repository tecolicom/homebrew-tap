class AppMdee < Formula
  desc "em·dee, Markdown Easy on the Eyes"
  homepage "https://github.com/tecolicom/App-mdee"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-mdee-1.0501.tar.gz"
  sha256 "c9113bd5cd5c4832583c78f8aff75d8483760d393d0e2eef7e6f7a1e0eabfa44"
  license "MIT"

  depends_on "cpm"
  depends_on "tecolicom/tap/app-nup"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"mdee").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export PATH="#{libexec}/bin:$PATH"
      exec "#{libexec}/bin/mdee" "$@"
    SH
    (bin/"mdee").chmod 0755

    man1.install libexec/"man/man1/mdee.1"
  end

  test do
    system bin/"mdee", "--version"
  end
end
