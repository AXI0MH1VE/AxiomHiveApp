//
//  AxiomHiveService.swift
//  AxiomHiveApp
//
//  Service for Axiom Hive API integration with cryptographic verification
//

import Foundation
import CryptoKit

class AxiomHiveService {
    private let baseURL: String
    private let apiKey: String
    private let networkService: NetworkService
    
    init(
        baseURL: String = Constants.API.baseURL,
        apiKey: String,
        networkService: NetworkService = NetworkService()
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.networkService = networkService
    }
    
    func executeTransaction(_ request: TransactionRequest) async throws -> AxiomResponse {
        let endpoint = "\(baseURL)/execute"
        
        guard let url = URL(string: endpoint) else {
            throw AxiomError.invalidRequest("Invalid URL")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Sign the request
        let signature = try signRequest(request)
        urlRequest.setValue(signature, forHTTPHeaderField: "X-Axiom-Signature")
        
        // Encode request body
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        urlRequest.httpBody = try encoder.encode(request)
        
        // Execute request
        let (data, response) = try await networkService.execute(urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AxiomError.invalidResponse
        }
        
        // Check status code
        switch httpResponse.statusCode {
        case 200...299:
            break
        case 401:
            throw AxiomError.authenticationFailed
        case 429:
            throw AxiomError.rateLimitExceeded
        case 400...499:
            throw AxiomError.invalidRequest("Client error: \(httpResponse.statusCode)")
        case 500...599:
            throw AxiomError.serverError(httpResponse.statusCode, "Server error")
        default:
            throw AxiomError.invalidResponse
        }
        
        // Decode response
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let axiomResponse = try decoder.decode(AxiomResponse.self, from: data)
            
            // Verify cryptographic proof
            try verifyProof(axiomResponse, originalRequest: request)
            
            return axiomResponse
        } catch let error as DecodingError {
            throw AxiomError.decodingError(error)
        }
    }
    
    func queryStatus(requestId: String) async throws -> AxiomResponse {
        let endpoint = "\(baseURL)/status/\(requestId)"
        
        guard let url = URL(string: endpoint) else {
            throw AxiomError.invalidRequest("Invalid URL")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await networkService.execute(urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw AxiomError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(AxiomResponse.self, from: data)
    }
    
    private func signRequest(_ request: TransactionRequest) throws -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(request)
        
        let key = SymmetricKey(data: Data(apiKey.utf8))
        let signature = HMAC<SHA256>.authenticationCode(for: data, using: key)
        
        return Data(signature).base64EncodedString()
    }
    
    private func verifyProof(
        _ response: AxiomResponse,
        originalRequest: TransactionRequest
    ) throws {
        // Verify proof is valid
        guard response.proof.isValid else {
            throw AxiomError.invalidProof
        }
        
        // Verify algorithm
        guard response.proof.algorithm == "HMAC-SHA256" else {
            throw AxiomError.invalidProof
        }
        
        // Verify signature is not empty
        guard !response.proof.signature.isEmpty,
              !response.proof.hash.isEmpty else {
            throw AxiomError.invalidProof
        }
        
        // Verify nonces match
        guard response.proof.nonce == originalRequest.nonce else {
            throw AxiomError.invalidProof
        }
    }
}
