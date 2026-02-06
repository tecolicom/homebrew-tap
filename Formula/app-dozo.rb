class AppDozo < Formula
  desc "Dozo, Docker with Zero Overhead"
  homepage "https://github.com/tecolicom/App-dozo"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-dozo-1.00.tar.gz"
  sha256 "5637e666268918e850f3aac3465cc158c7cf7a7bed1acb4c70f3b9a2e594b0ea"
  license "MIT"

  depends_on "cpm"
  depends_on "tecolicom/tap/getoptlong-bash"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["getoptlong-bash"].opt_libexec/"lib/perl5"

    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"dozo").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{ENV["PERL5LIB"]}${PERL5LIB:+:$PERL5LIB}"
      export PATH="#{libexec}/bin:$PATH"
      exec "#{libexec}/bin/dozo" "$@"
    SH
    (bin/"dozo").chmod 0755

    man1.install libexec/"man/man1/dozo.1"
  end

  test do
    system bin/"dozo", "--version"
  end
end
