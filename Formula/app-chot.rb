class AppChot < Formula
  desc "Locate and display source of commands and libraries"
  homepage "https://github.com/tecolicom/App-chot"
  url "https://github.com/tecolicom/App-chot/archive/refs/tags/1.01.tar.gz"
  sha256 "8aae6251853b0c479166142ed81956387c4a4be9afba5f223960b8de561da061"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]
  head "https://github.com/tecolicom/App-chot.git", branch: "main"

  depends_on "bat"
  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"chot").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export PATH="#{libexec}/bin:$PATH"
      exec "#{libexec}/bin/chot" "$@"
    SH
    (bin/"chot").chmod 0755

    man1.install Dir[libexec/"man/man1/chot.1"] if (libexec/"man/man1/chot.1").exist?
  end

  test do
    system bin/"chot", "--version"
  end
end
