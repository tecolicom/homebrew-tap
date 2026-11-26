class AppMdee < Formula
  desc "em·dee, Markdown Easy on the Eyes"
  homepage "https://github.com/tecolicom/App-mdee"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-mdee-1.28.tar.gz"
  sha256 "32d6f58bdd704b98d498e20442e495330fafd5c28e27da4cc61bb10e49ba2d5d"
  license "MIT"
  revision 1

  depends_on "cpm"
  depends_on "tecolicom/tap/app-nup"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    # nup of app-nup, which runs the less of app-nup; mdee checks that
    # less (632 or later) before it shows images, so it has to find the
    # same one
    nup_bin = formula_opt_bin("tecolicom/tap/app-nup")
    nup_less_bin = formula_opt_libexec("tecolicom/tap/app-nup")/"less/bin"
    (bin/"mdee").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export PATH="#{nup_bin}:#{nup_less_bin}:#{libexec}/bin:$PATH"
      exec "#{libexec}/bin/mdee" "$@"
    SH
    (bin/"mdee").chmod 0755

    man1.install libexec/"man/man1/mdee.1"
  end

  test do
    system bin/"mdee", "--version"
  end
end
