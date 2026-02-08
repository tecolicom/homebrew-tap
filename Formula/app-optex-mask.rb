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

    system "cpm", "install", "--resolver", "metacpan", "--no-default-resolvers", "--show-build-log-on-failure", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::optex::mask*.3"]
  end

  test do
    result = shell_output("echo men | #{Formula["app-optex"].bin/"optex"} -Mmask men -- sed s/men/women/")
    assert_equal "men\n", result
  end
end
