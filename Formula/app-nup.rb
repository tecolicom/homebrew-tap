class AppNup < Formula
  desc "N-up contents-aware page-layout command for paged output"
  homepage "https://github.com/tecolicom/App-nup"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-nup-0.9906.tar.gz"
  sha256 "10efdae9d14a2511550a9b3579873de8cfc0ec292fe2dceaa33c53b17893e5f7"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-ansicolumn"
  depends_on "tecolicom/tap/app-optex"
  depends_on "tecolicom/tap/getoptlong-bash"


  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    # Add dependent formulae's PERL5LIB paths
    %w[app-ansicolumn app-optex getoptlong-bash].each do |dep|
      ENV.prepend_path "PERL5LIB", Formula[dep].opt_libexec/"lib/perl5"
    end

    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    (bin/"nup").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{ENV["PERL5LIB"]}${PERL5LIB:+:$PERL5LIB}"
      exec "#{libexec}/bin/nup" "$@"
    SH
    (bin/"nup").chmod 0755

    man1.install libexec/"man/man1/nup.1"
  end

  test do
    system bin/"nup", "--version"
  end
end
