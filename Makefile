TAP_DIR = /opt/homebrew/Library/Taps/tecolicom/homebrew-tap
FORMULAS = $(wildcard Formula/*.rb)
NAMES = $(patsubst Formula/%.rb,%,$(FORMULAS))

.PHONY: all sync audit build test clean help

help:
	@echo "Usage:"
	@echo "  make sync    - Copy formulas to tap directory"
	@echo "  make audit   - Run brew audit on all formulas"
	@echo "  make build   - Reinstall all formulas from source"
	@echo "  make test    - Run brew test on all formulas"
	@echo "  make all     - Run sync, audit, build, test"
	@echo "  make clean   - Uninstall all formulas"
	@echo ""
	@echo "Single formula:"
	@echo "  make <name>        - Audit, build, test single formula"
	@echo "  make sync-<name>   - Sync single formula"
	@echo "  make audit-<name>  - Audit single formula"
	@echo "  make build-<name>  - Build single formula"
	@echo "  make test-<name>   - Test single formula"

all: sync audit build test

sync:
	cp Formula/*.rb $(TAP_DIR)/Formula/

audit: sync
	@for name in $(NAMES); do \
		echo "==> Auditing $$name"; \
		brew audit --formula tecolicom/tap/$$name || exit 1; \
	done

build: sync
	@for name in $(NAMES); do \
		echo "==> Building $$name"; \
		brew reinstall --build-from-source tecolicom/tap/$$name || exit 1; \
	done

test:
	@for name in $(NAMES); do \
		echo "==> Testing $$name"; \
		brew test tecolicom/tap/$$name || exit 1; \
	done

clean:
	@for name in $(NAMES); do \
		echo "==> Uninstalling $$name"; \
		brew uninstall tecolicom/tap/$$name 2>/dev/null || true; \
	done

# Single formula targets
%: audit-% build-% test-%
	@echo "==> Done: $*"

sync-%:
	cp Formula/$*.rb $(TAP_DIR)/Formula/

audit-%: sync-%
	brew audit --formula tecolicom/tap/$*

build-%: sync-%
	brew reinstall --build-from-source tecolicom/tap/$*

test-%:
	brew test tecolicom/tap/$*
