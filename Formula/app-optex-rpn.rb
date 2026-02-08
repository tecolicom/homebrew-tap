class AppOptexRpn < Formula
  desc "optex module for Reverse Polish Notation calculation"
  homepage "https://github.com/kaz-utashiro/optex-rpn"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-rpn-1.04.tar.gz"
  sha256 "7f5c67dae27b0c4b53edc7a8b2e02cfa2a51c35854863dbf5af102483f93f251"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-optex"

  def install
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::optex::rpn*.3"]
  end

  test do
    system Formula["app-optex"].bin/"optex", "-Mrpn", "--version"
  end
end
