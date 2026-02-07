class AppOptexMask < Formula
  desc "optex data masking module"
  homepage "https://github.com/kaz-utashiro/optex-mask"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-mask-0.01.tar.gz"
  sha256 "02d2d1c9136140d830d744e3b63f178e4548b348bd3a43cf42765d8daa643585"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-optex"

  def install
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-optex"].opt_libexec/"lib/perl5"

    system "cpm", "install", "--home", buildpath.parent/".cpm", "-L", libexec, "."
  end

  test do
    system Formula["app-optex"].bin/"optex", "-Mmask", "--version"
  end
end
