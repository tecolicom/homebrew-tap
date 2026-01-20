class AppGrepleStripe < Formula
  desc "Greple module for striped output"
  homepage "https://github.com/kaz-utashiro/greple-stripe"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-stripe-1.02.tar.gz"
  sha256 "c1be9fb30f594082d58b655a93c450f3f6fc1e67d42405d6bd0f5bb44889ebc5"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "tecolicom/tap/app-greple"

  uses_from_macos "perl"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-greple"].opt_libexec/"lib/perl5"

    system "curl", "-sL", "https://cpanmin.us", "-o", "cpanm"
    system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "."
  end

  test do
    ENV["PERL5LIB"] = libexec/"lib/perl5"
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mstripe -e test", "test\n", 0)
  end
end
