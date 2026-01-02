//
//  CryptoUtilities.swift
//  AxiomHiveApp
//
//  Cryptographic utilities for secure operations
//

import Foundation
import CryptoKit

struct CryptoUtilities {
    // MARK: - Hashing
    static func sha256Hash(of data: Data) -> String {
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    static func sha256Hash(of string: String) -> String {
        guard let data = string.data(using: .utf8) else { return "" }
        return sha256Hash(of: data)
    }
    
    // MARK: - HMAC Signing
    static func hmacSignature(for data: Data, key: String) -> String {
        let symmetricKey = SymmetricKey(data: Data(key.utf8))
        let signature = HMAC<SHA256>.authenticationCode(for: data, using: symmetricKey)
        return Data(signature).base64EncodedString()
    }
    
    static func hmacSignature(for string: String, key: String) -> String {
        guard let data = string.data(using: .utf8) else { return "" }
        return hmacSignature(for: data, key: key)
    }
    
    // MARK: - Verification
    static func verifyHMACSignature(
        signature: String,
        for data: Data,
        key: String
    ) -> Bool {
        let computedSignature = hmacSignature(for: data, key: key)
        return signature == computedSignature
    }
    
    // MARK: - Random Generation
    static func generateNonce(length: Int = 32) -> String {
        let bytes = (0..<length).map { _ in UInt8.random(in: 0...255) }
        return Data(bytes).base64EncodedString()
    }
    
    static func generateSecureToken() -> String {
        return UUID().uuidString + "-" + generateNonce(length: 16)
    }
    
    // MARK: - Key Derivation
    static func deriveKey(from password: String, salt: String) -> SymmetricKey {
        let saltData = Data(salt.utf8)
        let passwordData = Data(password.utf8)
        
        // Use SHA256 to derive a key (in production, use PBKDF2 or similar)
        let hash = SHA256.hash(data: passwordData + saltData)
        return SymmetricKey(data: hash)
    }
    
    // MARK: - Encryption/Decryption
    static func encrypt(data: Data, key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.seal(data, using: key)
        guard let combined = sealedBox.combined else {
            throw CryptoError.encryptionFailed
        }
        return combined
    }
    
    static func decrypt(data: Data, key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }
    
    static func encrypt(string: String, key: SymmetricKey) throws -> String {
        guard let data = string.data(using: .utf8) else {
            throw CryptoError.invalidData
        }
        let encrypted = try encrypt(data: data, key: key)
        return encrypted.base64EncodedString()
    }
    
    static func decrypt(string: String, key: SymmetricKey) throws -> String {
        guard let data = Data(base64Encoded: string) else {
            throw CryptoError.invalidData
        }
        let decrypted = try decrypt(data: data, key: key)
        guard let result = String(data: decrypted, encoding: .utf8) else {
            throw CryptoError.decodingFailed
        }
        return result
    }
    
    // MARK: - Timestamp Verification
    static func isTimestampValid(
        _ timestamp: Date,
        tolerance: TimeInterval = 300
    ) -> Bool {
        let now = Date()
        let age = abs(now.timeIntervalSince(timestamp))
        return age <= tolerance
    }
}

enum CryptoError: Error, LocalizedError {
    case encryptionFailed
    case decryptionFailed
    case invalidData
    case decodingFailed
    case keyGenerationFailed
    
    var errorDescription: String? {
        switch self {
        case .encryptionFailed:
            return "Failed to encrypt data"
        case .decryptionFailed:
            return "Failed to decrypt data"
        case .invalidData:
            return "Invalid data format"
        case .decodingFailed:
            return "Failed to decode data"
        case .keyGenerationFailed:
            return "Failed to generate cryptographic key"
        }
    }
}
