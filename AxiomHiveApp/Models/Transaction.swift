//
//  Transaction.swift
//  AxiomHiveApp
//
//  Transaction models for Axiom Hive operations
//

import Foundation

struct Transaction: Identifiable, Codable, Equatable {
    let id: UUID
    let userId: UUID
    let type: TransactionType
    var status: TransactionStatus
    let request: TransactionRequest
    var response: AxiomResponse?
    let createdAt: Date
    var completedAt: Date?
    var error: TransactionError?
    
    init(
        id: UUID = UUID(),
        userId: UUID,
        type: TransactionType,
        status: TransactionStatus = .pending,
        request: TransactionRequest,
        response: AxiomResponse? = nil,
        createdAt: Date = Date(),
        completedAt: Date? = nil,
        error: TransactionError? = nil
    ) {
        self.id = id
        self.userId = userId
        self.type = type
        self.status = status
        self.request = request
        self.response = response
        self.createdAt = createdAt
        self.completedAt = completedAt
        self.error = error
    }
    
    var duration: TimeInterval? {
        guard let completedAt = completedAt else { return nil }
        return completedAt.timeIntervalSince(createdAt)
    }
}

enum TransactionType: String, Codable, CaseIterable {
    case aiQuery = "ai_query"
    case dataAnalysis = "data_analysis"
    case prediction = "prediction"
    case optimization = "optimization"
    case verification = "verification"
}

enum TransactionStatus: String, Codable {
    case pending
    case processing
    case completed
    case failed
    case cancelled
}

struct TransactionRequest: Codable, Equatable {
    let operation: String
    let parameters: [String: AnyCodable]
    let timestamp: Date
    let nonce: String
    
    init(
        operation: String,
        parameters: [String: AnyCodable],
        timestamp: Date = Date(),
        nonce: String = UUID().uuidString
    ) {
        self.operation = operation
        self.parameters = parameters
        self.timestamp = timestamp
        self.nonce = nonce
    }
}

struct TransactionError: Codable, Equatable {
    let code: String
    let message: String
    let details: [String: AnyCodable]?
    
    init(code: String, message: String, details: [String: AnyCodable]? = nil) {
        self.code = code
        self.message = message
        self.details = details
    }
}

// Type-erased wrapper for Codable values
struct AnyCodable: Codable, Equatable {
    let value: Any
    
    init(_ value: Any) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let bool = try? container.decode(Bool.self) {
            value = bool
        } else if let int = try? container.decode(Int.self) {
            value = int
        } else if let double = try? container.decode(Double.self) {
            value = double
        } else if let string = try? container.decode(String.self) {
            value = string
        } else if let array = try? container.decode([AnyCodable].self) {
            value = array.map { $0.value }
        } else if let dictionary = try? container.decode([String: AnyCodable].self) {
            value = dictionary.mapValues { $0.value }
        } else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unsupported type"
            )
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch value {
        case let bool as Bool:
            try container.encode(bool)
        case let int as Int:
            try container.encode(int)
        case let double as Double:
            try container.encode(double)
        case let string as String:
            try container.encode(string)
        case let array as [Any]:
            try container.encode(array.map { AnyCodable($0) })
        case let dictionary as [String: Any]:
            try container.encode(dictionary.mapValues { AnyCodable($0) })
        default:
            throw EncodingError.invalidValue(
                value,
                EncodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unsupported type"
                )
            )
        }
    }
    
    static func == (lhs: AnyCodable, rhs: AnyCodable) -> Bool {
        switch (lhs.value, rhs.value) {
        case let (l as Bool, r as Bool):
            return l == r
        case let (l as Int, r as Int):
            return l == r
        case let (l as Double, r as Double):
            return l == r
        case let (l as String, r as String):
            return l == r
        default:
            return false
        }
    }
}
