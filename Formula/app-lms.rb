class AppLms < Formula
  desc "Language Model Shell - CLI for LLM interaction"
  homepage "https://github.com/kaz-utashiro/App-lms"
  url "https://github.com/kaz-utashiro/App-lms/archive/refs/tags/0.20.tar.gz"
  sha256 "0e3aa28a9dd36f4613e927248e54e1c88152d09278dc865773f8308349441bce"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]
  head "https://github.com/kaz-utashiro/App-lms.git", branch: "main"

  depends_on "bat"
  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

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
