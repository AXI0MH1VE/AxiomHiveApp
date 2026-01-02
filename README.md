# AxiomHiveApp

Production-grade iOS app with Swift/SwiftUI, MVVM architecture, and Axiom Hive deterministic AI integration. Enterprise-ready with full CI/CD automation.

## ⚡ Quick Start

**First time setup** - Generate the Xcode project (takes 5 seconds):

```bash
# Option 1: Using Make (simplest)
make setup && make open

# Option 2: Direct script execution
chmod +x setup-xcode-project.sh && ./setup-xcode-project.sh
open AxiomHiveApp.xcodeproj
```

See [QUICKSTART.md](QUICKSTART.md) for alternative methods.

## 🏗️ Project Setup

### Prerequisites

- macOS 14+
- Xcode 15.2+
- Swift 5.9+
- iOS 17.0+ (target deployment)
- Python 3 (for project generation)

### Generating the Xcode Project

The Xcode project structure is generated from scripts to ensure consistency and reproducibility.

**Option 1: Shell Script (Recommended)**
```bash
chmod +x setup-xcode-project.sh
./setup-xcode-project.sh
```

**Option 2: Python Script**
```bash
python3 generate-xcode-project.py
```

**Option 3: Automatic Generation (CI/CD)**
The CI/CD pipeline automatically generates the project if it doesn't exist.

### Opening the Project

After generation, open the project in Xcode:
```bash
open AxiomHiveApp.xcodeproj
```

## 📱 Features

- **SwiftUI**: Modern declarative UI framework
- **MVVM Architecture**: Clean separation of concerns
- **Axiom Hive Integration**: Deterministic AI services
- **Comprehensive Testing**: Unit, integration, and UI tests
- **CI/CD Pipeline**: Automated builds and deployments
- **Code Quality**: SwiftLint integration

## 🏛️ Architecture

```
AxiomHiveApp/
├── AxiomHiveAppApp.swift      # App entry point
├── Models/                     # Data models
│   ├── User.swift
│   ├── Transaction.swift
│   └── AxiomResponse.swift
├── Services/                   # Business logic & API
│   ├── NetworkService.swift
│   ├── AxiomHiveService.swift
│   └── AuthenticationService.swift
├── ViewModels/                 # View state management
│   ├── AppState.swift
│   ├── HomeViewModel.swift
│   └── TransactionViewModel.swift
├── Views/                      # SwiftUI views
│   ├── ContentView.swift
│   ├── HomeView.swift
│   ├── SettingsView.swift
│   └── TransactionView.swift
├── Utilities/                  # Helper functions
│   ├── Constants.swift
│   ├── CryptoUtilities.swift
│   └── Extensions.swift
└── Resources/                  # Assets & configuration
    ├── Assets.xcassets
    └── Info.plist
```

## 🧪 Testing

Run tests via Xcode or command line:

```bash
xcodebuild test \
  -scheme AxiomHiveApp \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.2' \
  -enableCodeCoverage YES
```

Test suite includes:
- **Unit Tests**: Service and ViewModel tests
- **Integration Tests**: End-to-end flows
- **Code Coverage**: Tracked via Codecov

## 🚀 Deployment

### TestFlight (Beta)

```bash
fastlane beta
```

### App Store (Production)

```bash
fastlane release
```

### CI/CD Pipeline

The GitHub Actions workflow automatically:
1. Runs SwiftLint checks
2. Executes test suite
3. Builds and archives the app
4. Deploys to TestFlight/App Store

See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) for detailed instructions.

## 📋 Requirements

- iOS 17.0+
- Swift 5.9
- Xcode 15.2+

## 🔧 Configuration

### Bundle Identifier
```
com.axiomhive.AxiomHiveApp
```

### App Store Connect
Configure secrets in GitHub repository settings:
- `APP_STORE_CONNECT_API_KEY_ID`
- `APP_STORE_CONNECT_ISSUER_ID`
- `APP_STORE_CONNECT_PRIVATE_KEY`
- `MATCH_PASSWORD`

## 📚 Documentation

- [Xcode Setup Guide](XCODE_SETUP.md)
- [Deployment Guide](DEPLOYMENT_GUIDE.md)
- [Implementation Summary](IMPLEMENTATION_SUMMARY.md)

## 📄 License

See [LICENSE](LICENSE) for details.

## 🤝 Contributing

1. Generate the Xcode project using one of the provided scripts
2. Open `AxiomHiveApp.xcodeproj` in Xcode
3. Make your changes
4. Run tests and SwiftLint
5. Submit a pull request

## 🛠️ Development

### Make Commands

This project includes a Makefile for common tasks:

```bash
make help       # Show all available commands
make setup      # Generate Xcode project
make open       # Open project in Xcode (generates if needed)
make build      # Build the project
make test       # Run tests with coverage
make lint       # Run SwiftLint
make clean      # Clean build artifacts and generated project
```

### Code Style

This project uses SwiftLint for code style enforcement:
```bash
swiftlint lint --strict
```

### Swift Package Manager

While an Xcode project is used for development and CI/CD, the app is also structured as a Swift Package for better modularity.

