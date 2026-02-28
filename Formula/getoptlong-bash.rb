class GetoptlongBash < Formula
  desc "Getopt::Long style option parser for Bash scripts"
  homepage "https://github.com/tecolicom/Getopt-Long-Bash"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Getopt-Long-Bash-0.7.2.tar.gz"
  sha256 "f44f31b2020d00d5b880e588c719c528ba360d045e0274e30726bad6f4a43939"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "bash"

  def install
    bin.install "script/getoptlong", "script/getoptlong.sh"
    if which("pod2man")
      system "pod2man", "--name=getoptlong", "--section=3",
             "--center=Bash Library", "lib/Getopt/Long/Bash.pm", "getoptlong.3"
      man3.install "getoptlong.3"
    end
  end

  test do
    system bin/"getoptlong", "--version"
  end
end
