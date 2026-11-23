class GetoptlongBash < Formula
  desc "Getopt::Long style option parser for Bash scripts"
  homepage "https://github.com/tecolicom/getoptlong-bash"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Getopt-Long-Bash-1.5.0.tar.gz"
  sha256 "ea343934006dea74cb6e73d2c10a1c23dac041cd94b84745b32e8be6b15e9633"
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
