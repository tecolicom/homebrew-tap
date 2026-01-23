class GetoptlongBash < Formula
  desc "Getopt::Long style option parser for Bash scripts"
  homepage "https://github.com/tecolicom/Getopt-Long-Bash"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Getopt-Long-Bash-0.7.1.tar.gz"
  sha256 "edee0e97f9346ea42fd8865b050d510416c46b0a67a3f6cb7b6448d93e56781f"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"


  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

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
