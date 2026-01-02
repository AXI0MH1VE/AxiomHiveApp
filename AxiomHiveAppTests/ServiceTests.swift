//
//  ServiceTests.swift
//  AxiomHiveAppTests
//
//  Tests for Services
//

import XCTest
@testable import AxiomHiveApp

final class ServiceTests: XCTestCase {
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func testNetworkServiceInitialization() {
        XCTAssertNotNil(networkService)
    }
    
    func testCryptoUtilitiesSHA256Hash() {
        let input = "test string"
        let hash = CryptoUtilities.sha256Hash(of: input)
        
        XCTAssertFalse(hash.isEmpty)
        XCTAssertEqual(hash.count, 64) // SHA256 produces 64 hex characters
    }
    
    func testCryptoUtilitiesHMACSignature() {
        let data = "test data"
        let key = "test-key"
        let signature = CryptoUtilities.hmacSignature(for: data, key: key)
        
        XCTAssertFalse(signature.isEmpty)
    }
    
    func testCryptoUtilitiesVerifyHMACSignature() {
        let data = "test data"
        let key = "test-key"
        let signature = CryptoUtilities.hmacSignature(for: data, key: key)
        
        let isValid = CryptoUtilities.verifyHMACSignature(
            signature: signature,
            for: Data(data.utf8),
            key: key
        )
        
        XCTAssertTrue(isValid)
    }
    
    func testCryptoUtilitiesGenerateNonce() {
        let nonce1 = CryptoUtilities.generateNonce()
        let nonce2 = CryptoUtilities.generateNonce()
        
        XCTAssertFalse(nonce1.isEmpty)
        XCTAssertFalse(nonce2.isEmpty)
        XCTAssertNotEqual(nonce1, nonce2)
    }
    
    func testCryptoUtilitiesEncryptDecrypt() throws {
        let originalText = "Secret message"
        let key = CryptoUtilities.deriveKey(from: "password", salt: "salt")
        
        let encrypted = try CryptoUtilities.encrypt(string: originalText, key: key)
        XCTAssertNotEqual(encrypted, originalText)
        
        let decrypted = try CryptoUtilities.decrypt(string: encrypted, key: key)
        XCTAssertEqual(decrypted, originalText)
    }
    
    func testUserModelCodable() throws {
        let user = User(
            username: "testuser",
            email: "test@example.com",
            fullName: "Test User",
            apiKey: "test-api-key"
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(user)
        
        let decoder = JSONDecoder()
        let decodedUser = try decoder.decode(User.self, from: data)
        
        XCTAssertEqual(user.id, decodedUser.id)
        XCTAssertEqual(user.username, decodedUser.username)
        XCTAssertEqual(user.email, decodedUser.email)
    }
    
    func testTransactionModelCodable() throws {
        let transaction = Transaction(
            userId: UUID(),
            type: .aiQuery,
            request: TransactionRequest(
                operation: "test_operation",
                parameters: ["key": AnyCodable("value")]
            )
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(transaction)
        
        let decoder = JSONDecoder()
        let decodedTransaction = try decoder.decode(Transaction.self, from: data)
        
        XCTAssertEqual(transaction.id, decodedTransaction.id)
        XCTAssertEqual(transaction.type, decodedTransaction.type)
        XCTAssertEqual(transaction.status, decodedTransaction.status)
    }
    
    func testAxiomResponseProofValidation() {
        let validProof = DeterministicProof(
            algorithm: "HMAC-SHA256",
            signature: "valid-signature-string",
            hash: "valid-hash-string",
            timestamp: Date(),
            nonce: "test-nonce"
        )
        
        XCTAssertTrue(validProof.isValid)
        
        let invalidProof = DeterministicProof(
            algorithm: "INVALID",
            signature: "",
            hash: "",
            timestamp: Date(),
            nonce: "test-nonce"
        )
        
        XCTAssertFalse(invalidProof.isValid)
    }
    
    func testUserStatisticsCalculation() {
        var statistics = UserStatistics(
            totalTransactions: 100,
            successfulTransactions: 85,
            failedTransactions: 15
        )
        
        XCTAssertEqual(statistics.successRate, 85.0)
        
        statistics.totalTransactions = 0
        XCTAssertEqual(statistics.successRate, 0.0)
    }
    
    func testTransactionDurationCalculation() {
        var transaction = Transaction(
            userId: UUID(),
            type: .aiQuery,
            request: TransactionRequest(
                operation: "test",
                parameters: [:]
            )
        )
        
        XCTAssertNil(transaction.duration)
        
        transaction.completedAt = Date().addingTimeInterval(5)
        XCTAssertNotNil(transaction.duration)
        XCTAssertGreaterThan(transaction.duration!, 0)
    }
}
