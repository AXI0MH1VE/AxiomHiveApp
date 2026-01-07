#!/bin/bash
# AxiomHiveApp Automated Setup Script
# This script validates your environment and guides you through deployment

set -e

# Parse command line arguments
NON_INTERACTIVE=false
if [[ "$1" == "--non-interactive" || "$1" == "-n" ]]; then
    NON_INTERACTIVE=true
fi

echo "🚀 AxiomHiveApp Deployment Setup"
echo "=================================="
echo ""

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check function
check() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $1"
    else
        echo -e "${RED}✗${NC} $1"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
}

FAILED_CHECKS=0

# Check 1: Xcode version
echo "Checking Xcode version..."
if command -v xcodebuild &> /dev/null; then
    XCODE_VERSION=$(xcodebuild -version 2>/dev/null | head -n1 | cut -d' ' -f2)
    if [ -n "$XCODE_VERSION" ]; then
        # Extract major version (e.g., 15 from 15.2)
        XCODE_MAJOR=$(echo "$XCODE_VERSION" | cut -d'.' -f1)
        if [ "$XCODE_MAJOR" -ge 15 ] 2>/dev/null; then
            check "Xcode $XCODE_VERSION installed"
        else
            check "Xcode 15+ required (found $XCODE_VERSION)"
        fi
    else
        check "Xcode version could not be determined"
    fi
else
    check "Xcode not found (required for iOS development)"
fi

# Check 2: SwiftLint
echo ""
echo "Checking SwiftLint..."
if command -v swiftlint &> /dev/null; then
    SWIFTLINT_VERSION=$(swiftlint version)
    check "SwiftLint $SWIFTLINT_VERSION installed"
else
    check "SwiftLint not found (install with: brew install swiftlint)"
fi

# Check 3: Ruby and Bundler
echo ""
echo "Checking Ruby environment..."
if command -v ruby &> /dev/null; then
    RUBY_VERSION=$(ruby -v | cut -d' ' -f2)
    check "Ruby $RUBY_VERSION installed"
    
    if command -v bundle &> /dev/null; then
        BUNDLER_VERSION=$(bundle --version | cut -d' ' -f3)
        check "Bundler $BUNDLER_VERSION installed"
    else
        check "Bundler not found (install with: gem install bundler)"
        if [ "$NON_INTERACTIVE" = false ]; then
            echo -e "${YELLOW}Would you like to install Bundler now? (y/n)${NC}"
            read -r INSTALL_BUNDLER
            if [[ "$INSTALL_BUNDLER" =~ ^[Yy]$ ]]; then
                echo "Installing Bundler..."
                if gem install bundler; then
                    echo -e "${GREEN}✓${NC} Bundler installed successfully"
                    FAILED_CHECKS=$((FAILED_CHECKS - 1))  # Revert the failed check
                else
                    echo -e "${RED}✗${NC} Failed to install Bundler"
                fi
            fi
        fi
    fi
else
    check "Ruby not found"
fi

# Check 4: Fastlane
echo ""
echo "Checking Fastlane..."
if command -v fastlane &> /dev/null; then
    FASTLANE_VERSION=$(fastlane --version | grep fastlane | cut -d' ' -f3)
    check "Fastlane $FASTLANE_VERSION installed"
else
    check "Fastlane not found (install with: gem install fastlane)"
fi

# Check 5: GitHub CLI (optional but helpful)
echo ""
echo "Checking GitHub CLI..."
if command -v gh &> /dev/null; then
    check "GitHub CLI installed"
else
    echo -e "${YELLOW}⚠${NC} GitHub CLI not found (install with: brew install gh)"
fi

# Check 6: Repository status
echo ""
echo "Checking repository..."
if [ -d ".git" ]; then
    check "Git repository initialized"
    
    # Check remote
    if git remote get-url origin &> /dev/null; then
        REMOTE_URL=$(git remote get-url origin)
        check "Remote configured: $REMOTE_URL"
    else
        check "No remote configured"
    fi
else
    check "Not a git repository"
fi

# Check 7: Fastlane configuration files
echo ""
echo "Checking Fastlane configuration..."
if [ -f "fastlane/Fastfile" ]; then
    check "Fastfile exists"
else
    check "Fastfile missing"
fi

if [ -f "fastlane/Appfile" ]; then
    check "Appfile exists"
else
    check "Appfile missing"
fi

if [ -f "fastlane/Matchfile" ]; then
    check "Matchfile exists"
else
    check "Matchfile missing"
fi

# Check 8: Xcode project
echo ""
echo "Checking Xcode project..."
if ls *.xcodeproj &> /dev/null; then
    PROJECT_NAME=$(ls -d *.xcodeproj | head -n1)
    check "Xcode project exists: $PROJECT_NAME"
else
    check "Xcode project missing (*.xcodeproj)"
    echo -e "${YELLOW}ℹ${NC}  Note: Xcode project file is required for Fastlane and CI/CD"
fi

# Check 9: GitHub Actions workflow
echo ""
echo "Checking CI/CD configuration..."
if [ -f ".github/workflows/ci-cd.yml" ]; then
    check "CI/CD workflow configured"
else
    check "CI/CD workflow missing"
fi

# Summary
echo ""
echo "=================================="
if [ $FAILED_CHECKS -eq 0 ]; then
    echo -e "${GREEN}✅ All checks passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Configure GitHub Secrets (see DEPLOYMENT_GUIDE.md)"
    echo "2. Run: bundle install"
    echo "3. Run: fastlane test"
    echo "4. Deploy with: fastlane beta"
else
    echo -e "${RED}❌ $FAILED_CHECKS check(s) failed${NC}"
    echo ""
    echo "Please resolve the issues above before proceeding."
    echo ""
    echo "Common fixes:"
    if ! command -v xcodebuild &> /dev/null; then
        echo "  - Install Xcode from Mac App Store"
    fi
    if ! command -v swiftlint &> /dev/null; then
        echo "  - Install SwiftLint: brew install swiftlint"
    fi
    if ! command -v bundle &> /dev/null; then
        echo "  - Install Bundler: gem install bundler"
    fi
    if ! ls *.xcodeproj &> /dev/null; then
        echo "  - Create Xcode project (see DEPLOYMENT_GUIDE.md)"
    fi
    exit 1
fi
