class AppOptexGlob < Formula
  desc "optex filter to glob filenames"
  homepage "https://github.com/kaz-utashiro/optex-glob"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-glob-1.01.tar.gz"
  sha256 "388d6c68e485782635b9149679fe2085eff6e4323805f25ddb3b5d73298846c5"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-optex"

  def install
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::optex::glob*.3"]
  end

  test do
    system Formula["app-optex"].bin/"optex", "-Mglob", "--version"
  end
end
