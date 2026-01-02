# Makefile for AxiomHiveApp
# Provides convenient commands for building, testing, and managing the project

.PHONY: help setup open build test clean xcode lint format

# Default target - show help
help:
	@echo "AxiomHiveApp - Makefile Commands"
	@echo ""
	@echo "Setup & Configuration:"
	@echo "  make setup      - Install dependencies and generate Xcode project"
	@echo "  make xcode      - Generate Xcode project using XcodeGen"
	@echo "  make open       - Open the project in Xcode"
	@echo ""
	@echo "Building:"
	@echo "  make build      - Build the project"
	@echo "  make clean      - Clean build artifacts"
	@echo ""
	@echo "Testing:"
	@echo "  make test       - Run all tests"
	@echo "  make test-unit  - Run unit tests only"
	@echo ""
	@echo "Code Quality:"
	@echo "  make lint       - Run SwiftLint"
	@echo "  make format     - Format code with SwiftFormat (if installed)"
	@echo ""
	@echo "Deployment:"
	@echo "  make beta       - Deploy to TestFlight"
	@echo "  make release    - Release to App Store"

# Setup: Install dependencies and generate project
setup:
	@echo "🚀 Setting up AxiomHiveApp..."
	@if [ "$$(uname)" = "Darwin" ]; then \
		if ! command -v xcodegen > /dev/null; then \
			echo "📦 Installing XcodeGen..."; \
			brew install xcodegen; \
		fi; \
		./setup_xcode.sh; \
	else \
		echo "⚠️  Setup script requires macOS"; \
		echo "   You can still use: make build, make test"; \
	fi

# Generate Xcode project
xcode:
	@echo "🔨 Generating Xcode project..."
	@if command -v xcodegen > /dev/null; then \
		xcodegen generate; \
		echo "✅ Xcode project generated"; \
	else \
		echo "❌ XcodeGen not found. Install with: brew install xcodegen"; \
		exit 1; \
	fi

# Open project in Xcode
open:
	@if [ -f "AxiomHiveApp.xcodeproj/project.pbxproj" ]; then \
		echo "📱 Opening Xcode project..."; \
		open AxiomHiveApp.xcodeproj; \
	elif [ -f "Package.swift" ]; then \
		echo "📦 Opening Swift Package..."; \
		open Package.swift; \
	else \
		echo "❌ No Xcode project found. Run 'make setup' first."; \
		exit 1; \
	fi

# Build the project
build:
	@echo "🔨 Building AxiomHiveApp..."
	@if [ -f "AxiomHiveApp.xcodeproj/project.pbxproj" ]; then \
		xcodebuild -scheme AxiomHiveApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro' build; \
	else \
		swift build; \
	fi

# Run all tests
test:
	@echo "🧪 Running tests..."
	@if [ -f "AxiomHiveApp.xcodeproj/project.pbxproj" ]; then \
		xcodebuild test -scheme AxiomHiveApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro'; \
	else \
		swift test; \
	fi

# Run unit tests only
test-unit:
	@echo "🧪 Running unit tests..."
	@swift test --filter AxiomHiveAppTests

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -rf .build
	@rm -rf DerivedData
	@if [ -f "AxiomHiveApp.xcodeproj/project.pbxproj" ]; then \
		xcodebuild clean -scheme AxiomHiveApp; \
	fi
	@echo "✅ Clean complete"

# Run SwiftLint
lint:
	@echo "🔍 Running SwiftLint..."
	@if command -v swiftlint > /dev/null; then \
		swiftlint lint; \
	else \
		echo "⚠️  SwiftLint not found. Install with: brew install swiftlint"; \
		echo "   Skipping lint..."; \
	fi

# Format code
format:
	@echo "✨ Formatting code..."
	@if command -v swiftformat > /dev/null; then \
		swiftformat .; \
	else \
		echo "⚠️  SwiftFormat not found. Install with: brew install swiftformat"; \
		echo "   Skipping format..."; \
	fi

# Deploy to TestFlight
beta:
	@echo "🚀 Deploying to TestFlight..."
	@if command -v fastlane > /dev/null; then \
		fastlane beta; \
	else \
		echo "❌ Fastlane not found. Install with: gem install fastlane"; \
		exit 1; \
	fi

# Release to App Store
release:
	@echo "🚀 Releasing to App Store..."
	@if command -v fastlane > /dev/null; then \
		fastlane release; \
	else \
		echo "❌ Fastlane not found. Install with: gem install fastlane"; \
		exit 1; \
	fi

# Install development tools
install-tools:
	@echo "📦 Installing development tools..."
	@if [ "$$(uname)" = "Darwin" ]; then \
		if ! command -v brew > /dev/null; then \
			echo "❌ Homebrew not found. Install from: https://brew.sh"; \
			exit 1; \
		fi; \
		echo "Installing XcodeGen..."; \
		brew install xcodegen; \
		echo "Installing SwiftLint..."; \
		brew install swiftlint; \
		echo "Installing SwiftFormat..."; \
		brew install swiftformat; \
		echo "✅ Tools installed"; \
	else \
		echo "⚠️  Tool installation requires macOS"; \
	fi
