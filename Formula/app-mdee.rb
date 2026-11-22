class AppMdee < Formula
  desc "em·dee, Markdown Easy on the Eyes"
  homepage "https://github.com/tecolicom/App-mdee"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-mdee-1.25.tar.gz"
  sha256 "1f4e7a26459479fcb8c87aee3344dc7362bbe0a23d547c5e383fd5caff5df434"
  license "MIT"

  depends_on "cpm"
  depends_on "tecolicom/tap/app-nup"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    # nup of app-nup, which runs the less of app-nup
    nup_bin = formula_opt_bin("tecolicom/tap/app-nup")
    (bin/"mdee").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export PATH="#{nup_bin}:#{libexec}/bin:$PATH"
      exec "#{libexec}/bin/mdee" "$@"
    SH
    (bin/"mdee").chmod 0755

    man1.install libexec/"man/man1/mdee.1"
  end

  test do
    system bin/"mdee", "--version"
  end
end
