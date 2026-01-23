class AppAnsifold < Formula
  desc "ANSI terminal sequence aware text folding command"
  homepage "https://github.com/tecolicom/App-ansifold"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansifold-1.34.tar.gz"
  sha256 "57ad9ae2318822f57be973458e1c082f48e89c564ed6e712f523567af81148b9"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"


  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    %w[ansifold ansicut ansicolrm].each do |cmd|
      (bin/cmd).write <<~SH
        #!/bin/bash
        export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
        exec "#{libexec}/bin/#{cmd}" "$@"
      SH
      (bin/cmd).chmod 0755
    end

    man1.install Dir[libexec/"man/man1/{ansifold,ansicut,ansicolrm}.1"]
  end

  test do
    system bin/"ansifold", "--version"
  end
end
