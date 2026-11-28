class AppAnsiTools < Formula
  desc "ANSI terminal sequence aware text processing tools"
  homepage "https://github.com/tecolicom"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansicolumn-1.73.tar.gz"
  version "1.730000"
  sha256 "b4b4df5d75509f0ba6b98624be3674c8b84cccb16797b7a5523d2af97337c6e4"
  revision 1
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  resource "App-ansiecho" do
    url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansiecho-1.10.tar.gz"
    sha256 "112fd52803e5f40be216baff3105e2c01dd9a44d0a152e42e9e4a389418fcc6e"
  end

  resource "App-ansifold" do
    url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansifold-1.39.tar.gz"
    sha256 "2baf3319ab887b2cb1a2c4d8d5c69ed8c04a1c78dbd71c0ace05ced600431bdd"
  end

  resource "Text-ANSI-Image" do
    url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Text-ANSI-Image-0.03.tar.gz"
    sha256 "de20cdec22ba9cebdbbd07a4e3ba6e58edb56463693f2c7763e540e1dcc2e473"
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
    %w[ansicolumn ansiecho ansifold ansicut ansicolrm ansiprintf ansipic].each do |cmd|
      (bin/cmd).write <<~SH
        #!/bin/bash
        export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
        exec "#{libexec}/bin/#{cmd}" "$@"
      SH
      (bin/cmd).chmod 0755
    end

    man1.install Dir[libexec/"man/man1/{ansicolumn,ansiecho,ansifold,ansicut,ansicolrm,ansiprintf,ansipic}.1"]
  end

  test do
    system bin/"ansicolumn", "--version"
    system bin/"ansiecho", "--version"
    system bin/"ansifold", "--version"
    system bin/"ansiprintf", "--version"
    system bin/"ansipic", "--version"
  end
end
