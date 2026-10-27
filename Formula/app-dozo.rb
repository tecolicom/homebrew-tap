class AppDozo < Formula
  desc "Dozo, Docker with Zero Overhead"
  homepage "https://github.com/tecolicom/App-dozo"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-dozo-1.02.tar.gz"
  sha256 "58d783ec87af79e8d96d149c5c98164d1abbf984b028762adb467a2dc1b30573"
  license "MIT"

  depends_on "tecolicom/tap/getoptlong-bash"

  def install
    bin.install "script/dozo"
    if which("pod2man")
      system "pod2man", "--name=dozo", "--section=1",
             "lib/App/dozo.pm", "dozo.1"
      man1.install "dozo.1"
    end
  end

  test do
    system bin/"dozo", "--version"
  end
end
