class AppMdee < Formula
  desc "Multi-column Markdown viewer with syntax highlighting"
  homepage "https://github.com/tecolicom/App-mdee"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-mdee-0.03.tar.gz"
  sha256 "bcf619e0f594f084242221489acbf90e2fcd1e84677b0159b82ef6a678ab7a07"
  license "MIT"

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--notest", "--installdeps", "."
    system "perl", "cpanm", "--notest", "-l", libexec, "."

    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", PERL5LIB: ENV["PERL5LIB"])
  end

  test do
    system bin/"mdee", "--version"
  end
end
