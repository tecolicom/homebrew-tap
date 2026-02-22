# Tecolicom Homebrew Tap

Text processing and terminal tools by [@tecolicom](https://github.com/tecolicom).

## Installation

```bash
brew tap tecolicom/tap
```

## Available Formulae

### Greple

[greple](https://github.com/kaz-utashiro/greple#readme) is an extensible grep with lexical expression and region handling. The `app-greple` formula installs the `greple` command along with commonly used modules (invoked via `-M` option). Modules marked with ✱ are included in the core App::Greple distribution; others are bundled in the formula. Additional modules can be installed as separate formulae and are automatically discovered at runtime.

| Formula | Command | Description |
|---------|---------|-------------|
| [app-greple](https://github.com/kaz-utashiro/greple#readme) | [`greple`](https://metacpan.org/dist/App-Greple/view/script/greple) | Core command |
| | [`-Mcolors`](https://metacpan.org/pod/App::Greple::colors) ✱ | Various colormap |
| | [`-Mdebug`](https://metacpan.org/pod/App::Greple::debug) ✱ | Debug control |
| | [`-Mdig`](https://metacpan.org/pod/App::Greple::dig) ✱ | Recursive search |
| | [`-Mfind`](https://metacpan.org/pod/App::Greple::find) ✱ | Use find command |
| | [`-Mperl`](https://metacpan.org/pod/App::Greple::perl) ✱ | Perl script handling |
| | [`-Mpgp`](https://metacpan.org/pod/App::Greple::pgp) ✱ | Handle PGP encrypted files |
| | [`-Mselect`](https://metacpan.org/pod/App::Greple::select) ✱ | Select files |
| | [`-Mframe`](https://metacpan.org/pod/App::Greple::frame) | Frame output |
| | [`-Mgit`](https://metacpan.org/pod/App::Greple::git) | Git integration |
| | [`-ML`](https://metacpan.org/pod/App::Greple::L) | Produce result by line numbers |
| | [`-Mstripe`](https://metacpan.org/pod/App::Greple::stripe) | Zebra stripe output |
| | [`-Msubst`](https://metacpan.org/pod/App::Greple::subst) | Text search and substitution |
| | [`-Mtee`](https://metacpan.org/pod/App::Greple::tee) | Replace matched text by external command result |
| | [`-Mtype`](https://metacpan.org/pod/App::Greple::type) | File type filter |
| | [`-Munder`](https://metacpan.org/pod/App::Greple::under) | Under-line display |
| | [`-Mupdate`](https://metacpan.org/pod/App::Greple::update) | Update file content |
| | [`-Mxp`](https://metacpan.org/pod/App::Greple::xp) | Extended pattern |
| [app-greple-charcode](https://github.com/kaz-utashiro/greple-charcode#readme) | [`-Mcharcode`](https://metacpan.org/pod/App::Greple::charcode) | Character code handling |
| [app-greple-jq](https://github.com/kaz-utashiro/greple-jq#readme) | [`-Mjq`](https://metacpan.org/pod/App::Greple::jq) | JSON processing with jq |
| [app-greple-msdoc](https://github.com/kaz-utashiro/greple-msdoc#readme) | [`-Mmsdoc`](https://metacpan.org/pod/App::Greple::msdoc) | Search Microsoft document files |
| [app-greple-pw](https://github.com/kaz-utashiro/greple-pw#readme) | [`-Mpw`](https://metacpan.org/pod/App::Greple::pw) | Password handling |
| [app-greple-subst-desumasu](https://github.com/kaz-utashiro/greple-subst-desumasu#readme) | [`-Msubst::desumasu`](https://metacpan.org/pod/App::Greple::subst::desumasu) | Japanese DESU/MASU dictionary for subst |
| [app-greple-wordle](https://github.com/kaz-utashiro/greple-wordle#readme) | [`-Mwordle`](https://metacpan.org/pod/App::Greple::wordle) | Wordle game |
| [app-greple-xlate](https://github.com/kaz-utashiro/App-Greple-xlate#readme) | [`xlate`](https://metacpan.org/pod/App::Greple::xlate), [`-Mxlate`](https://metacpan.org/pod/App::Greple::xlate) | Translation support |

### Optex

[optex](https://github.com/kaz-utashiro/optex#readme) is a general-purpose command option wrapper. Additional modules can be installed as separate formulae and are automatically discovered at runtime.

| Formula | Command | Description |
|---------|---------|-------------|
| [app-optex](https://github.com/kaz-utashiro/optex#readme) | [`optex`](https://metacpan.org/dist/App-optex/view/script/optex) | Core command |
| [app-optex-glob](https://github.com/kaz-utashiro/optex-glob#readme) | [`-Mglob`](https://metacpan.org/pod/App::optex::glob) | Glob filenames |
| [app-optex-mask](https://github.com/kaz-utashiro/optex-mask#readme) | [`-Mmask`](https://metacpan.org/pod/App::optex::mask) | Data masking |
| [app-optex-pingu](https://github.com/kaz-utashiro/optex-pingu#readme) | [`-Mpingu`](https://metacpan.org/pod/App::optex::pingu) | Make-everything-pingu filter |
| [app-optex-rpn](https://github.com/kaz-utashiro/optex-rpn#readme) | [`-Mrpn`](https://metacpan.org/pod/App::optex::rpn) | Reverse Polish Notation calculation |
| [app-optex-scroll](https://github.com/kaz-utashiro/optex-scroll#readme) | [`-Mscroll`](https://metacpan.org/pod/App::optex::scroll) | Scroll region |
| [app-optex-textconv](https://github.com/kaz-utashiro/optex-textconv#readme) | [`-Mtextconv`](https://metacpan.org/pod/App::optex::textconv) | Replace document file by its text contents |
| [app-optex-up](https://github.com/kaz-utashiro/optex-up#readme) | [`-Mup`](https://metacpan.org/pod/App::optex::up) | Multi-column paged output |
| [app-optex-xform](https://github.com/kaz-utashiro/optex-xform#readme) | [`-Mxform`](https://metacpan.org/pod/App::optex::xform) | Data transform filter |

### Text Processing

| Formula | Command | Description |
|---------|---------|-------------|
| [app-sdif](https://github.com/tecolicom/App-sdif#readme) | [`sdif`](https://metacpan.org/dist/App-sdif/view/script/sdif), [`cdif`](https://metacpan.org/dist/App-sdif/view/script/cdif), [`watchdiff`](https://metacpan.org/dist/App-sdif/view/script/watchdiff) | Side-by-side diff viewer with ANSI color support |
| [app-cat-v](https://github.com/tecolicom/App-cat-v#readme) | [`cat-v`](https://metacpan.org/dist/App-cat-v/view/script/cat-v) | Visualize non-printing characters |

### ANSI Terminal Tools

| Formula | Command | Description |
|---------|---------|-------------|
| [app-ansi-tools](https://github.com/tecolicom) | [`ansicolumn`](https://metacpan.org/dist/App-ansicolumn/view/script/ansicolumn) | ANSI-aware column formatting |
| | [`ansiecho`](https://metacpan.org/dist/App-ansiecho/view/script/ansiecho) | ANSI color echo |
| | [`ansifold`](https://metacpan.org/dist/App-ansifold/view/script/ansifold) | ANSI-aware text folding |
| | [`ansicut`](https://metacpan.org/dist/App-ansifold/view/script/ansicut) | ANSI-aware cut |
| | [`ansicolrm`](https://metacpan.org/dist/App-ansifold/view/script/ansicolrm) | ANSI-aware column removal |
| | [`ansiprintf`](https://metacpan.org/dist/Text-ANSI-Printf/view/script/ansiprintf) | ANSI-aware printf |

### Paged Output & Markdown

| Formula | Command | Description |
|---------|---------|-------------|
| [app-nup](https://github.com/tecolicom/App-nup#readme) | [`nup`](https://metacpan.org/pod/App::nup) | N-up contents-aware page-layout |
| [app-mdee](https://github.com/tecolicom/App-mdee#readme) | [`mdee`](https://metacpan.org/pod/App::mdee) | Multi-column Markdown viewer with syntax highlighting |
| [pandoc-embedz](https://github.com/tecolicom/pandoc-embedz#readme) | `pandoc-embedz` | Pandoc filter for data-driven content embedding |

### Docker

| Formula | Command | Description |
|---------|---------|-------------|
| [app-dozo](https://github.com/tecolicom/App-dozo#readme) | [`dozo`](https://metacpan.org/pod/App::dozo) | Dozo, Docker with Zero Overhead |

### Development Tools

| Formula | Command | Description |
|---------|---------|-------------|
| [app-chot](https://github.com/tecolicom/App-chot#readme) | [`chot`](https://metacpan.org/dist/App-chot/view/script/chot) | Locate and display source of commands and libraries |

### Shell Utilities

| Formula | Commands | Description |
|---------|----------|-------------|
| [getoptlong-bash](https://github.com/tecolicom/Getopt-Long-Bash#readme) | [`getoptlong`](https://metacpan.org/pod/Getopt::Long::Bash), `getoptlong.sh` | Getopt::Long style option parser for Bash |

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
