class AppAnsiTools < Formula
  desc "ANSI terminal sequence aware text processing tools"
  homepage "https://github.com/tecolicom"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansicolumn-1.50.tar.gz"
  sha256 "4696cd85d8d41fc2c1246b071d138e636d4766e0eb0a112a8273bd7d9af5c90f"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  resource "App-ansiecho" do
    url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansiecho-1.10.tar.gz"
    sha256 "112fd52803e5f40be216baff3105e2c01dd9a44d0a152e42e9e4a389418fcc6e"
  end

  resource "App-ansifold" do
    url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansifold-1.34.tar.gz"
    sha256 "57ad9ae2318822f57be973458e1c082f48e89c564ed6e712f523567af81148b9"
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
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    # Install additional resources
    resources.each do |r|
      r.stage do
        system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."
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
