TAP_DIR = /opt/homebrew/Library/Taps/tecolicom/homebrew-tap
FORMULAS = $(wildcard Formula/*.rb)
NAMES = $(patsubst Formula/%.rb,%,$(FORMULAS))

.PHONY: all sync audit build test clean help list

help:
	@echo "Homebrew Tap Formula Management"
	@echo ""
	@echo "All formulas:"
	@echo "  make all     - Run sync, audit, test (build included) for all"
	@echo "  make sync    - Copy formulas to tap directory"
	@echo "  make audit   - Run brew audit on all formulas (requires sync)"
	@echo "  make build   - Reinstall all formulas from source (requires sync)"
	@echo "  make test    - Run brew test on all formulas (auto-builds)"
	@echo "  make clean   - Uninstall all formulas"
	@echo ""
	@echo "Single formula:"
	@echo "  make <name>        - Audit, build, test single formula"
	@echo "  make sync-<name>   - Sync single formula"
	@echo "  make audit-<name>  - Audit single formula (auto-syncs)"
	@echo "  make build-<name>  - Build single formula (auto-syncs)"
	@echo "  make test-<name>   - Test single formula (auto-builds)"
	@echo ""
	@echo "Other:"
	@echo "  make list    - List all formula names"
	@echo "  make help    - Show this help"
	@echo ""
	@echo "Examples:"
	@echo "  make app-greple          # Test single formula"
	@echo "  make build-app-mdee      # Build only"
	@echo "  make all                 # Full test of all formulas"

list:
	@echo $(NAMES) | tr ' ' '\n'

all: sync audit test

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

test: build
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
%: audit-% test-%
	@echo "==> Done: $*"

sync-%:
	cp Formula/$*.rb $(TAP_DIR)/Formula/

audit-%: sync-%
	brew audit --formula tecolicom/tap/$*

build-%: sync-%
	brew reinstall --build-from-source tecolicom/tap/$*

test-%: build-%
	brew test tecolicom/tap/$*
