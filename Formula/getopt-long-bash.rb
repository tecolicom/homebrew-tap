class GetoptLongBash < Formula
  desc "Getopt::Long style option parser for Bash scripts"
  homepage "https://github.com/tecolicom/Getopt-Long-Bash"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/Getopt-Long-Bash-0.7.1.tar.gz"
  sha256 "edee0e97f9346ea42fd8865b050d510416c46b0a67a3f6cb7b6448d93e56781f"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--notest", "--installdeps", "."
    system "perl", "cpanm", "--notest", "-l", libexec, "."

    (libexec/"bin").install Dir["#{libexec}/bin/*"]
    %w[getoptlong getoptlong.sh].each do |cmd|
      bin.install_symlink libexec/"bin"/cmd
    end
    bin.env_script_all_files(libexec/"bin", PERL5LIB: ENV["PERL5LIB"])
  end

  test do
    system bin/"getoptlong", "--version"
  end
end
