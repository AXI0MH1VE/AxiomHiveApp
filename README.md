# AxiomHiveApp

Production-grade iOS app with Swift/SwiftUI, MVVM architecture, and Axiom Hive deterministic AI integration. Enterprise-ready with full CI/CD automation.

## 🚀 Quick Start

### Prerequisites

- macOS 13.0 or later
- Xcode 15.2 or later
- Ruby 3.2 or later
- Bundler (install with `gem install bundler`)
- SwiftLint (install with `brew install swiftlint`)
- Fastlane (install with `gem install fastlane`)

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/AXI0MH1VE/AxiomHiveApp.git
   cd AxiomHiveApp
   ```

2. **Run the setup script**
   ```bash
   ./setup.sh
   ```

3. **Install dependencies**
   ```bash
   bundle install
   ```

4. **Open in Xcode**
   ```bash
   open AxiomHiveApp.xcodeproj
   ```

## 📋 Features

- **MVVM Architecture** - Clean separation of concerns
- **SwiftUI** - Modern declarative UI framework
- **Async/Await** - Swift concurrency for better performance
- **CryptoKit Integration** - HMAC-SHA256 signing and verification
- **Keychain Storage** - Secure credential management
- **Comprehensive Testing** - Unit and integration tests
- **CI/CD Pipeline** - Automated testing and deployment
- **Fastlane Integration** - Streamlined build and release process

## 🏗️ Architecture

```
AxiomHiveApp/
├── Models/           # Data models (User, Transaction, AxiomResponse)
├── Views/            # SwiftUI views (Home, Transaction, Settings)
├── ViewModels/       # Business logic and state management
├── Services/         # API and network services
├── Utilities/        # Helper functions and extensions
└── Resources/        # Assets and configuration
```

## 🔧 Development

### Building

```bash
# Build the project
xcodebuild -scheme AxiomHiveApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro'

# Or use Fastlane
fastlane test
```

### Testing

```bash
# Run all tests
fastlane test

# Run SwiftLint
fastlane lint

# Run pre-commit checks
fastlane pre_commit
```

## 🚢 Deployment

### TestFlight

```bash
fastlane beta
```

### App Store

```bash
fastlane release
```

## 🔐 Configuration

### GitHub Secrets

Configure these in **Settings → Secrets and variables → Actions**:

- `APP_STORE_CONNECT_API_KEY_ID` - Your API Key ID
- `APP_STORE_CONNECT_ISSUER_ID` - Issuer ID
- `APP_STORE_CONNECT_PRIVATE_KEY` - Private key (.p8 file)
- `FASTLANE_APPLE_APPLICATION_PASSWORD` - App-specific password
- `MATCH_PASSWORD` - Certificate repository password
- `DEVELOPER_TEAM_ID` - Apple Developer Team ID
- `CODECOV_TOKEN` (optional) - Code coverage reporting

### Environment Variables

- `AXIOM_HIVE_API_KEY` - Your Axiom Hive API key
- `AXIOM_HIVE_BASE_URL` - API base URL (default: https://api.axiomhive.com/v1)

## 📚 Documentation

- [Setup Guide](SETUP_GUIDE.md) - Step-by-step setup instructions
- [Deployment Guide](DEPLOYMENT_GUIDE.md) - Complete deployment instructions
- [Implementation Summary](IMPLEMENTATION_SUMMARY.md) - Technical details
- [CI/CD Workflow](.github/workflows/ci-cd.yml) - Automation configuration

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- **Repository**: https://github.com/AXI0MH1VE/AxiomHiveApp
- **Issues**: https://github.com/AXI0MH1VE/AxiomHiveApp/issues
- **CI/CD**: https://github.com/AXI0MH1VE/AxiomHiveApp/actions

## 📞 Support

For questions or issues:
- Create an issue in this repository
- Contact Axiom Hive support
- Review GitHub Actions logs for CI/CD issues

---

**Status**: ✅ Production Ready  
**Version**: 1.0.0  
**iOS**: 17.0+  
**Swift**: 5.9+
