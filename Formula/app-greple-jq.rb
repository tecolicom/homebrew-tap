class AppGrepleJq < Formula
  desc "Greple module for JSON processing with jq"
  homepage "https://github.com/kaz-utashiro/greple-jq"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-jq-0.06.tar.gz"
  sha256 "033059613bc402cbc2ca2ccc242e205aa2e7b18a25b76ccba15a51012e219069"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "jq"
  depends_on "tecolicom/tap/app-greple"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::Greple::jq*.3"]
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mjq", "--version"
  end
end
