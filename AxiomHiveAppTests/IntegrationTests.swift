//
//  IntegrationTests.swift
//  AxiomHiveAppTests
//
//  Integration tests for end-to-end functionality
//

import XCTest
@testable import AxiomHiveApp

final class IntegrationTests: XCTestCase {
    
    func testStringExtensionValidEmail() {
        XCTAssertTrue("test@example.com".isValidEmail)
        XCTAssertTrue("user.name+tag@example.co.uk".isValidEmail)
        XCTAssertFalse("invalid-email".isValidEmail)
        XCTAssertFalse("@example.com".isValidEmail)
        XCTAssertFalse("test@.com".isValidEmail)
    }
    
    func testStringExtensionValidPassword() {
        XCTAssertTrue("Password123!".isValidPassword)
        XCTAssertFalse("short".isValidPassword) // Too short
        XCTAssertFalse("NoNumbers!".isValidPassword) // No numbers
        XCTAssertFalse("NoSpecial123".isValidPassword) // No special chars
    }
    
    func testDateExtensionTimeAgo() {
        let now = Date()
        XCTAssertEqual(now.timeAgo(), "Just now")
        
        let oneHourAgo = now.addingTimeInterval(-3600)
        XCTAssertTrue(oneHourAgo.timeAgo().contains("hour"))
        
        let oneDayAgo = now.addingTimeInterval(-86400)
        XCTAssertTrue(oneDayAgo.timeAgo().contains("day"))
    }
    
    func testTimeIntervalFormatting() {
        let milliseconds: TimeInterval = 0.5
        XCTAssertTrue(milliseconds.formatted().contains("ms"))
        
        let seconds: TimeInterval = 5.5
        XCTAssertTrue(seconds.formatted().contains("s"))
        
        let minutes: TimeInterval = 125
        XCTAssertTrue(minutes.formatted().contains("m"))
        
        let hours: TimeInterval = 7200
        XCTAssertTrue(hours.formatted().contains("h"))
    }
    
    func testDoubleFormatAsPercentage() {
        let value: Double = 85.5
        let formatted = value.formatAsPercentage()
        XCTAssertTrue(formatted.contains("85.5"))
        XCTAssertTrue(formatted.contains("%"))
    }
    
    func testStringTruncation() {
        let longString = "This is a very long string that needs to be truncated"
        let truncated = longString.truncated(to: 10)
        
        XCTAssertEqual(truncated.count, 13) // 10 + "..."
        XCTAssertTrue(truncated.hasSuffix("..."))
    }
    
    func testAnyCodableWithDifferentTypes() throws {
        let stringValue = AnyCodable("test")
        let intValue = AnyCodable(42)
        let boolValue = AnyCodable(true)
        let doubleValue = AnyCodable(3.14)
        
        let values = [
            "string": stringValue,
            "int": intValue,
            "bool": boolValue,
            "double": doubleValue
        ]
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(values)
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode([String: AnyCodable].self, from: data)
        
        XCTAssertEqual(decoded.count, 4)
    }
    
    func testTransactionTypeAllCases() {
        let types = TransactionType.allCases
        XCTAssertEqual(types.count, 5)
        XCTAssertTrue(types.contains(.aiQuery))
        XCTAssertTrue(types.contains(.dataAnalysis))
        XCTAssertTrue(types.contains(.prediction))
        XCTAssertTrue(types.contains(.optimization))
        XCTAssertTrue(types.contains(.verification))
    }
    
    func testAppThemeAllCases() {
        let themes = AppTheme.allCases
        XCTAssertEqual(themes.count, 3)
        XCTAssertTrue(themes.contains(.light))
        XCTAssertTrue(themes.contains(.dark))
        XCTAssertTrue(themes.contains(.system))
    }
    
    func testConstantsValues() {
        XCTAssertEqual(Constants.API.baseURL, "https://api.axiomhive.com/v1")
        XCTAssertEqual(Constants.API.version, "1.0.0")
        XCTAssertEqual(Constants.App.name, "AxiomHive")
        XCTAssertEqual(Constants.Security.minPasswordLength, 8)
        XCTAssertTrue(Constants.Security.requireSpecialCharacters)
        XCTAssertTrue(Constants.Security.requireNumbers)
    }
    
    func testTimestampValidation() {
        let validTimestamp = Date()
        XCTAssertTrue(CryptoUtilities.isTimestampValid(validTimestamp))
        
        let oldTimestamp = Date().addingTimeInterval(-400) // 400 seconds ago
        XCTAssertFalse(CryptoUtilities.isTimestampValid(oldTimestamp))
        
        let futureTimestamp = Date().addingTimeInterval(400) // 400 seconds in future
        XCTAssertFalse(CryptoUtilities.isTimestampValid(futureTimestamp))
    }
    
    func testUserPreferencesDefaults() {
        let prefs = UserPreferences()
        XCTAssertTrue(prefs.enableNotifications)
        XCTAssertFalse(prefs.enableBiometrics)
        XCTAssertEqual(prefs.theme, .system)
        XCTAssertEqual(prefs.language, "en")
    }
    
    func testTransactionRequestNonceUniqueness() {
        let request1 = TransactionRequest(operation: "test", parameters: [:])
        let request2 = TransactionRequest(operation: "test", parameters: [:])
        
        XCTAssertNotEqual(request1.nonce, request2.nonce)
    }
}
