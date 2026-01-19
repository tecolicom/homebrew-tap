class AppGrepleTools < Formula
  desc "Collection of commonly used Greple modules"
  homepage "https://github.com/kaz-utashiro/greple"
  url "https://cpan.metacpan.org/authors/id/U/UT/UTASHIRO/App-Greple-10.02.tar.gz"
  version "1.0"
  sha256 "56b73445b31a53499ff5b5a997f701ba1bb9e445978c1c6a03fa93f34a3fb624"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]

  depends_on "tecolicom/tap/app-greple"
  depends_on "tecolicom/tap/app-greple-frame"
  depends_on "tecolicom/tap/app-greple-git"
  depends_on "tecolicom/tap/app-greple-l"
  depends_on "tecolicom/tap/app-greple-stripe"
  depends_on "tecolicom/tap/app-greple-subst"
  depends_on "tecolicom/tap/app-greple-tee"
  depends_on "tecolicom/tap/app-greple-type"
  depends_on "tecolicom/tap/app-greple-under"
  depends_on "tecolicom/tap/app-greple-update"
  depends_on "tecolicom/tap/app-greple-xp"

  def install
    (share/"app-greple-tools").mkpath
    (share/"app-greple-tools/README").write <<~EOS
      This is a meta-package that installs commonly used Greple modules:
      - frame, git, L, stripe, subst, tee, type, under, update, xp
    EOS
  end

  test do
    ENV["PERL5LIB"] = Formula["app-greple-frame"].opt_libexec/"lib/perl5"
    pipe_output("#{Formula["app-greple"].opt_bin}/greple -Mframe -e test", "test\n", 0)
  end
end
