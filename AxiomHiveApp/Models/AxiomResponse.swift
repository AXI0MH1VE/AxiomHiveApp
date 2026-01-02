//
//  AxiomResponse.swift
//  AxiomHiveApp
//
//  Response models from Axiom Hive API
//

import Foundation

struct AxiomResponse: Codable, Equatable {
    let requestId: String
    let timestamp: Date
    let result: AxiomResult
    let proof: DeterministicProof
    let metadata: ResponseMetadata
    
    init(
        requestId: String,
        timestamp: Date = Date(),
        result: AxiomResult,
        proof: DeterministicProof,
        metadata: ResponseMetadata
    ) {
        self.requestId = requestId
        self.timestamp = timestamp
        self.result = result
        self.proof = proof
        self.metadata = metadata
    }
}

struct AxiomResult: Codable, Equatable {
    let status: String
    let data: [String: AnyCodable]
    let confidence: Double
    let reasoning: String?
    
    init(
        status: String,
        data: [String: AnyCodable],
        confidence: Double,
        reasoning: String? = nil
    ) {
        self.status = status
        self.data = data
        self.confidence = confidence
        self.reasoning = reasoning
    }
}

struct DeterministicProof: Codable, Equatable {
    let algorithm: String
    let signature: String
    let hash: String
    let timestamp: Date
    let nonce: String
    
    init(
        algorithm: String,
        signature: String,
        hash: String,
        timestamp: Date = Date(),
        nonce: String
    ) {
        self.algorithm = algorithm
        self.signature = signature
        self.hash = hash
        self.timestamp = timestamp
        self.nonce = nonce
    }
    
    var isValid: Bool {
        // Verify the proof components
        guard !signature.isEmpty,
              !hash.isEmpty,
              algorithm == "HMAC-SHA256" else {
            return false
        }
        
        // Verify timestamp is not too old (within 5 minutes)
        let age = Date().timeIntervalSince(timestamp)
        guard age < 300 else { return false }
        
        // Basic validation passed
        return true
    }
}

struct ResponseMetadata: Codable, Equatable {
    let executionTime: TimeInterval
    let apiVersion: String
    let nodeId: String
    let region: String
    let rateLimitRemaining: Int
    let rateLimitReset: Date
    
    init(
        executionTime: TimeInterval,
        apiVersion: String,
        nodeId: String,
        region: String,
        rateLimitRemaining: Int,
        rateLimitReset: Date
    ) {
        self.executionTime = executionTime
        self.apiVersion = apiVersion
        self.nodeId = nodeId
        self.region = region
        self.rateLimitRemaining = rateLimitRemaining
        self.rateLimitReset = rateLimitReset
    }
}

enum AxiomError: Error, LocalizedError {
    case invalidResponse
    case invalidProof
    case networkError(Error)
    case authenticationFailed
    case rateLimitExceeded
    case invalidRequest(String)
    case serverError(Int, String)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from Axiom Hive API"
        case .invalidProof:
            return "Cryptographic proof verification failed"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .authenticationFailed:
            return "Authentication failed. Please check your API key"
        case .rateLimitExceeded:
            return "Rate limit exceeded. Please try again later"
        case .invalidRequest(let message):
            return "Invalid request: \(message)"
        case .serverError(let code, let message):
            return "Server error (\(code)): \(message)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}
