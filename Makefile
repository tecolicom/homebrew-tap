# Homebrew Tap Formula Management
#
# All formulas:
#   make all     - Run sync, audit, build, test for all
#   make sync    - Copy formulas to tap directory
#   make audit   - Run brew audit on all formulas
#   make build   - Reinstall all formulas from source
#   make test    - Run brew test on all formulas
#   make clean   - Uninstall all formulas
#
# Single formula:
#   make sync-<name>   - Sync single formula
#   make audit-<name>  - Audit single formula
#   make build-<name>  - Build single formula
#   make test-<name>   - Test single formula

TAP_DIR = /opt/homebrew/Library/Taps/tecolicom/homebrew-tap
FORMULAS = $(wildcard Formula/*.rb)
NAMES = $(patsubst Formula/%.rb,%,$(FORMULAS))

.PHONY: all sync audit build test clean

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

test: sync
	@for name in $(NAMES); do \
		echo "==> Testing $$name"; \
		brew test tecolicom/tap/$$name || exit 1; \
	done

clean:
	@for name in $(NAMES); do \
		echo "==> Uninstalling $$name"; \
		brew uninstall tecolicom/tap/$$name 2>/dev/null || true; \
	done

sync-%:
	cp Formula/$*.rb $(TAP_DIR)/Formula/

audit-%: sync-%
	brew audit --formula tecolicom/tap/$*

build-%: sync-%
	brew reinstall --build-from-source tecolicom/tap/$*

test-%: sync-%
	brew test tecolicom/tap/$*
