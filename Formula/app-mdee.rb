class AppMdee < Formula
  desc "Multi-column Markdown viewer with syntax highlighting"
  homepage "https://github.com/tecolicom/App-mdee"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-mdee-0.05.tar.gz"
  sha256 "b1ee81c70aa1bcdbc3b66d989bde74547f6e6315ebd8622a6aa7c203e540ffd7"
  license "MIT"

  depends_on "tecolicom/tap/app-ansicolumn"
  depends_on "tecolicom/tap/app-ansiecho"
  depends_on "tecolicom/tap/app-ansifold"
  depends_on "tecolicom/tap/app-greple"
  depends_on "tecolicom/tap/app-greple-tee"
  depends_on "tecolicom/tap/app-nup"
  depends_on "tecolicom/tap/getopt-long-bash"

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    # Add dependent formulae's PERL5LIB paths
    %w[app-ansicolumn app-ansiecho app-ansifold app-greple app-greple-tee app-nup getopt-long-bash].each do |dep|
      ENV.prepend_path "PERL5LIB", Formula[dep].opt_libexec/"lib/perl5"
    end

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "--installdeps", "."
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "."

    (bin/"mdee").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{ENV["PERL5LIB"]}${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/mdee" "$@"
    SH
    (bin/"mdee").chmod 0755

    man1.install Dir[libexec/"man/man1/*"]
  end

  test do
    system bin/"mdee", "--version"
  end
end
