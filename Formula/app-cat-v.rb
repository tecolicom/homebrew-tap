class AppCatV < Formula
  desc "Visualize non-printing characters"
  homepage "https://github.com/tecolicom/App-cat-v"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-cat-v-1.05.tar.gz"
  sha256 "e19a089cbe3aaede725339bf27b4bc7b0eda2c30717a0836deb36ece6d1935f0"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"cat-v").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/cat-v" "$@"
    SH
    (bin/"cat-v").chmod 0755

    man1.install libexec/"man/man1/cat-v.1" if (libexec/"man/man1/cat-v.1").exist?
  end

  test do
    assert_match "visible", shell_output("#{bin}/cat-v --help 2>&1", 1)
  end
end
