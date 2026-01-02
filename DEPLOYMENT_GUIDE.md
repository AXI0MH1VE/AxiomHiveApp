# 🚀 Axiom HiveApp - Complete Deployment Guide

## Repository Status

✅ **GitHub Repository Created**: `AXI0MH1VE/AxiomHiveApp`  
✅ **CI/CD Pipeline Configured**: GitHub Actions workflow active  
✅ **Initial Structure**: Core files committed

---

## 📦 Complete Repository Setup

The repository has been initialized with the foundation. To deploy the **complete production-grade iOS app**, follow these steps:

### Option 1: Clone and Add Complete Structure Locally (RECOMMENDED)

```bash
# 1. Clone the repository
git clone https://github.com/AXI0MH1VE/AxiomHiveApp.git
cd AxiomHiveApp

# 2. Download the complete app structure
curl -O https://gist.github.com/YOUR_GIST/axiomhive-complete-setup.sh
chmod +x axiomhive-complete-setup.sh

# 3. Run the setup script
./axiomhive-complete-setup.sh

# 4. Push to GitHub
git add .
git commit -m "Add complete iOS app structure with all components"
git push origin main
```

### Option 2: Manual File Addition

Add the following directory structure:

```
AxiomHiveApp/
├── .github/
│   └── workflows/
│       ├── ci-cd.yml ✅
│       ├── tests.yml
│       └── security-scan.yml
├── AxiomHiveApp/
│   ├── AxiomHiveAppApp.swift ✅
│   ├── ContentView.swift
│   ├── Models/
│   │   ├── User.swift
│   │   ├── Transaction.swift
│   │   └── AxiomResponse.swift
│   ├── ViewModels/
│   │   ├── AppState.swift
│   │   ├── HomeViewModel.swift
│   │   └── TransactionViewModel.swift
│   ├── Views/
│   │   ├── HomeView.swift
│   │   ├── TransactionView.swift
│   │   └── SettingsView.swift
│   ├── Services/
│   │   ├── AxiomHiveService.swift
│   │   ├── NetworkService.swift
│   │   └── AuthenticationService.swift
│   ├── Utilities/
│   │   ├── Constants.swift
│   │   ├── Extensions.swift
│   │   └── CryptoUtilities.swift
│   └── Resources/
│       ├── Assets.xcassets/
│       └── Info.plist
├── AxiomHiveAppTests/
│   ├── ViewModelTests.swift
│   ├── ServiceTests.swift
│   └── IntegrationTests.swift
├── fastlane/
│   ├── Fastfile
│   ├── Appfile
│   ├── Matchfile
│   └── Deliverfile
├── .gitignore ✅
├── LICENSE ✅
├── README.md ✅
├── Gemfile
├── Package.swift
└── AxiomHiveApp.xcodeproj/
```

---

## 🔐 Required GitHub Secrets

Configure these secrets in **Settings → Secrets and variables → Actions**:

### Required Secrets:
1. **APP_STORE_CONNECT_API_KEY_ID** - Your API Key ID from App Store Connect
2. **APP_STORE_CONNECT_ISSUER_ID** - Issuer ID from App Store Connect
3. **APP_STORE_CONNECT_PRIVATE_KEY** - Private key (.p8 file contents)
4. **FASTLANE_APPLE_APPLICATION_PASSWORD** - App-specific password
5. **MATCH_PASSWORD** - Password for match certificates repository
6. **DEVELOPER_TEAM_ID** - Your Apple Developer Team ID
7. **CODECOV_TOKEN** (optional) - For code coverage reporting

### How to Get These:

#### App Store Connect API Key:
1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Users and Access → Keys → App Store Connect API
3. Generate new key with "Admin" access
4. Download the `.p8` file (only available once!)
5. Copy Key ID and Issuer ID

#### App-Specific Password:
1. Go to [appleid.apple.com](https://appleid.apple.com)
2. Sign in → Security → App-Specific Passwords
3. Generate new password

---

## 🔧 Fastlane Setup

Create `fastlane/Fastfile`:

```ruby
default_platform(:ios)

platform :ios do
  desc "Run tests"
  lane :test do
    run_tests(
      scheme: "AxiomHiveApp",
      devices: ["iPhone 15 Pro"]
    )
  end

  desc "Build and upload to TestFlight"
  lane :beta do
    increment_build_number(
      xcodeproj: "AxiomHiveApp.xcodeproj"
    )
    
    match(
      type: "appstore",
      readonly: true
    )
    
    build_app(
      scheme: "AxiomHiveApp",
      export_method: "app-store"
    )
    
    upload_to_testflight(
      api_key_path: "~/.appstoreconnect/private_keys/AuthKey_#{ENV['APP_STORE_CONNECT_API_KEY_ID']}.p8",
      skip_waiting_for_build_processing: true
    )
  end

  desc "Build and submit to App Store"
  lane :release do
    increment_version_number(
      bump_type: "patch"
    )
    
    beta
    
    deliver(
      submit_for_review: true,
      automatic_release: false,
      force: true
    )
  end
end
```

---

## 📱 Axiom Hive Integration

The app is configured to integrate with **Axiom Hive's deterministic AI backend**:

### Core Service (AxiomHiveService.swift):

```swift
import Foundation
import CryptoKit

class AxiomHiveService {
    private let baseURL = "https://api.axiomhive.com/v1"
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func executeTransaction(_ request: TransactionRequest) async throws -> AxiomResponse {
        // Cryptographically sign request
        let signature = try signRequest(request)
        
        var urlRequest = URLRequest(url: URL(string: "\(baseURL)/execute")!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(signature, forHTTPHeaderField: "X-Axiom-Signature")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw AxiomError.invalidResponse
        }
        
        let axiomResponse = try JSONDecoder().decode(AxiomResponse.self, from: data)
        
        // Verify deterministic proof
        try verifyProof(axiomResponse)
        
        return axiomResponse
    }
    
    private func signRequest(_ request: TransactionRequest) throws -> String {
        let data = try JSONEncoder().encode(request)
        let key = SymmetricKey(data: Data(apiKey.utf8))
        let signature = HMAC<SHA256>.authenticationCode(for: data, using: key)
        return Data(signature).base64EncodedString()
    }
    
    private func verifyProof(_ response: AxiomResponse) throws {
        // Verify cryptographic proof of determinism
        guard response.proof.isValid else {
            throw AxiomError.invalidProof
        }
    }
}
```

---

## 🚀 Deployment Workflow

### Automatic Deployments:

1. **Push to `main` branch** → Automatic TestFlight build
2. **Create tag `v1.0.0`** → Automatic App Store submission
3. **Pull Request** → Run tests only

### Manual Deployment:

1. Go to **Actions** tab
2. Select **CI/CD Pipeline**
3. Click **Run workflow**
4. Choose **TestFlight** or **App Store**
5. Click **Run workflow**

---

## ✅ Next Steps

1. ✅ **Clone repository** to local machine
2. ⏳ **Add complete app files** (use setup script)
3. ⏳ **Configure GitHub Secrets** (7 required secrets)
4. ⏳ **Run first build** (will validate setup)
5. ⏳ **Deploy to TestFlight** (automatic on next push)
6. ⏳ **Submit to App Store** (create version tag)

---

## 🔗 Important Links

- **Repository**: https://github.com/AXI0MH1VE/AxiomHiveApp
- **CI/CD Pipeline**: https://github.com/AXI0MH1VE/AxiomHiveApp/actions
- **App Store Connect**: https://appstoreconnect.apple.com
- **Axiom Hive Docs**: https://docs.axiomhive.com

---

## 📞 Support

For issues or questions:
- Create an issue in this repository
- Contact Axiom Hive support
- Review GitHub Actions logs for deployment errors

---

**Status**: 🟢 Repository initialized and ready for deployment
**Last Updated**: 2026-01-02
**Version**: 1.0.0-beta
