class AppGrepleMsdoc < Formula
  desc "Greple module to search Microsoft document files"
  homepage "https://github.com/kaz-utashiro/greple-msdoc"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-msdoc-1.07.tar.gz"
  sha256 "0466ceaa5c806b9a5095b4351d1d11561962509bd883caf90d3f832dd90435da"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-greple"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::Greple::msdoc*.3"]
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mmsdoc", "--version"
  end
end
