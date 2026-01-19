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

### ANSI Terminal Tools

| Formula | Commands | Description |
|---------|----------|-------------|
| [app-ansicolumn](https://github.com/tecolicom/App-ansicolumn) | `ansicolumn`, `ansicolrm`, `ansicut` | ANSI-aware column formatting |
| [app-ansifold](https://github.com/tecolicom/App-ansifold) | `ansifold` | ANSI-aware text folding |
| [app-ansiecho](https://github.com/tecolicom/App-ansiecho) | `ansiecho` | Echo with ANSI color support |
| [text-ansi-printf](https://github.com/tecolicom/Text-ANSI-Printf) | `ansiprintf` | ANSI-aware printf |
| **app-ansi-tools** | *(meta)* | Installs all ANSI tools above |

### Paged Output

| Formula | Command | Description |
|---------|---------|-------------|
| [app-nup](https://github.com/tecolicom/App-nup) | `nup` | N-up contents-aware page-layout |

### Markdown

| Formula | Command | Description |
|---------|---------|-------------|
| [app-mdee](https://github.com/tecolicom/App-mdee) | `mdee` | Multi-column Markdown viewer with syntax highlighting |

### Shell Utilities

| Formula | Commands | Description |
|---------|----------|-------------|
| [getopt-long-bash](https://github.com/tecolicom/Getopt-Long-Bash) | `getoptlong`, `getoptlong.sh` | Getopt::Long style option parser for Bash |

## Usage Examples

```bash
# Install individual tools
brew install tecolicom/tap/greple
brew install tecolicom/tap/app-ansicolumn

# Install all ANSI tools at once
brew install tecolicom/tap/app-ansi-tools

# Install mdee (includes greple, ansi tools, nup as dependencies)
brew install tecolicom/tap/app-mdee
```

## Links

- [tecolicom on GitHub](https://github.com/tecolicom)
- [CPAN modules by UTASHIRO](https://metacpan.org/author/UTASHIRO)
