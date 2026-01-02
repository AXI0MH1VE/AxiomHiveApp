//
//  AuthenticationService.swift
//  AxiomHiveApp
//
//  Service for user authentication and session management
//

import Foundation
import Security

class AuthenticationService {
    private let keychainService = "com.axiomhive.app"
    private let networkService: NetworkService
    private let baseURL: String
    
    init(
        baseURL: String = Constants.API.baseURL,
        networkService: NetworkService = NetworkService()
    ) {
        self.baseURL = baseURL
        self.networkService = networkService
    }
    
    func signIn(email: String, password: String) async throws -> User {
        let endpoint = "\(baseURL)/auth/signin"
        
        guard let url = URL(string: endpoint) else {
            throw AxiomError.invalidRequest("Invalid URL")
        }
        
        let credentials = SignInRequest(email: email, password: password)
        let data = try await networkService.post(url: url, body: credentials)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(AuthResponse.self, from: data)
        
        // Store API key in keychain
        try saveAPIKey(response.apiKey, for: response.user.id.uuidString)
        
        // Store user data
        try saveUserData(response.user)
        
        return response.user
    }
    
    func signUp(
        username: String,
        email: String,
        password: String,
        fullName: String
    ) async throws -> User {
        let endpoint = "\(baseURL)/auth/signup"
        
        guard let url = URL(string: endpoint) else {
            throw AxiomError.invalidRequest("Invalid URL")
        }
        
        let credentials = SignUpRequest(
            username: username,
            email: email,
            password: password,
            fullName: fullName
        )
        let data = try await networkService.post(url: url, body: credentials)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try decoder.decode(AuthResponse.self, from: data)
        
        // Store API key in keychain
        try saveAPIKey(response.apiKey, for: response.user.id.uuidString)
        
        // Store user data
        try saveUserData(response.user)
        
        return response.user
    }
    
    func signOut() throws {
        // Clear stored credentials
        try deleteAPIKey()
        try deleteUserData()
    }
    
    func getCurrentUser() async throws -> User? {
        guard let userData = try? loadUserData() else {
            return nil
        }
        
        return userData
    }
    
    func getAPIKey() throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let apiKey = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return apiKey
    }
    
    private func saveAPIKey(_ apiKey: String, for userId: String) throws {
        guard let data = apiKey.data(using: .utf8) else {
            throw AxiomError.invalidRequest("Invalid API key format")
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: userId,
            kSecValueData as String: data
        ]
        
        // Delete existing item first
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            throw AxiomError.authenticationFailed
        }
    }
    
    private func deleteAPIKey() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService
        ]
        
        SecItemDelete(query as CFDictionary)
    }
    
    private func saveUserData(_ user: User) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(user)
        UserDefaults.standard.set(data, forKey: "currentUser")
    }
    
    private func loadUserData() throws -> User? {
        guard let data = UserDefaults.standard.data(forKey: "currentUser") else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(User.self, from: data)
    }
    
    private func deleteUserData() throws {
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
}

struct SignInRequest: Codable {
    let email: String
    let password: String
}

struct SignUpRequest: Codable {
    let username: String
    let email: String
    let password: String
    let fullName: String
}

struct AuthResponse: Codable {
    let user: User
    let apiKey: String
    let expiresAt: Date
}
