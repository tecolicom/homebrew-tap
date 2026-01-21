class AppGrepleUnder < Formula
  desc "Greple module for directory specification"
  homepage "https://github.com/kaz-utashiro/greple-under"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-under-1.00.tar.gz"
  sha256 "007280dc120fce7133f421bc8079c3d459adcd8b7ead1b25b3ccec304b46a852"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus" => :build
  depends_on "tecolicom/tap/app-greple"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-greple"].opt_libexec/"lib/perl5"
    system "cpanm", "--notest", "-l", libexec, "."
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Munder", "--version"
  end
end
