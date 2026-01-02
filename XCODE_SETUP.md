# Xcode Project Setup

This repository includes generator scripts to create the complete Xcode project structure for AxiomHiveApp.

## Quick Start

Choose one of the following methods to generate the Xcode project:

### Option 1: Shell Script (Recommended)

```bash
chmod +x setup-xcode-project.sh
./setup-xcode-project.sh
```

### Option 2: Python Script

```bash
python3 generate-xcode-project.py
```

Either method will create:
- `AxiomHiveApp.xcodeproj/project.pbxproj` - Main project file
- `AxiomHiveApp.xcodeproj/project.xcworkspace/contents.xcworkspacedata` - Workspace configuration  
- `AxiomHiveApp.xcodeproj/xcshareddata/xcschemes/AxiomHiveApp.xcscheme` - Build scheme

## Project Configuration

- **Target**: iOS 17.0+
- **Swift Version**: 5.9
- **Bundle ID**: com.axiomhive.AxiomHiveApp
- **Xcode Version**: 15.2+
- **Code Signing**: Automatic (development)

## Opening the Project

After running the setup script, open the project in Xcode:

```bash
open AxiomHiveApp.xcodeproj
```

## CI/CD Compatibility

The project is configured to work with the existing GitHub Actions workflow that uses:

```bash
xcodebuild test -scheme AxiomHiveApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.2'
```

## Project Structure

The Xcode project includes all source files organized by function:

- **Models**: User, Transaction, AxiomResponse
- **Services**: NetworkService, AxiomHiveService, AuthenticationService
- **ViewModels**: AppState, HomeViewModel, TransactionViewModel
- **Views**: ContentView, HomeView, SettingsView, TransactionView
- **Utilities**: Constants, CryptoUtilities, Extensions
- **Resources**: Assets.xcassets, Info.plist
- **Tests**: IntegrationTests, ServiceTests, ViewModelTests
