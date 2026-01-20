class AppGreple < Formula
  desc "Extensible grep with lexical expression and region handling"
  homepage "https://github.com/kaz-utashiro/greple"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-10.03.tar.gz"
  sha256 "ace2ce01a766c937fb87da72249e0e8534148395e2ea14e9d05a2f80eb5358ce"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "--installdeps", "."
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "."

    (bin/"greple").write <<~SH
      #!/bin/bash
      GREPLE_LIB="#{HOMEBREW_PREFIX}/opt/app-greple/libexec/lib/perl5"
      for mod in charcode frame git jq l msdoc pw stripe subst tee type under update wordle xlate xp; do
        dir="#{HOMEBREW_PREFIX}/opt/app-greple-${mod}/libexec/lib/perl5"
        [ -d "$dir" ] && GREPLE_LIB="$dir:$GREPLE_LIB"
      done
      export PERL5LIB="$GREPLE_LIB${PERL5LIB:+:$PERL5LIB}"
      exec "#{HOMEBREW_PREFIX}/opt/app-greple/libexec/bin/greple" "$@"
    SH
    (bin/"greple").chmod 0755

    man1.install libexec/"man/man1/greple.1"
  end

  test do
    system bin/"greple", "--version"
  end
end
