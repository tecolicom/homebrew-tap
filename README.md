# Tecolicom Homebrew Tap

Text processing and terminal tools by [@tecolicom](https://github.com/tecolicom).

## Installation

```bash
brew tap tecolicom/tap
```

## Available Formulae

### Text Processing

| Formula | Command | Description |
|---------|---------|-------------|
| [app-greple](https://github.com/kaz-utashiro/greple) | `greple` | Extensible grep with lexical expression and region handling |
| [app-optex](https://github.com/kaz-utashiro/optex) | `optex` | General-purpose command option wrapper |
| [app-sdif](https://github.com/tecolicom/App-sdif) | `sdif`, `cdif`, `watchdiff` | Side-by-side diff viewer with ANSI color support |
| [app-cat-v](https://github.com/tecolicom/App-cat-v) | `cat-v` | Visualize non-printing characters |

### Greple Modules

| Formula | Description |
|---------|-------------|
| [app-greple-charcode](https://github.com/kaz-utashiro/greple-charcode) | Character code handling |
| [app-greple-jq](https://github.com/kaz-utashiro/greple-jq) | JSON processing with jq |
| [app-greple-msdoc](https://github.com/kaz-utashiro/greple-msdoc) | Search Microsoft document files |
| [app-greple-pw](https://github.com/kaz-utashiro/greple-pw) | Password handling |
| [app-greple-subst-desumasu](https://github.com/kaz-utashiro/greple-subst-desumasu) | Japanese DESU/MASU dictionary for subst |
| [app-greple-wordle](https://github.com/kaz-utashiro/greple-wordle) | Wordle game |
| [app-greple-xlate](https://github.com/kaz-utashiro/App-Greple-xlate) | Translation support |

### ANSI Terminal Tools

| Formula | Commands | Description |
|---------|----------|-------------|
| [app-ansi-tools](https://github.com/tecolicom) | `ansicolumn`, `ansiecho`, `ansifold`, `ansicut`, `ansicolrm`, `ansiprintf` | ANSI terminal sequence aware text processing tools |

### Paged Output & Markdown

| Formula | Command | Description |
|---------|---------|-------------|
| [app-nup](https://github.com/tecolicom/App-nup) | `nup` | N-up contents-aware page-layout |
| [app-mdee](https://github.com/tecolicom/App-mdee) | `mdee` | Multi-column Markdown viewer with syntax highlighting |

### Docker

| Formula | Command | Description |
|---------|---------|-------------|
| [app-dozo](https://github.com/tecolicom/App-dozo) | `dozo` | Dozo, Docker with Zero Overhead |

### LLM

| Formula | Command | Description |
|---------|---------|-------------|
| [app-chot](https://github.com/tecolicom/App-chot) | `chot` | CLI tool for quick LLM interaction |

### Shell Utilities

| Formula | Commands | Description |
|---------|----------|-------------|
| [getoptlong-bash](https://github.com/tecolicom/Getopt-Long-Bash) | `getoptlong`, `getoptlong.sh` | Getopt::Long style option parser for Bash |

## Usage Examples

```bash
# Install individual tools
brew install tecolicom/tap/app-greple
brew install tecolicom/tap/app-sdif

# Install all ANSI tools at once
brew install tecolicom/tap/app-ansi-tools

# Install mdee (includes greple, ansi tools, nup as dependencies)
brew install tecolicom/tap/app-mdee
```

## Links

- [tecolicom on GitHub](https://github.com/tecolicom)
- [CPAN modules by UTASHIRO](https://metacpan.org/author/UTASHIRO)
