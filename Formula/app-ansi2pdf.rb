class AppAnsi2pdf < Formula
  desc "Render terminal output with ANSI sequences to PDF"
  homepage "https://github.com/tecolicom/App-ansi2pdf"
  url "https://github.com/tecolicom/App-ansi2pdf/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "32e90e89e51c9ae8310d46050c605ff831a5af57e6785b96b542df72a6e69962"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
    man1.install_symlink libexec/"lib/node_modules/ansi2pdf/man/ansi2pdf.1"
  end

  def caveats
    <<~EOS
      The default font is BIZ UDGothic, which covers Japanese:
        brew install --cask font-biz-udgothic
      Without it, Menlo or DejaVu Sans Mono is used if found, or a font
      can be given by --font.
    EOS
  end

  test do
    assert_match "Usage: ansi2pdf", shell_output("#{bin}/ansi2pdf --help")
    if OS.mac?
      # Menlo is always there
      assert_match(/^\d+ \d+$/, shell_output("#{bin}/ansi2pdf --geometry"))
      (testpath/"in.txt").write "\e[31mred\e[m text\n"
      system bin/"ansi2pdf", "-o", "out.pdf", "in.txt"
      assert_equal "%PDF-", File.binread("out.pdf", 5)
    end
  end
end
