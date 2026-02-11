class GetoptlongBash < Formula
  desc "Getopt::Long style option parser for Bash scripts"
  homepage "https://github.com/tecolicom/Getopt-Long-Bash"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Getopt-Long-Bash-0.7.2.tar.gz"
  sha256 "f44f31b2020d00d5b880e588c719c528ba360d045e0274e30726bad6f4a43939"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "bash"
  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"getoptlong").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/getoptlong" "$@"
    SH
    (bin/"getoptlong").chmod 0755
    bin.install_symlink libexec/"bin/getoptlong.sh"

    man1.install Dir[libexec/"man/man1/getoptlong*.1"]
  end

  test do
    system bin/"getoptlong", "--version"
  end
end
