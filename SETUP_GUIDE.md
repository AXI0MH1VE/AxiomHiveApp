# AxiomHiveApp Setup Guide

This guide provides step-by-step instructions for setting up the AxiomHiveApp development environment and deploying to TestFlight or the App Store.

## Prerequisites

### Required Software

1. **macOS 13.0 or later**
   - This is an iOS app that requires macOS to build

2. **Xcode 15.2 or later**
   - Download from the Mac App Store
   - After installation, accept the license: `sudo xcodebuild -license accept`
   - Install command line tools: `xcode-select --install`

3. **Homebrew** (recommended)
   - Install: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

4. **Ruby 3.2 or later**
   - Check version: `ruby --version`
   - Install via Homebrew: `brew install ruby`

5. **Bundler**
   - Install: `gem install bundler`

6. **SwiftLint**
   - Install: `brew install swiftlint`

7. **Fastlane**
   - Install: `gem install fastlane`
   - Or use Bundler: `bundle install`

## Initial Setup

### 1. Clone the Repository

```bash
git clone https://github.com/AXI0MH1VE/AxiomHiveApp.git
cd AxiomHiveApp
```

### 2. Run the Setup Script

The setup script validates your environment and provides guidance on missing dependencies:

```bash
./setup.sh
```

If you see any failures, follow the instructions to install the missing components.

### 3. Install Ruby Dependencies

```bash
bundle install
```

This installs Fastlane and other Ruby dependencies specified in the Gemfile.

### 4. Open the Project in Xcode

```bash
open AxiomHiveApp.xcodeproj
```

## Configuration

### Apple Developer Account

1. **Sign in to Xcode**
   - Open Xcode → Preferences → Accounts
   - Add your Apple ID
   - Select your team

2. **Update Code Signing**
   - In Xcode, select the AxiomHiveApp target
   - Go to "Signing & Capabilities"
   - Select your team
   - Ensure "Automatically manage signing" is enabled

### App Store Connect API Key

Required for CI/CD and Fastlane automation:

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Navigate to Users and Access → Keys → App Store Connect API
3. Click the "+" button to generate a new key
4. Give it a name (e.g., "AxiomHiveApp CI/CD")
5. Select "Admin" access
6. Download the `.p8` file (only available once!)
7. Note the Key ID and Issuer ID

### GitHub Secrets

Configure these in **Settings → Secrets and variables → Actions**:

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `APP_STORE_CONNECT_API_KEY_ID` | API Key ID | From App Store Connect API key |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID | From App Store Connect API key |
| `APP_STORE_CONNECT_PRIVATE_KEY` | Private key content | Contents of the .p8 file |
| `FASTLANE_APPLE_APPLICATION_PASSWORD` | App-specific password | Generate at appleid.apple.com |
| `MATCH_PASSWORD` | Certificate encryption password | Choose a secure password |
| `DEVELOPER_TEAM_ID` | Team ID | From Apple Developer account |
| `CODECOV_TOKEN` | Code coverage token (optional) | From codecov.io |

### Environment Variables

For local development, create a `.env` file (not committed to git):

```bash
# Axiom Hive API Configuration
AXIOM_HIVE_API_KEY=your_api_key_here
AXIOM_HIVE_BASE_URL=https://api.axiomhive.com/v1

# Fastlane Configuration
FASTLANE_APPLE_ID=your.email@example.com
DEVELOPER_TEAM_ID=YOUR_TEAM_ID
MATCH_PASSWORD=your_match_password
```

## Development Workflow

### Building the App

#### Using Xcode

1. Open `AxiomHiveApp.xcodeproj`
2. Select the "AxiomHiveApp" scheme
3. Choose a simulator or device
4. Press ⌘R to build and run

#### Using xcodebuild

```bash
xcodebuild -scheme AxiomHiveApp \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  build
```

### Running Tests

#### Using Xcode

1. Press ⌘U to run all tests
2. Or navigate to Test Navigator (⌘6) and select specific tests

#### Using Fastlane

```bash
# Run all tests
fastlane test

# Run SwiftLint
fastlane lint

# Run pre-commit checks (lint + test)
fastlane pre_commit
```

### Code Quality

#### SwiftLint

SwiftLint is configured via `.swiftlint.yml`. Run manually:

```bash
swiftlint lint
```

To auto-fix issues:

```bash
swiftlint --fix
```

#### Code Coverage

After running tests, view coverage:

1. In Xcode, open the Report Navigator (⌘9)
2. Select the latest test run
3. Click the Coverage tab

## Deployment

### Code Signing with Fastlane Match

Match stores your certificates and provisioning profiles in a separate Git repository.

#### Initial Setup

1. Create a private GitHub repository for certificates
2. Run match setup:

```bash
fastlane match init
```

3. Follow the prompts to configure the certificates repo

#### Generate Certificates

```bash
# For development
fastlane match development

# For App Store
fastlane match appstore
```

### TestFlight Deployment

#### Manual Deployment

```bash
fastlane beta
```

This will:
1. Increment the build number
2. Build the app
3. Sign with App Store certificate
4. Upload to TestFlight
5. Commit and push version bump

#### Automatic Deployment

Push to the `main` branch:

```bash
git push origin main
```

GitHub Actions will automatically:
1. Run tests
2. Build the app
3. Upload to TestFlight

### App Store Deployment

#### Manual Deployment

```bash
fastlane release
```

This will:
1. Increment the version number
2. Build and upload to TestFlight
3. Submit for App Store review

#### Automatic Deployment

Create a version tag:

```bash
git tag v1.0.0
git push origin v1.0.0
```

GitHub Actions will automatically submit to the App Store.

## CI/CD Pipeline

### Workflow Overview

The GitHub Actions workflow (`.github/workflows/ci-cd.yml`) includes:

1. **Test Job**
   - Runs on every push and pull request
   - Executes SwiftLint
   - Runs unit and integration tests
   - Uploads code coverage

2. **TestFlight Job**
   - Runs on push to `main`
   - Builds and uploads to TestFlight
   - Only runs if tests pass

3. **App Store Job**
   - Runs on version tags (v*.*.*)
   - Submits to App Store review
   - Only runs if tests pass

### Manual Workflow Trigger

1. Go to the Actions tab in GitHub
2. Select "CI/CD Pipeline"
3. Click "Run workflow"
4. Choose deployment target (TestFlight or App Store)

## Troubleshooting

### Common Issues

#### "No such module 'SwiftUI'"

This error occurs when building on a non-macOS system. SwiftUI is only available on Apple platforms.

**Solution**: Build on macOS with Xcode installed.

#### "Code signing failed"

**Solutions**:
1. Run `fastlane match development` to get certificates
2. In Xcode, verify your team is selected
3. Check that your Apple ID has access to the team

#### "Provisioning profile doesn't include signing certificate"

**Solution**: 
```bash
fastlane match nuke distribution
fastlane match appstore
```

#### "Bundle identifier is already in use"

**Solution**: Change the bundle identifier in:
- Xcode project settings
- `fastlane/Appfile`
- `fastlane/Matchfile`

#### Tests Failing

**Solution**:
1. Ensure you're using the correct iOS version
2. Reset simulators: `xcrun simctl erase all`
3. Clean build folder: ⌘⇧K in Xcode

### Getting Help

1. Check the [GitHub Issues](https://github.com/AXI0MH1VE/AxiomHiveApp/issues)
2. Review [Fastlane documentation](https://docs.fastlane.tools)
3. Check [GitHub Actions logs](https://github.com/AXI0MH1VE/AxiomHiveApp/actions)

## Best Practices

### Version Management

- Use semantic versioning (MAJOR.MINOR.PATCH)
- Increment PATCH for bug fixes
- Increment MINOR for new features
- Increment MAJOR for breaking changes

### Branching Strategy

- `main` - production-ready code
- `develop` - integration branch for features
- `feature/*` - new features
- `bugfix/*` - bug fixes
- `hotfix/*` - urgent production fixes

### Code Review

- All changes should go through pull requests
- Require at least one approval
- Ensure CI passes before merging
- Keep PRs focused and small

### Testing

- Write tests for new features
- Maintain >80% code coverage
- Run tests before committing
- Use `fastlane pre_commit` regularly

## Security

### Secrets Management

- Never commit secrets to Git
- Use GitHub Secrets for CI/CD
- Use environment variables locally
- Rotate API keys regularly

### API Keys

- Store in Keychain on device
- Never hardcode in source
- Use different keys for dev/prod
- Implement key rotation

## Resources

- [Swift Documentation](https://swift.org/documentation/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Fastlane Documentation](https://docs.fastlane.tools)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [App Store Connect Help](https://developer.apple.com/help/app-store-connect/)

---

**Last Updated**: 2026-01-07  
**Version**: 1.0.0
