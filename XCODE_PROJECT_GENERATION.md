# AxiomHiveApp Xcode Project Generation

## Overview

This repository uses a generator-based approach for the Xcode project structure. The `.xcodeproj` directory and its contents are generated from scripts rather than being committed directly to the repository.

## Why Generator Scripts?

1. **Reproducibility**: Everyone gets the same project structure
2. **Maintainability**: Easier to update project settings across the team
3. **Version Control**: Scripts are easier to review than binary `.pbxproj` files
4. **Automation**: CI/CD can regenerate the project automatically

## Generation Methods

Three methods are provided for maximum flexibility:

### Method 1: Shell Script (Fastest)

```bash
./setup-xcode-project.sh
```

**Pros**:
- Fastest execution
- No additional dependencies
- Single command

**Use when**: You have a Unix-like shell (macOS, Linux, WSL)

### Method 2: Python Script (Cross-platform)

```bash
python3 generate-xcode-project.py
```

**Pros**:
- Works on any platform with Python 3
- More readable code
- Easier to modify

**Use when**: You prefer Python or need cross-platform compatibility

### Method 3: Automatic (CI/CD)

The GitHub Actions workflow automatically runs the Python generator if the `.xcodeproj` directory doesn't exist.

**Pros**:
- Zero manual intervention
- Guaranteed consistency in CI/CD
- Always up-to-date

**Use when**: Running in CI/CD or automated environments

## Generated Structure

The generators create:

```
AxiomHiveApp.xcodeproj/
├── project.pbxproj                           # Main project file
├── project.xcworkspace/
│   └── contents.xcworkspacedata              # Workspace metadata
└── xcshareddata/
    └── xcschemes/
        └── AxiomHiveApp.xcscheme             # Build scheme
```

## Project Configuration

### Target Settings
- **Name**: AxiomHiveApp
- **Bundle ID**: com.axiomhive.AxiomHiveApp
- **Platform**: iOS 17.0+
- **Language**: Swift 5.9
- **Architecture**: Universal (iPhone & iPad)

### Build Configurations
- **Debug**: Development builds with symbols
- **Release**: Optimized production builds

### Source Files Included

All Swift files are automatically included:

**App Entry**
- AxiomHiveAppApp.swift

**Models**
- User.swift
- Transaction.swift
- AxiomResponse.swift

**Services**
- NetworkService.swift
- AxiomHiveService.swift
- AuthenticationService.swift

**ViewModels**
- AppState.swift
- HomeViewModel.swift
- TransactionViewModel.swift

**Views**
- ContentView.swift
- HomeView.swift
- SettingsView.swift
- TransactionView.swift

**Utilities**
- Constants.swift
- CryptoUtilities.swift
- Extensions.swift

**Resources**
- Assets.xcassets
- Info.plist

**Tests**
- IntegrationTests.swift
- ServiceTests.swift
- ViewModelTests.swift

## First Time Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd AxiomHiveApp
   ```

2. **Generate the Xcode project**
   ```bash
   chmod +x setup-xcode-project.sh
   ./setup-xcode-project.sh
   ```
   
   Or use Python:
   ```bash
   python3 generate-xcode-project.py
   ```

3. **Open in Xcode**
   ```bash
   open AxiomHiveApp.xcodeproj
   ```

4. **Build and run**
   - Select a simulator (e.g., iPhone 15 Pro)
   - Press ⌘+R to build and run

## Troubleshooting

### "Project file doesn't exist"

Run the generator script:
```bash
./setup-xcode-project.sh
```

### "Permission denied" when running shell script

Make it executable:
```bash
chmod +x setup-xcode-project.sh
```

### "Python not found"

Install Python 3:
```bash
brew install python3  # macOS with Homebrew
```

Or use the shell script instead.

### "xcodeproj is corrupt or invalid"

Delete and regenerate:
```bash
rm -rf AxiomHiveApp.xcodeproj
./setup-xcode-project.sh
```

## Modifying the Project

To add new files or change settings:

1. Edit the generator script (shell or Python version)
2. Add file references in the appropriate section
3. Regenerate the project
4. Test in Xcode

Example: Adding a new Swift file

In `generate-xcode-project.py`, add to the `project_pbxproj` string:

```python
# In PBXBuildFile section
AA00000100000000000000XX /* NewFile.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA00000000000000000000XX /* NewFile.swift */; };

# In PBXFileReference section  
AA00000000000000000000XX /* NewFile.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NewFile.swift; sourceTree = "<group>"; };

# In PBXSourcesBuildPhase
AA00000100000000000000XX /* NewFile.swift in Sources */,
```

Then add the file to the appropriate PBXGroup.

## CI/CD Integration

The `.github/workflows/ci-cd.yml` automatically generates the project:

```yaml
- name: Generate Xcode Project
  run: |
    if [ ! -d "AxiomHiveApp.xcodeproj" ]; then
      python3 generate-xcode-project.py
    fi
```

This ensures:
- Builds always use the latest project structure
- No manual intervention needed
- Consistent across all environments

## Git Considerations

### Should `.xcodeproj` be committed?

**Current approach**: Not committed (generated)

**Pros**:
- Smaller repository
- Easier to review changes to project structure
- No merge conflicts in `.pbxproj`

**Cons**:
- Requires generation step
- Extra setup for new contributors

**Alternative**: Commit generated project

If you prefer to commit the generated project:
1. Run the generator
2. Remove `.xcodeproj` from `.gitignore` (if present)
3. Commit: `git add AxiomHiveApp.xcodeproj && git commit`

## Compatibility

- **Xcode**: 15.2+
- **macOS**: 14.0+
- **iOS Deployment Target**: 17.0+
- **Swift**: 5.9

## Support

For issues or questions:
1. Check this guide
2. Review the generator scripts
3. Check CI/CD logs
4. File an issue on GitHub

## Advanced Usage

### Custom Project Name

Edit the generator script and change all instances of `AxiomHiveApp` to your desired name.

### Different Bundle ID

Modify the `PRODUCT_BUNDLE_IDENTIFIER` in the build settings section:

```
PRODUCT_BUNDLE_IDENTIFIER = com.yourcompany.YourApp;
```

### Adding Dependencies

To add Swift Package Manager dependencies:
1. Open the generated project in Xcode
2. File → Add Package Dependencies
3. Xcode will modify the project file
4. Update the generator script with the new dependencies section

Note: It's recommended to keep the project committed to Git if you add SPM dependencies, as the dependency resolution is stored in the project file.

## Best Practices

1. **Always regenerate after pulling**: Ensure you have the latest project structure
2. **Don't manually edit .pbxproj**: Use the generators for consistency
3. **Test after regeneration**: Verify the project builds successfully
4. **Keep generators in sync**: If you modify one, update the other
5. **Document custom changes**: Add comments explaining non-standard configurations

## Technical Details

### UUID Format

The project uses deterministic UUIDs in the format:
```
AA00000X000000000000000Y
```

Where:
- X: Object type identifier
- Y: Sequential object number

This ensures consistent IDs across regenerations.

### File References

All source files use relative paths from the project root:
```
path = AxiomHiveApp/Models/User.swift;
sourceTree = "<group>";
```

### Build Phases

Three standard build phases:
1. **Sources**: Compile Swift files
2. **Frameworks**: Link frameworks (none for this project)
3. **Resources**: Copy Assets.xcassets

### Schemes

The generated scheme includes:
- Build action (with parallelization)
- Test action (with code coverage)
- Run action (debug configuration)
- Profile action (release configuration)
- Archive action (for distribution)

All testables are marked as parallelizable for faster test execution.
