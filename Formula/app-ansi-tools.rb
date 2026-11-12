class AppAnsiTools < Formula
  desc "ANSI terminal sequence aware text processing tools"
  homepage "https://github.com/tecolicom"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansicolumn-1.6201.tar.gz"
  sha256 "8e6f7608e864826997e2ccd83402f578b226c8408c13491711577e0d2f68091d"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  resource "App-ansiecho" do
    url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansiecho-1.10.tar.gz"
    sha256 "112fd52803e5f40be216baff3105e2c01dd9a44d0a152e42e9e4a389418fcc6e"
  end

  resource "App-ansifold" do
    url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansifold-1.38.tar.gz"
    sha256 "ce72dda301db782b37d3e524f97b32db3b253f732b377149d41899b6dc457e5e"
  end

  resource "Text-ANSI-Printf" do
    url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Text-ANSI-Printf-2.07.tar.gz"
    sha256 "8be4b96b8a6081e87561725e867b8524b4818290ceb1174156f33aaeac867e46"
  end

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    # Install main formula (App-ansicolumn)
    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    # Install additional resources
    resources.each do |r|
      r.stage do
        system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."
      end
    end

    # Create wrapper scripts for all commands
    %w[ansicolumn ansiecho ansifold ansicut ansicolrm ansiprintf].each do |cmd|
      (bin/cmd).write <<~SH
        #!/bin/bash
        export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
        exec "#{libexec}/bin/#{cmd}" "$@"
      SH
      (bin/cmd).chmod 0755
    end

    man1.install Dir[libexec/"man/man1/{ansicolumn,ansiecho,ansifold,ansicut,ansicolrm,ansiprintf}.1"]
  end

  test do
    system bin/"ansicolumn", "--version"
    system bin/"ansiecho", "--version"
    system bin/"ansifold", "--version"
    system bin/"ansiprintf", "--version"
  end
end
