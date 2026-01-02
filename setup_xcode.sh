#!/bin/bash

# AxiomHiveApp Xcode Project Setup Script
# This script sets up the Xcode project for development

set -e

echo "🚀 Setting up AxiomHiveApp for Xcode..."
echo ""

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "⚠️  Warning: This script is designed for macOS."
    echo "   On other platforms, please install XcodeGen manually and run: xcodegen generate"
    exit 1
fi

# Check if XcodeGen is installed
if ! command -v xcodegen &> /dev/null; then
    echo "📦 XcodeGen not found. Installing via Homebrew..."
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew is not installed. Please install it first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    
    brew install xcodegen
fi

# Generate Xcode project
echo "🔨 Generating Xcode project..."
xcodegen generate

# Check if generation was successful
if [ $? -eq 0 ] && [ -f "AxiomHiveApp.xcodeproj/project.pbxproj" ]; then
    echo "✅ Xcode project generated successfully!"
    echo ""
    echo "📱 Next steps:"
    echo "   1. Open AxiomHiveApp.xcodeproj in Xcode"
    echo "   2. Select your development team in Signing & Capabilities"
    echo "   3. Build and run (⌘R) to test the app"
    echo ""
    echo "🎯 Opening Xcode project..."
    open AxiomHiveApp.xcodeproj
else
    echo "❌ Failed to generate Xcode project"
    exit 1
fi
