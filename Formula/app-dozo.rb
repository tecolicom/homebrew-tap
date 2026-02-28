class AppDozo < Formula
  desc "Dozo, Docker with Zero Overhead"
  homepage "https://github.com/tecolicom/App-dozo"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-dozo-1.00.tar.gz"
  sha256 "5637e666268918e850f3aac3465cc158c7cf7a7bed1acb4c70f3b9a2e594b0ea"
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
