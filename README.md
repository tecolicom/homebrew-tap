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
| [app-sdif](https://github.com/tecolicom/App-sdif) | `sdif`, `cdif` | Side-by-side diff viewer with ANSI color support |

### Greple Modules

| Formula | Description |
|---------|-------------|
| [app-greple-charcode](https://github.com/kaz-utashiro/greple-charcode) | Character code handling |
| [app-greple-frame](https://github.com/kaz-utashiro/greple-frame) | Display text in decorative frame |
| [app-greple-git](https://github.com/kaz-utashiro/greple-git) | Git integration |
| [app-greple-jq](https://github.com/kaz-utashiro/greple-jq) | JSON processing with jq |
| [app-greple-l](https://github.com/kaz-utashiro/greple-L) | Line number handling |
| [app-greple-msdoc](https://github.com/kaz-utashiro/greple-msdoc) | Search Microsoft document files |
| [app-greple-pw](https://github.com/kaz-utashiro/greple-pw) | Password handling |
| [app-greple-stripe](https://github.com/kaz-utashiro/greple-stripe) | Striped output |
| [app-greple-subst](https://github.com/kaz-utashiro/greple-subst) | Text substitution |
| [app-greple-tee](https://github.com/kaz-utashiro/greple-tee) | Tee matched text to external command |
| [app-greple-type](https://github.com/kaz-utashiro/greple-type) | File type handling |
| [app-greple-under](https://github.com/kaz-utashiro/greple-under) | Directory specification |
| [app-greple-update](https://github.com/kaz-utashiro/greple-update) | Update file content |
| [app-greple-wordle](https://github.com/kaz-utashiro/greple-wordle) | Wordle game |
| [app-greple-xlate](https://github.com/kaz-utashiro/App-Greple-xlate) | Translation support |
| [app-greple-xp](https://github.com/kaz-utashiro/greple-xp) | Extended pattern handling |
| **app-greple-tools** | *(meta)* Collection of commonly used modules |

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
| [getoptlong-bash](https://github.com/tecolicom/Getopt-Long-Bash) | `getoptlong`, `getoptlong.sh` | Getopt::Long style option parser for Bash |

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
