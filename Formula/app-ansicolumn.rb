class AppAnsicolumn < Formula
  desc "ANSI terminal sequence aware column command"
  homepage "https://github.com/tecolicom/App-ansicolumn"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansicolumn-1.50.tar.gz"
  sha256 "4696cd85d8d41fc2c1246b071d138e636d4766e0eb0a112a8273bd7d9af5c90f"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--notest", "--installdeps", "."
    system "perl", "cpanm", "--notest", "-l", libexec, "."

    (libexec/"bin").install Dir["#{libexec}/bin/*"]
    %w[ansicolumn ansicolrm ansicut].each do |cmd|
      bin.install_symlink libexec/"bin"/cmd
    end
    bin.env_script_all_files(libexec/"bin", PERL5LIB: ENV["PERL5LIB"])
  end

  test do
    system bin/"ansicolumn", "--version"
  end
end
