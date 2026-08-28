class AppDozo < Formula
  desc "Dozo, Docker with Zero Overhead"
  homepage "https://github.com/tecolicom/App-dozo"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-dozo-1.01.tar.gz"
  sha256 "8ec23afda70129d43f45422de2465b9a1bc0166728579a42bd0343db8e4facaa"
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
