class GetoptlongBash < Formula
  desc "Getopt::Long style option parser for Bash scripts"
  homepage "https://github.com/tecolicom/Getopt-Long-Bash"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Getopt-Long-Bash-0.8.1.tar.gz"
  sha256 "40f70acfd411f5f86f62dba9ce52b1d4787075e50edab857888637724c5f88b5"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "bash"

  def install
    if which("pod2man")
      system "pod2man", "--name=getoptlong", "--section=3",
             "--center=Bash Library", "script/getoptlong", "getoptlong.3"
      man3.install "getoptlong.3"
    end
    bin.install "script/getoptlong", "script/getoptlong.sh"
  end

  test do
    system bin/"getoptlong", "--version"
  end
end
