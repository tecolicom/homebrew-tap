class AppGreple < Formula
  desc "Extensible grep with lexical expression and region handling"
  homepage "https://github.com/kaz-utashiro/greple"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-10.03.tar.gz"
  sha256 "ace2ce01a766c937fb87da72249e0e8534148395e2ea14e9d05a2f80eb5358ce"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    # Install commonly used greple modules (from app-greple-tools)
    %w[
      App::Greple::frame
      App::Greple::git
      App::Greple::L
      App::Greple::stripe
      App::Greple::subst
      App::Greple::tee
      App::Greple::type
      App::Greple::under
      App::Greple::update
      App::Greple::xp
    ].each do |mod|
      system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, mod
    end

    (bin/"greple").write <<~SH
      #!/bin/bash
      GREPLE_LIB="#{HOMEBREW_PREFIX}/opt/app-greple/libexec/lib/perl5"
      for dir in "#{HOMEBREW_PREFIX}/opt"/app-greple-*/libexec/lib/perl5; do
        [ -d "$dir" ] && GREPLE_LIB="$dir:$GREPLE_LIB"
      done
      export PERL5LIB="$GREPLE_LIB${PERL5LIB:+:$PERL5LIB}"
      exec "#{HOMEBREW_PREFIX}/opt/app-greple/libexec/bin/greple" "$@"
    SH
    (bin/"greple").chmod 0755

    man1.install libexec/"man/man1/greple.1"
    # Install man3 pages for UTASHIRO's modules (detected from MYMETA.json)
    require "json"
    Dir[libexec/"lib/perl5/**/.meta/*/MYMETA.json"].each do |meta_file|
      meta = JSON.parse(File.read(meta_file))
      authors = meta["author"] || []
      next unless authors.any? { |a| a.include?("Utashiro") }

      mod_pattern = meta["name"].gsub("-", "::") + "*.3"
      man_files = Dir[libexec/"man/man3"/mod_pattern]
      man3.install man_files unless man_files.empty?
    end
  end

  test do
    system bin/"greple", "--version"
  end
end
