class AppMdee < Formula
  desc "Multi-column Markdown viewer with syntax highlighting"
  homepage "https://github.com/tecolicom/App-mdee"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-mdee-0.03.tar.gz"
  sha256 "bcf619e0f594f084242221489acbf90e2fcd1e84677b0159b82ef6a678ab7a07"
  license "MIT"

  depends_on "cpanminus" => :build
  depends_on "perl"

  def install
    system "cpanm", "--notest", "--installdeps", "."
    system "cpanm", "--notest", "-l", libexec, "."
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"mdee", "--version"
  end
end
