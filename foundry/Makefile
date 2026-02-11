-include .env

.PHONY: help build build-solution clean get-block test test-all test-solution test-solution-all

help:
	@echo "Available commands:"
	@echo "  make build                    - Build exercises"
	@echo "  make build-solution           - Build solutions"
	@echo "  make clean                    - Clean build artifacts"
	@echo "  make get-block                - Get current block number"
	@echo "  make test                     - Test all exercises"
	@echo "  make test TEST=<name>         - Test specific exercise (e.g., make test TEST=Supply)"
	@echo "  make test-solution            - Test all solutions"
	@echo "  make test-solution TEST=<name> - Test specific solution"

build:
	forge build

build-solution:
	FOUNDRY_PROFILE=solution forge build

clean:
	forge clean

get-block:
	@cast block-number --rpc-url $(FORK_URL)

test:
ifdef TEST
	@FORK_BLOCK_NUM=$$(cast block-number --rpc-url $(FORK_URL)) && \
	forge test --fork-url $(FORK_URL) --fork-block-number $$FORK_BLOCK_NUM --match-path test/$(TEST).test.sol -vvv
else
	@FORK_BLOCK_NUM=$$(cast block-number --rpc-url $(FORK_URL)) && \
	forge test --fork-url $(FORK_URL) --fork-block-number $$FORK_BLOCK_NUM -vvv
endif

test-solution:
ifdef TEST
	@FORK_BLOCK_NUM=$$(cast block-number --rpc-url $(FORK_URL)) && \
	FOUNDRY_PROFILE=solution forge test --fork-url $(FORK_URL) --fork-block-number $$FORK_BLOCK_NUM --match-path test/$(TEST).test.sol -vvv
else
	@FORK_BLOCK_NUM=$$(cast block-number --rpc-url $(FORK_URL)) && \
	FOUNDRY_PROFILE=solution forge test --fork-url $(FORK_URL) --fork-block-number $$FORK_BLOCK_NUM -vvv
endif
