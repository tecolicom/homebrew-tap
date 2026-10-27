class GetoptlongBash < Formula
  desc "Getopt::Long style option parser for Bash scripts"
  homepage "https://github.com/tecolicom/Getopt-Long-Bash"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Getopt-Long-Bash-1.1.0.tar.gz"
  sha256 "83a7c807b44022185c3ba6eda7d9e56c0c8632a4d79fbacd87edec199bb42d60"
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
