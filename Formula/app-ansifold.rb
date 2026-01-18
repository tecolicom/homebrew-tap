class AppAnsifold < Formula
  desc "ANSI terminal sequence aware text folding command"
  homepage "https://github.com/tecolicom/App-ansifold"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-ansifold-1.34.tar.gz"
  sha256 "57ad9ae2318822f57be973458e1c082f48e89c564ed6e712f523567af81148b9"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--notest", "--installdeps", "."
    system "perl", "cpanm", "--notest", "-l", libexec, "."

    (libexec/"bin").install Dir["#{libexec}/bin/*"]
    bin.install_symlink libexec/"bin/ansifold"
    bin.env_script_all_files(libexec/"bin", PERL5LIB: ENV["PERL5LIB"])
  end

  test do
    system bin/"ansifold", "--version"
  end
end
