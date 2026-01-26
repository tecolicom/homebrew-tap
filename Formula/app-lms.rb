class AppLms < Formula
  desc "Language Model Shell - CLI for LLM interaction"
  homepage "https://github.com/kaz-utashiro/App-lms"
  url "https://github.com/kaz-utashiro/App-lms/archive/refs/tags/0.15.tar.gz"
  sha256 "035c0eb83b87232c811d70aadb0acaf923b9050e7b44ff747c979fac916d9c6e"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]
  head "https://github.com/kaz-utashiro/App-lms.git", branch: "main"

  depends_on "bat"
  depends_on "cpm"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"lms").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export LMS_SCRIPT_PATH="#{libexec}/bin/lms"
      exec "#{libexec}/bin/lms" "$@"
    SH
    (bin/"lms").chmod 0755

    man1.install Dir[libexec/"man/man1/lms.1"] if (libexec/"man/man1/lms.1").exist?
  end

  test do
    system bin/"lms", "--version"
  end
end
