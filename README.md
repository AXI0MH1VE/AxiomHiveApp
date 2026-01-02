# AxiomHiveApp

Production-grade iOS app with Swift/SwiftUI, MVVM architecture, and Axiom Hive deterministic AI integration. Enterprise-ready with full CI/CD automation.

## 🚀 Quick Start

### Setting up for Xcode

1. **Clone the repository:**
   ```bash
   git clone https://github.com/AXI0MH1VE/AxiomHiveApp.git
   cd AxiomHiveApp
   ```

2. **Open in Xcode:**
   ```bash
   open Package.swift
   ```
   
   Or run the setup script for a traditional Xcode project:
   ```bash
   ./setup_xcode.sh
   ```

3. **Build and Run:**
   - Select the `AxiomHiveApp` scheme
   - Choose a simulator or device
   - Press `⌘R`

📖 **Detailed setup instructions:** See [XCODE_SETUP.md](XCODE_SETUP.md)

## 📋 Features

- ✅ SwiftUI-based modern iOS interface
- ✅ MVVM architecture for clean separation of concerns
- ✅ Axiom Hive deterministic AI integration
- ✅ Secure authentication and cryptographic utilities
- ✅ Comprehensive unit tests
- ✅ CI/CD automation with GitHub Actions
- ✅ Fastlane integration for deployment

## 📦 Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- macOS 13.0+ (for development)

## 🏗 Project Structure

```
AxiomHiveApp/
├── AxiomHiveApp/           # Main application
│   ├── Models/             # Data models
│   ├── Views/              # SwiftUI views
│   ├── ViewModels/         # MVVM view models
│   ├── Services/           # Business logic & networking
│   ├── Utilities/          # Helper functions & extensions
│   └── Resources/          # Assets & configuration
├── AxiomHiveAppTests/      # Unit tests
└── fastlane/               # Deployment automation
```

## 🧪 Testing

Run tests in Xcode: `⌘U`

Or via command line:
```bash
swift test
```

## 🚀 Deployment

See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) for complete deployment instructions.

Quick deploy to TestFlight:
```bash
fastlane beta
```

## 📄 Documentation

- [Xcode Setup Guide](XCODE_SETUP.md) - Detailed setup instructions
- [Deployment Guide](DEPLOYMENT_GUIDE.md) - CI/CD and App Store deployment
- [Implementation Summary](IMPLEMENTATION_SUMMARY.md) - Technical details

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write/update tests
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
