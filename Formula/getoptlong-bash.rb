class GetoptlongBash < Formula
  desc "Getopt::Long style option parser for Bash scripts"
  homepage "https://github.com/tecolicom/getoptlong-bash"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Getopt-Long-Bash-2.1.0.tar.gz"
  sha256 "14ebe84c405440a058733b4fcc1eb84d7d44e62ad591c7a369979a7cf13a41a3"
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
    (testpath/"t.sh").write <<~EOS
      declare -A OPTS=( [ image | I : # image ]= )
      . #{bin}/getoptlong.sh OPTS "$@"
      echo "image=$image"
    EOS
    output = shell_output("#{formula_opt_bin("bash")}/bash #{testpath}/t.sh -I alpine")
    assert_equal "image=alpine\n", output
  end
end
