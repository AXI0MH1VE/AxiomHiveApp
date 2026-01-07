#!/bin/bash
# AxiomHiveApp Automated Setup Script
# This script validates your environment and guides you through deployment

set -e

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
XCODE_VERSION=$(xcodebuild -version 2>/dev/null | head -n1 | cut -d' ' -f2)
if [[ $(echo "$XCODE_VERSION >= 15.0" | bc -l) ]]; then
    check "Xcode $XCODE_VERSION installed"
else
    check "Xcode 15+ required (found $XCODE_VERSION)"
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
        check "Bundler installed"
    else
        check "Bundler not found (install with: gem install bundler)"
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

# Check 8: GitHub Actions workflow
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
    echo "1. Configure GitHub Secrets (see SETUP_GUIDE.md)"
    echo "2. Run: bundle install"
    echo "3. Run: fastlane test"
    echo "4. Deploy with: fastlane beta"
else
    echo -e "${RED}❌ $FAILED_CHECKS check(s) failed${NC}"
    echo ""
    echo "Please resolve the issues above before proceeding."
    exit 1
fi
