class AppOptexConceal < Formula
  desc "optex module to conceal output contents"
  homepage "https://github.com/kaz-utashiro/optex-conceal"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-optex-conceal-0.01.tar.gz"
  sha256 "014a70c6c4993d31bc7e150045b3ce8abcc9acfc01522eba6d48d9758d27a5ec"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-optex"

  def install
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-optex"].opt_libexec/"lib/perl5"

    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::optex::conceal*.3"]
  end

  test do
    system Formula["app-optex"].bin/"optex", "-Mconceal", "--version"
  end
end
