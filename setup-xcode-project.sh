#!/bin/bash

# Script to create Xcode project structure for AxiomHiveApp
# This script creates all necessary .xcodeproj files and directories

cd "$(dirname "$0")"

echo "Creating Xcode project structure..."

# Create directory structure
mkdir -p AxiomHiveApp.xcodeproj/project.xcworkspace
mkdir -p AxiomHiveApp.xcodeproj/xcshareddata/xcschemes

# Create project.pbxproj
cat > AxiomHiveApp.xcodeproj/project.pbxproj << 'EOF'
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {

/* Begin PBXBuildFile section */
		AA0000010000000000000001 /* AxiomHiveAppApp.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000001 /* AxiomHiveAppApp.swift */; };
		AA0000010000000000000002 /* User.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000002 /* User.swift */; };
		AA0000010000000000000003 /* Transaction.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000003 /* Transaction.swift */; };
		AA0000010000000000000004 /* AxiomResponse.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000004 /* AxiomResponse.swift */; };
		AA0000010000000000000005 /* NetworkService.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000005 /* NetworkService.swift */; };
		AA0000010000000000000006 /* AxiomHiveService.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000006 /* AxiomHiveService.swift */; };
		AA0000010000000000000007 /* AuthenticationService.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000007 /* AuthenticationService.swift */; };
		AA0000010000000000000008 /* AppState.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000008 /* AppState.swift */; };
		AA0000010000000000000009 /* HomeViewModel.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000009 /* HomeViewModel.swift */; };
		AA000001000000000000000A /* TransactionViewModel.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA000000000000000000000A /* TransactionViewModel.swift */; };
		AA000001000000000000000B /* ContentView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA000000000000000000000B /* ContentView.swift */; };
		AA000001000000000000000C /* HomeView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA000000000000000000000C /* HomeView.swift */; };
		AA000001000000000000000D /* SettingsView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA000000000000000000000D /* SettingsView.swift */; };
		AA000001000000000000000E /* TransactionView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA000000000000000000000E /* TransactionView.swift */; };
		AA000001000000000000000F /* Constants.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA000000000000000000000F /* Constants.swift */; };
		AA0000010000000000000010 /* CryptoUtilities.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000010 /* CryptoUtilities.swift */; };
		AA0000010000000000000011 /* Extensions.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000011 /* Extensions.swift */; };
		AA0000010000000000000012 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000012 /* Assets.xcassets */; };
		AA0000010000000000000020 /* IntegrationTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000020 /* IntegrationTests.swift */; };
		AA0000010000000000000021 /* ServiceTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000021 /* ServiceTests.swift */; };
		AA0000010000000000000022 /* ViewModelTests.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA0000000000000000000022 /* ViewModelTests.swift */; };
/* End PBXBuildFile section */

/* Begin PBXContainerItemProxy section */
		AA0000030000000000000001 /* PBXContainerItemProxy */ = {
			isa = PBXContainerItemProxy;
			containerPortal = AA0000050000000000000001 /* Project object */;
			proxyType = 1;
			remoteGlobalIDString = AA0000020000000000000001;
			remoteInfo = AxiomHiveApp;
		};
/* End PBXContainerItemProxy section */

/* Begin PBXFileReference section */
		AA0000020000000000000002 /* AxiomHiveApp.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = AxiomHiveApp.app; sourceTree = BUILT_PRODUCTS_DIR; };
		AA0000000000000000000001 /* AxiomHiveAppApp.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AxiomHiveAppApp.swift; sourceTree = "<group>"; };
		AA0000000000000000000002 /* User.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = User.swift; sourceTree = "<group>"; };
		AA0000000000000000000003 /* Transaction.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Transaction.swift; sourceTree = "<group>"; };
		AA0000000000000000000004 /* AxiomResponse.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AxiomResponse.swift; sourceTree = "<group>"; };
		AA0000000000000000000005 /* NetworkService.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = NetworkService.swift; sourceTree = "<group>"; };
		AA0000000000000000000006 /* AxiomHiveService.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AxiomHiveService.swift; sourceTree = "<group>"; };
		AA0000000000000000000007 /* AuthenticationService.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AuthenticationService.swift; sourceTree = "<group>"; };
		AA0000000000000000000008 /* AppState.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppState.swift; sourceTree = "<group>"; };
		AA0000000000000000000009 /* HomeViewModel.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = HomeViewModel.swift; sourceTree = "<group>"; };
		AA000000000000000000000A /* TransactionViewModel.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TransactionViewModel.swift; sourceTree = "<group>"; };
		AA000000000000000000000B /* ContentView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ContentView.swift; sourceTree = "<group>"; };
		AA000000000000000000000C /* HomeView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = HomeView.swift; sourceTree = "<group>"; };
		AA000000000000000000000D /* SettingsView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = SettingsView.swift; sourceTree = "<group>"; };
		AA000000000000000000000E /* TransactionView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = TransactionView.swift; sourceTree = "<group>"; };
		AA000000000000000000000F /* Constants.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Constants.swift; sourceTree = "<group>"; };
		AA0000000000000000000010 /* CryptoUtilities.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = CryptoUtilities.swift; sourceTree = "<group>"; };
		AA0000000000000000000011 /* Extensions.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Extensions.swift; sourceTree = "<group>"; };
		AA0000000000000000000012 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
		AA0000000000000000000013 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
		AA0000020000000000000020 /* AxiomHiveAppTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = AxiomHiveAppTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; };
		AA0000000000000000000020 /* IntegrationTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = IntegrationTests.swift; sourceTree = "<group>"; };
		AA0000000000000000000021 /* ServiceTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ServiceTests.swift; sourceTree = "<group>"; };
		AA0000000000000000000022 /* ViewModelTests.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewModelTests.swift; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		AA0000040000000000000001 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		AA0000040000000000000002 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		AA0000060000000000000001 = {
			isa = PBXGroup;
			children = (
				AA0000060000000000000002 /* AxiomHiveApp */,
				AA0000060000000000000020 /* AxiomHiveAppTests */,
				AA0000060000000000000003 /* Products */,
			);
			sourceTree = "<group>";
		};
		AA0000060000000000000003 /* Products */ = {
			isa = PBXGroup;
			children = (
				AA0000020000000000000002 /* AxiomHiveApp.app */,
				AA0000020000000000000020 /* AxiomHiveAppTests.xctest */,
			);
			name = Products;
			sourceTree = "<group>";
		};
		AA0000060000000000000002 /* AxiomHiveApp */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000000000001 /* AxiomHiveAppApp.swift */,
				AA0000060000000000000004 /* Models */,
				AA0000060000000000000005 /* Services */,
				AA0000060000000000000006 /* ViewModels */,
				AA0000060000000000000007 /* Views */,
				AA0000060000000000000008 /* Utilities */,
				AA0000060000000000000009 /* Resources */,
			);
			path = AxiomHiveApp;
			sourceTree = "<group>";
		};
		AA0000060000000000000004 /* Models */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000000000004 /* AxiomResponse.swift */,
				AA0000000000000000000003 /* Transaction.swift */,
				AA0000000000000000000002 /* User.swift */,
			);
			path = Models;
			sourceTree = "<group>";
		};
		AA0000060000000000000005 /* Services */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000000000007 /* AuthenticationService.swift */,
				AA0000000000000000000006 /* AxiomHiveService.swift */,
				AA0000000000000000000005 /* NetworkService.swift */,
			);
			path = Services;
			sourceTree = "<group>";
		};
		AA0000060000000000000006 /* ViewModels */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000000000008 /* AppState.swift */,
				AA0000000000000000000009 /* HomeViewModel.swift */,
				AA000000000000000000000A /* TransactionViewModel.swift */,
			);
			path = ViewModels;
			sourceTree = "<group>";
		};
		AA0000060000000000000007 /* Views */ = {
			isa = PBXGroup;
			children = (
				AA000000000000000000000B /* ContentView.swift */,
				AA000000000000000000000C /* HomeView.swift */,
				AA000000000000000000000D /* SettingsView.swift */,
				AA000000000000000000000E /* TransactionView.swift */,
			);
			path = Views;
			sourceTree = "<group>";
		};
		AA0000060000000000000008 /* Utilities */ = {
			isa = PBXGroup;
			children = (
				AA000000000000000000000F /* Constants.swift */,
				AA0000000000000000000010 /* CryptoUtilities.swift */,
				AA0000000000000000000011 /* Extensions.swift */,
			);
			path = Utilities;
			sourceTree = "<group>";
		};
		AA0000060000000000000009 /* Resources */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000000000012 /* Assets.xcassets */,
				AA0000000000000000000013 /* Info.plist */,
			);
			path = Resources;
			sourceTree = "<group>";
		};
		AA0000060000000000000020 /* AxiomHiveAppTests */ = {
			isa = PBXGroup;
			children = (
				AA0000000000000000000020 /* IntegrationTests.swift */,
				AA0000000000000000000021 /* ServiceTests.swift */,
				AA0000000000000000000022 /* ViewModelTests.swift */,
			);
			path = AxiomHiveAppTests;
			sourceTree = "<group>";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		AA0000020000000000000001 /* AxiomHiveApp */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = AA0000070000000000000001 /* Build configuration list for PBXNativeTarget "AxiomHiveApp" */;
			buildPhases = (
				AA0000080000000000000001 /* Sources */,
				AA0000040000000000000001 /* Frameworks */,
				AA0000090000000000000001 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = AxiomHiveApp;
			productName = AxiomHiveApp;
			productReference = AA0000020000000000000002 /* AxiomHiveApp.app */;
			productType = "com.apple.product-type.application";
		};
		AA0000020000000000000020 /* AxiomHiveAppTests */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = AA0000070000000000000020 /* Build configuration list for PBXNativeTarget "AxiomHiveAppTests" */;
			buildPhases = (
				AA0000080000000000000020 /* Sources */,
				AA0000040000000000000002 /* Frameworks */,
				AA0000090000000000000020 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
				AA0000030000000000000002 /* PBXTargetDependency */,
			);
			name = AxiomHiveAppTests;
			productName = AxiomHiveAppTests;
			productReference = AA0000020000000000000020 /* AxiomHiveAppTests.xctest */;
			productType = "com.apple.product-type.bundle.unit-test";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		AA0000050000000000000001 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1520;
				LastUpgradeCheck = 1520;
				TargetAttributes = {
					AA0000020000000000000001 = {
						CreatedOnToolsVersion = 15.2;
					};
					AA0000020000000000000020 = {
						CreatedOnToolsVersion = 15.2;
						TestTargetID = AA0000020000000000000001;
					};
				};
			};
			buildConfigurationList = AA0000070000000000000002 /* Build configuration list for PBXProject "AxiomHiveApp" */;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = AA0000060000000000000001;
			productRefGroup = AA0000060000000000000003 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				AA0000020000000000000001 /* AxiomHiveApp */,
				AA0000020000000000000020 /* AxiomHiveAppTests */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		AA0000090000000000000001 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				AA0000010000000000000012 /* Assets.xcassets in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		AA0000090000000000000020 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		AA0000080000000000000001 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				AA0000010000000000000001 /* AxiomHiveAppApp.swift in Sources */,
				AA0000010000000000000002 /* User.swift in Sources */,
				AA0000010000000000000003 /* Transaction.swift in Sources */,
				AA0000010000000000000004 /* AxiomResponse.swift in Sources */,
				AA0000010000000000000005 /* NetworkService.swift in Sources */,
				AA0000010000000000000006 /* AxiomHiveService.swift in Sources */,
				AA0000010000000000000007 /* AuthenticationService.swift in Sources */,
				AA0000010000000000000008 /* AppState.swift in Sources */,
				AA0000010000000000000009 /* HomeViewModel.swift in Sources */,
				AA000001000000000000000A /* TransactionViewModel.swift in Sources */,
				AA000001000000000000000B /* ContentView.swift in Sources */,
				AA000001000000000000000C /* HomeView.swift in Sources */,
				AA000001000000000000000D /* SettingsView.swift in Sources */,
				AA000001000000000000000E /* TransactionView.swift in Sources */,
				AA000001000000000000000F /* Constants.swift in Sources */,
				AA0000010000000000000010 /* CryptoUtilities.swift in Sources */,
				AA0000010000000000000011 /* Extensions.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
		AA0000080000000000000020 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				AA0000010000000000000020 /* IntegrationTests.swift in Sources */,
				AA0000010000000000000021 /* ServiceTests.swift in Sources */,
				AA0000010000000000000022 /* ViewModelTests.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
		AA0000030000000000000002 /* PBXTargetDependency */ = {
			isa = PBXTargetDependency;
			target = AA0000020000000000000001 /* AxiomHiveApp */;
			targetProxy = AA0000030000000000000001 /* PBXContainerItemProxy */;
		};
/* End PBXTargetDependency section */

/* Begin XCBuildConfiguration section */
		AA00000A0000000000000001 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = "DEBUG $(inherited)";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				SWIFT_VERSION = 5.9;
			};
			name = Debug;
		};
		AA00000A0000000000000002 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SDKROOT = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_VERSION = 5.9;
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		AA00000A0000000000000003 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_ASSET_PATHS = "";
				DEVELOPMENT_TEAM = "";
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = AxiomHiveApp/Resources/Info.plist;
				INFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
				INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
				INFOPLIST_KEY_UILaunchScreen_Generation = YES;
				INFOPLIST_KEY_UISupportedInterfaceOrientations = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				MARKETING_VERSION = 1.0.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.axiomhive.AxiomHiveApp;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.9;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		AA00000A0000000000000004 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_ASSET_PATHS = "";
				DEVELOPMENT_TEAM = "";
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = AxiomHiveApp/Resources/Info.plist;
				INFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
				INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
				INFOPLIST_KEY_UILaunchScreen_Generation = YES;
				INFOPLIST_KEY_UISupportedInterfaceOrientations = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				MARKETING_VERSION = 1.0.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.axiomhive.AxiomHiveApp;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.9;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
		AA00000A0000000000000020 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
				BUNDLE_LOADER = "$(TEST_HOST)";
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_TEAM = "";
				GENERATE_INFOPLIST_FILE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.axiomhive.AxiomHiveAppTests;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = NO;
				SWIFT_VERSION = 5.9;
				TARGETED_DEVICE_FAMILY = "1,2";
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/AxiomHiveApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/AxiomHiveApp";
			};
			name = Debug;
		};
		AA00000A0000000000000021 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
				BUNDLE_LOADER = "$(TEST_HOST)";
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_TEAM = "";
				GENERATE_INFOPLIST_FILE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.axiomhive.AxiomHiveAppTests;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = NO;
				SWIFT_VERSION = 5.9;
				TARGETED_DEVICE_FAMILY = "1,2";
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/AxiomHiveApp.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/AxiomHiveApp";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		AA0000070000000000000002 /* Build configuration list for PBXProject "AxiomHiveApp" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AA00000A0000000000000001 /* Debug */,
				AA00000A0000000000000002 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		AA0000070000000000000001 /* Build configuration list for PBXNativeTarget "AxiomHiveApp" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AA00000A0000000000000003 /* Debug */,
				AA00000A0000000000000004 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		AA0000070000000000000020 /* Build configuration list for PBXNativeTarget "AxiomHiveAppTests" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AA00000A0000000000000020 /* Debug */,
				AA00000A0000000000000021 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = AA0000050000000000000001 /* Project object */;
}
EOF

# Create workspace contents
cat > AxiomHiveApp.xcodeproj/project.xcworkspace/contents.xcworkspacedata << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Workspace
   version = "1.0">
   <FileRef
      location = "self:">
   </FileRef>
</Workspace>
EOF

# Create scheme
cat > AxiomHiveApp.xcodeproj/xcshareddata/xcschemes/AxiomHiveApp.xcscheme << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "1520"
   version = "1.7">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "AA0000020000000000000001"
               BuildableName = "AxiomHiveApp.app"
               BlueprintName = "AxiomHiveApp"
               ReferencedContainer = "container:AxiomHiveApp.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      shouldUseLaunchSchemeArgsEnv = "YES"
      shouldAutocreateTestPlan = "YES">
      <Testables>
         <TestableReference
            skipped = "NO"
            parallelizable = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "AA0000020000000000000020"
               BuildableName = "AxiomHiveAppTests.xctest"
               BlueprintName = "AxiomHiveAppTests"
               ReferencedContainer = "container:AxiomHiveApp.xcodeproj">
            </BuildableReference>
         </TestableReference>
      </Testables>
   </TestAction>
   <LaunchAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtension = "internal"
      allowLocationSimulation = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "AA0000020000000000000001"
            BuildableName = "AxiomHiveApp.app"
            BlueprintName = "AxiomHiveApp"
            ReferencedContainer = "container:AxiomHiveApp.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction
      buildConfiguration = "Release"
      shouldUseLaunchSchemeArgsEnv = "YES"
      savedToolIdentifier = ""
      useCustomWorkingDirectory = "NO"
      debugDocumentVersioning = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "AA0000020000000000000001"
            BuildableName = "AxiomHiveApp.app"
            BlueprintName = "AxiomHiveApp"
            ReferencedContainer = "container:AxiomHiveApp.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction
      buildConfiguration = "Debug">
   </AnalyzeAction>
   <ArchiveAction
      buildConfiguration = "Release"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
EOF

echo "✅ Xcode project structure created successfully!"
echo ""
echo "Created files:"
echo "  - AxiomHiveApp.xcodeproj/project.pbxproj"
echo "  - AxiomHiveApp.xcodeproj/project.xcworkspace/contents.xcworkspacedata"
echo "  - AxiomHiveApp.xcodeproj/xcshareddata/xcschemes/AxiomHiveApp.xcscheme"
echo ""
echo "The project is now ready to open in Xcode 15.2+"
