.PHONY: help setup open build test clean lint

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Generate Xcode project
	@echo "Generating Xcode project..."
	@./setup-xcode-project.sh

open: ## Open project in Xcode (generates if needed)
	@if [ ! -d "AxiomHiveApp.xcodeproj" ]; then \
		echo "Project not found. Generating..."; \
		./setup-xcode-project.sh; \
	fi
	@open AxiomHiveApp.xcodeproj

build: ## Build the project
	@xcodebuild -scheme AxiomHiveApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro' build

test: ## Run tests with coverage
	@xcodebuild test \
		-scheme AxiomHiveApp \
		-destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.2' \
		-enableCodeCoverage YES

lint: ## Run SwiftLint
	@swiftlint lint --strict

clean: ## Clean build artifacts and generated project
	@echo "Cleaning..."
	@rm -rf AxiomHiveApp.xcodeproj
	@xcodebuild clean -scheme AxiomHiveApp 2>/dev/null || true
	@echo "Clean complete. Run 'make setup' to regenerate project."

.DEFAULT_GOAL := help
