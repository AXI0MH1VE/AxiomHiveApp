# 🚀 Quick Start Guide

Welcome to AxiomHiveApp! Get started in 3 simple steps.

## For macOS Users

### Option 1: Open with Swift Package (Recommended)
```bash
git clone https://github.com/AXI0MH1VE/AxiomHiveApp.git
cd AxiomHiveApp
open Package.swift
```

Press `⌘R` in Xcode to run!

### Option 2: Generate Xcode Project
```bash
git clone https://github.com/AXI0MH1VE/AxiomHiveApp.git
cd AxiomHiveApp
./setup_xcode.sh
```

### Option 3: Use Makefile
```bash
git clone https://github.com/AXI0MH1VE/AxiomHiveApp.git
cd AxiomHiveApp
make setup
```

## For Linux/CI Users

```bash
git clone https://github.com/AXI0MH1VE/AxiomHiveApp.git
cd AxiomHiveApp
swift build
swift test
```

## Available Commands

```bash
make help          # Show all available commands
make setup         # Setup and open Xcode project
make build         # Build the project
make test          # Run tests
make lint          # Run SwiftLint
make beta          # Deploy to TestFlight
```

## What's Next?

1. ✅ Project is ready to build and run
2. 📱 Configure your development team in Xcode (Signing & Capabilities)
3. 🔨 Start coding!
4. 🧪 Write tests for new features
5. 🚀 Deploy with `make beta`

## Need Help?

- 📖 Detailed setup: [XCODE_SETUP.md](XCODE_SETUP.md)
- 🚀 Deployment guide: [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)
- 📝 Technical details: [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)
- 🐛 Issues: [GitHub Issues](https://github.com/AXI0MH1VE/AxiomHiveApp/issues)

## Requirements

- **iOS**: 17.0+
- **Xcode**: 15.0+
- **Swift**: 5.9+
- **macOS**: 13.0+ (for development)

Happy coding! 🎉
