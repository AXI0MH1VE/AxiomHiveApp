//
//  User.swift
//  AxiomHiveApp
//
//  User model with authentication and profile data
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: UUID
    var username: String
    var email: String
    var fullName: String
    var profileImageURL: URL?
    var apiKey: String
    var createdAt: Date
    var lastLoginAt: Date?
    var preferences: UserPreferences
    var statistics: UserStatistics
    
    init(
        id: UUID = UUID(),
        username: String,
        email: String,
        fullName: String,
        profileImageURL: URL? = nil,
        apiKey: String,
        createdAt: Date = Date(),
        lastLoginAt: Date? = nil,
        preferences: UserPreferences = UserPreferences(),
        statistics: UserStatistics = UserStatistics()
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.fullName = fullName
        self.profileImageURL = profileImageURL
        self.apiKey = apiKey
        self.createdAt = createdAt
        self.lastLoginAt = lastLoginAt
        self.preferences = preferences
        self.statistics = statistics
    }
}

struct UserPreferences: Codable, Equatable {
    var enableNotifications: Bool
    var enableBiometrics: Bool
    var theme: AppTheme
    var language: String
    
    init(
        enableNotifications: Bool = true,
        enableBiometrics: Bool = false,
        theme: AppTheme = .system,
        language: String = "en"
    ) {
        self.enableNotifications = enableNotifications
        self.enableBiometrics = enableBiometrics
        self.theme = theme
        self.language = language
    }
}

enum AppTheme: String, Codable, CaseIterable {
    case light
    case dark
    case system
}

struct UserStatistics: Codable, Equatable {
    var totalTransactions: Int
    var successfulTransactions: Int
    var failedTransactions: Int
    var totalApiCalls: Int
    var averageResponseTime: TimeInterval
    
    init(
        totalTransactions: Int = 0,
        successfulTransactions: Int = 0,
        failedTransactions: Int = 0,
        totalApiCalls: Int = 0,
        averageResponseTime: TimeInterval = 0
    ) {
        self.totalTransactions = totalTransactions
        self.successfulTransactions = successfulTransactions
        self.failedTransactions = failedTransactions
        self.totalApiCalls = totalApiCalls
        self.averageResponseTime = averageResponseTime
    }
    
    var successRate: Double {
        guard totalTransactions > 0 else { return 0 }
        return Double(successfulTransactions) / Double(totalTransactions) * 100
    }
}
