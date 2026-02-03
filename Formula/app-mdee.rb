class AppMdee < Formula
  desc "Multi-column Markdown viewer with syntax highlighting"
  homepage "https://github.com/tecolicom/App-mdee"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-mdee-0.10.tar.gz"
  sha256 "f1422077f92ed62bc249431059926a55bf40109587fc235c4cdf0f4d7f98c43d"
  license "MIT"

  depends_on "cpm"
  depends_on "tecolicom/tap/app-ansi-tools"
  depends_on "tecolicom/tap/app-greple"
  depends_on "tecolicom/tap/app-nup"
  depends_on "tecolicom/tap/getoptlong-bash"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    # Add dependent formulae's PERL5LIB paths
    %w[app-ansi-tools app-greple app-nup getoptlong-bash].each do |dep|
      ENV.prepend_path "PERL5LIB", Formula[dep].opt_libexec/"lib/perl5"
    end

    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"mdee").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{ENV["PERL5LIB"]}${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/mdee" "$@"
    SH
    (bin/"mdee").chmod 0755

    man1.install libexec/"man/man1/mdee.1"
  end

  test do
    system bin/"mdee", "--version"
  end
end
