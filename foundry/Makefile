-include .env

.PHONY: help build build-solution clean get-block test test-solution

help:
	@echo "Available commands:"
	@echo "  make build           - Build exercises"
	@echo "  make build-solution  - Build solutions"
	@echo "  make clean           - Clean build artifacts"
	@echo "  make get-block       - Get current block number"
	@echo "  make test TEST=<name> - Test exercise (e.g., make test TEST=Supply)"
	@echo "  make test-solution TEST=<name> - Test solution"

build:
	forge build

build-solution:
	FOUNDRY_PROFILE=solution forge build

clean:
	forge clean

get-block:
	@cast block-number --rpc-url $(FORK_URL)

test:
ifndef TEST
	@echo "Error: TEST variable is required. Usage: make test TEST=Supply"
	@exit 1
endif
	@FORK_BLOCK_NUM=$$(cast block-number --rpc-url $(FORK_URL)) && \
	forge test --fork-url $(FORK_URL) --fork-block-number $$FORK_BLOCK_NUM --match-path test/$(TEST).test.sol -vvv

test-solution:
ifndef TEST
	@echo "Error: TEST variable is required. Usage: make test-solution TEST=Supply"
	@exit 1
endif
	@FORK_BLOCK_NUM=$$(cast block-number --rpc-url $(FORK_URL)) && \
	FOUNDRY_PROFILE=solution forge test --fork-url $(FORK_URL) --fork-block-number $$FORK_BLOCK_NUM --match-path test/$(TEST).test.sol -vvv
