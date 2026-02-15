class PandocEmbedz < Formula
  desc "Pandoc filter for embedding data-driven content using Jinja2 templates"
  homepage "https://github.com/tecolicom/pandoc-embedz"
  url "https://files.pythonhosted.org/packages/source/p/pandoc-embedz/pandoc_embedz-0.22.1.tar.gz"
  sha256 "f46a66dc198fa74863b9de4c8c78981341babd07cc317b542748caa780914d3e"
  license "MIT"

  depends_on "pandoc"
  depends_on "python@3.12"

  def install
    python = Formula["python@3.12"]
    venv = libexec/"venv"
    system python.opt_bin/"python3.12", "-m", "venv", venv
    system venv/"bin/pip", "install", "."

    (bin/"pandoc-embedz").write_env_script(
      venv/"bin/pandoc-embedz",
      PATH: "#{venv}/bin:${PATH}"
    )

    # Generate and install man page
    if (buildpath/"man/pandoc-embedz.md").exist?
      system "pandoc", "man/pandoc-embedz.md", "-s", "-t", "man",
             "-o", "man/pandoc-embedz.1"
      man1.install "man/pandoc-embedz.1"
    elsif (buildpath/"man/pandoc-embedz.1").exist?
      man1.install "man/pandoc-embedz.1"
    end
  end

  test do
    system bin/"pandoc-embedz", "--version"
  end
end
