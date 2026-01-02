# Setting Up AxiomHiveApp for Xcode

This guide will help you set up the AxiomHiveApp project for development in Xcode.

## Prerequisites

- macOS 13.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later

## Quick Setup (Recommended)

The fastest way to get started is to use Swift Package Manager's Xcode integration:

### Method 1: Open Package.swift Directly in Xcode

1. Clone the repository:
   ```bash
   git clone https://github.com/AXI0MH1VE/AxiomHiveApp.git
   cd AxiomHiveApp
   ```

2. Open the package in Xcode:
   ```bash
   open Package.swift
   ```
   
   Or simply double-click `Package.swift` in Finder.

3. Xcode will automatically:
   - Resolve dependencies
   - Index the project
   - Configure build settings
   - Set up schemes

4. Select the `AxiomHiveApp` scheme and an iOS simulator or device.

5. Press `⌘R` to build and run!

### Method 2: Use XcodeGen (Advanced)

For a more traditional Xcode project with custom build settings:

1. Install XcodeGen (if not already installed):
   ```bash
   brew install xcodegen
   ```

2. Run the setup script:
   ```bash
   chmod +x setup_xcode.sh
   ./setup_xcode.sh
   ```

3. This will:
   - Generate `AxiomHiveApp.xcodeproj` from `project.yml`
   - Open the project in Xcode automatically

## Project Structure

```
AxiomHiveApp/
├── AxiomHiveApp/           # Main app target
│   ├── AxiomHiveAppApp.swift
│   ├── Models/             # Data models
│   ├── Views/              # SwiftUI views
│   ├── ViewModels/         # MVVM view models
│   ├── Services/           # Business logic & API
│   ├── Utilities/          # Helper functions
│   └── Resources/          # Assets & Info.plist
├── AxiomHiveAppTests/      # Unit tests
├── Package.swift           # Swift Package definition
├── project.yml             # XcodeGen configuration
└── setup_xcode.sh          # Setup automation script
```

## Building the Project

### Using Xcode

1. Open the project (via `Package.swift` or `.xcodeproj`)
2. Select the `AxiomHiveApp` scheme
3. Choose a simulator or connected device
4. Build: `⌘B`
5. Run: `⌘R`
6. Test: `⌘U`

### Using Command Line

```bash
# Build
swift build

# Run tests
swift test

# Generate Xcode project (if needed)
swift package generate-xcodeproj
```

Or using xcodebuild:

```bash
# Build
xcodebuild -scheme AxiomHiveApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro'

# Run tests
xcodebuild test -scheme AxiomHiveApp -destination 'platform=iOS Simulator,name=iPhone 15 Pro'
```

## Configuration

### Development Team

Before you can run on a device, you need to configure your development team:

1. In Xcode, select the project in the navigator
2. Select the `AxiomHiveApp` target
3. Go to "Signing & Capabilities"
4. Select your Team from the dropdown
5. Xcode will automatically manage provisioning profiles

### Bundle Identifier

The default bundle identifier is `com.axiomhive.AxiomHiveApp`. To change it:

1. Edit `project.yml` and update `PRODUCT_BUNDLE_IDENTIFIER`
2. Regenerate the project: `xcodegen generate`

Or if using Package.swift directly:

1. Select the target in Xcode
2. Update the bundle identifier in Build Settings

## Troubleshooting

### "No such module" errors

If you see import errors:
1. Clean build folder: `⌘⇧K` or Product > Clean Build Folder
2. Reset package caches: File > Packages > Reset Package Caches
3. Rebuild: `⌘B`

### Signing errors

If you see code signing errors:
1. Make sure you're signed into Xcode with your Apple ID
2. Select your development team in Signing & Capabilities
3. For device deployment, ensure you have a valid provisioning profile

### XcodeGen not found

If the setup script fails:
1. Install Homebrew (if not installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Install XcodeGen:
   ```bash
   brew install xcodegen
   ```

3. Run the setup script again

## Running Tests

### In Xcode

- Run all tests: `⌘U`
- Run a specific test: Click the diamond icon next to the test
- View test results: `⌘9` to open Test Navigator

### Command Line

```bash
# All tests
swift test

# Specific test
swift test --filter AxiomHiveAppTests.ViewModelTests

# With coverage
swift test --enable-code-coverage
```

## CI/CD Integration

The project includes GitHub Actions workflows for:
- Automated testing on pull requests
- Building and archiving releases
- TestFlight deployment

See `.github/workflows/` for details.

## Next Steps

1. ✅ Set up Xcode project
2. 📱 Configure signing for your team
3. 🔨 Build and run the app
4. ✏️ Start developing!
5. 🧪 Write tests for new features
6. 🚀 Deploy via fastlane (see `DEPLOYMENT_GUIDE.md`)

## Additional Resources

- [Swift Package Manager Documentation](https://swift.org/package-manager/)
- [XcodeGen Documentation](https://github.com/yonaskolb/XcodeGen)
- [Axiom Hive Documentation](https://docs.axiomhive.com)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)

## Getting Help

- Check existing GitHub issues
- Create a new issue with details about your problem
- Include Xcode version, macOS version, and error messages
