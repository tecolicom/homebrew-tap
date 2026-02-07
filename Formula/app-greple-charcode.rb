class AppGrepleCharcode < Formula
  desc "Greple module for character code handling"
  homepage "https://github.com/kaz-utashiro/greple-charcode"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-charcode-0.9909.tar.gz"
  sha256 "1e486e33f017a5d57f66a506b7c36fc016d47ed9d02a90b356af54bdab21e966"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-greple"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::Greple::charcode*.3"]
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mcharcode", "--version"
  end
end
