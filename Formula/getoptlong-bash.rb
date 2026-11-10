class GetoptlongBash < Formula
  desc "Getopt::Long style option parser for Bash scripts"
  homepage "https://github.com/tecolicom/Getopt-Long-Bash"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Getopt-Long-Bash-1.1.1.tar.gz"
  sha256 "8ba9ea8133c3e331ee19bb960e1b2490e0432009dcc34df9a3a6dc5f0a393dba"
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
