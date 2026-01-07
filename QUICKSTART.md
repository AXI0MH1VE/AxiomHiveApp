# Xcode Project Setup - Quick Start

## ⚠️ Important: One-Time Setup Required

The Xcode project files need to be generated before first use. This is a one-time step that takes less than 5 seconds.

## Quick Setup (Choose One)

### Option 1: Make ⚡ (Simplest)

```bash
make setup
```

Or to setup and open in one command:
```bash
make setup && make open
```

### Option 2: Shell Script 🔧

```bash
chmod +x setup-xcode-project.sh &&./setup-xcode-project.sh
```

### Option 3: Python Script 🐍

```bash
python3 generate-xcode-project.py
```

### Option 4: CI/CD 🤖 (Automatic)

If you're running in CI/CD, the project generates automatically. No action needed!

## What Gets Created

Running either script creates:

```
AxiomHiveApp.xcodeproj/
├── project.pbxproj (Xcode project file)
├── project.xcworkspace/
│   └── contents.xcworkspacedata  
└── xcshareddata/xcschemes/
    └── AxiomHiveApp.xcscheme
```

## After Generation

Open the project:

```bash
open AxiomHiveApp.xcodeproj
```

Or double-click `AxiomHiveApp.xcodeproj` in Finder.

## Project Details

- **Target**: iOS 17.0+
- **Swift**: 5.9
- **Bundle ID**: com.axiomhive.AxiomHiveApp
- **Xcode**: 15.2+

## Need Help?

See detailed documentation:
- [XCODE_PROJECT_GENERATION.md](XCODE_PROJECT_GENERATION.md) - Complete guide
- [XCODE_SETUP.md](XCODE_SETUP.md) - Setup instructions
- [README.md](README.md) - Full project documentation

## Troubleshooting

**"Permission denied"**
```bash
chmod +x setup-xcode-project.sh
```

**"Python not found"**
- Use the shell script instead, OR
- Install Python: `brew install python3`

**"Directory already exists"**
- That's fine! The project is already set up.
- Just run: `open AxiomHiveApp.xcodeproj`
