//
//  Constants.swift
//  AxiomHiveApp
//
//  Application-wide constants
//

import Foundation
import SwiftUI

struct Constants {
    struct API {
        static let baseURL = "https://api.axiomhive.com/v1"
        static let timeout: TimeInterval = 30
        static let version = "1.0.0"
    }
    
    struct App {
        static let name = "AxiomHive"
        static let bundleIdentifier = "com.axiomhive.app"
        static let version = "1.0.0"
        static let buildNumber = "1"
    }
    
    struct UI {
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 16
        static let smallPadding: CGFloat = 8
        static let largePadding: CGFloat = 24
        static let iconSize: CGFloat = 24
        static let largeIconSize: CGFloat = 48
        static let animationDuration: TimeInterval = 0.3
    }
    
    struct Colors {
        static let primary = Color(red: 0.2, green: 0.4, blue: 0.8)
        static let secondary = Color(red: 0.5, green: 0.5, blue: 0.5)
        static let success = Color(red: 0.2, green: 0.7, blue: 0.3)
        static let error = Color(red: 0.8, green: 0.2, blue: 0.2)
        static let warning = Color(red: 0.9, green: 0.6, blue: 0.2)
        static let background = Color(.systemBackground)
        static let secondaryBackground = Color(.secondarySystemBackground)
    }
    
    struct Limits {
        static let maxTransactionHistorySize = 100
        static let maxRetryAttempts = 3
        static let cacheExpiration: TimeInterval = 3600
    }
    
    struct Security {
        static let minPasswordLength = 8
        static let requireSpecialCharacters = true
        static let requireNumbers = true
        static let sessionTimeout: TimeInterval = 1800
    }
}
