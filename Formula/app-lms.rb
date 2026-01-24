class AppLms < Formula
  desc "Language Model Shell - CLI for LLM interaction"
  homepage "https://github.com/kaz-utashiro/App-lms"
  url "https://github.com/kaz-utashiro/App-lms/archive/refs/tags/0.11.tar.gz"
  sha256 "44ddbda44dd4feaf863088f806913ac48f5a3d5d760eeb6156dd6b43ada7cd26"
  license any_of: ["Artistic-1.0-Perl", "GPL-1.0-or-later"]
  head "https://github.com/kaz-utashiro/App-lms.git", branch: "main"

  depends_on "cpm"

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    # Install dependencies from cpanfile (skip develop and recommends like Inline::Python)
    system "cpm", "install", "--home", buildpath.parent/".cpm", "-L", libexec,
           "--cpanfile", "cpanfile", "--without-develop", "--without-recommends"

    # Install the module itself
    system "perl", "Build.PL"
    system "./Build"
    system "./Build", "install", "--install_base", libexec

    (bin/"lms").write <<~SH
      #!/bin/bash
      export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
      export LMS_SCRIPT_PATH="#{libexec}/bin/lms"
      exec "#{libexec}/bin/lms" "$@"
    SH
    (bin/"lms").chmod 0755

    man1.install Dir[libexec/"man/man1/lms.1"] if (libexec/"man/man1/lms.1").exist?
  end

  test do
    system bin/"lms", "--version"
  end
end
