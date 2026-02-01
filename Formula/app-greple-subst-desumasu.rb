class AppGrepleSubstDesumasu < Formula
  desc "Japanese DESU/MASU dictionary for App::Greple::subst"
  homepage "https://github.com/kaz-utashiro/greple-subst-desumasu"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-subst-desumasu-0.07.tar.gz"
  sha256 "063528e7e2f2dba4938d1b5c91f3e27e3b20213ab522bcadd1fa873a407027c4"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "cpm"
  depends_on "tecolicom/tap/app-greple"

  def install
    # Prevent superenv from injecting -mbranch-protection=standard
    # which causes "Illegal instruction" in Docker on arm64
    ENV["HOMEBREW_CCCFG"] = ENV.fetch("HOMEBREW_CCCFG", "").delete("b")

    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["app-greple"].opt_libexec/"lib/perl5"
    system "cpm", "install", "--home", buildpath.parent/".cpm", "--man-pages", "-L", libexec, "."

    man3.install Dir[libexec/"man/man3/App::Greple::subst::desumasu*.3"]
  end

  test do
    ENV["PERL5LIB"] = "#{libexec}/lib/perl5:#{Formula["app-greple"].opt_libexec}/lib/perl5"
    assert_match "desumasu", shell_output("#{Formula["app-greple"].opt_bin}/greple -Msubst::desumasu --man")
  end
end
