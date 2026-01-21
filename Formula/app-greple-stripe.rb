class AppGrepleStripe < Formula
  desc "Greple module for striped output"
  homepage "https://github.com/kaz-utashiro/greple-stripe"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-stripe-1.02.tar.gz"
  sha256 "c1be9fb30f594082d58b655a93c450f3f6fc1e67d42405d6bd0f5bb44889ebc5"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpanminus" => :build
  depends_on "tecolicom/tap/app-greple"

  def install
    system "cpanm", "--notest", "--installdeps", "."
    system "cpanm", "--notest", "-l", libexec, "."
  end

  test do
    system Formula["app-greple"].opt_bin/"greple", "-Mstripe", "--version"
  end
end
