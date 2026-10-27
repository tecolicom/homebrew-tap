class AppGrepleXlate < Formula
  desc "Greple module for translation support"
  homepage "https://github.com/kaz-utashiro/App-Greple-xlate"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-xlate-2.03.tar.gz"
  sha256 "81947b72ecbaf5f1fbb1a1ffe48ec2a6a77f271f934091a3fdd6b3967353cfef"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-greple"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"xlate").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export PATH="#{libexec}/bin:$PATH"
      exec "#{libexec}/bin/xlate" "$@"
    SH
    (bin/"xlate").chmod 0755

    man1.install libexec/"man/man1/xlate.1"
    man3.install Dir[libexec/"man/man3/App::Greple::xlate*.3"]
  end

  test do
    system bin/"xlate", "--version"
  end
end
