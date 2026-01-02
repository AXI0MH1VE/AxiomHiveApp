//
//  TransactionViewModel.swift
//  AxiomHiveApp
//
//  ViewModel for Transaction operations
//

import Foundation
import SwiftUI

@MainActor
class TransactionViewModel: ObservableObject {
    @Published var currentTransaction: Transaction?
    @Published var isProcessing: Bool = false
    @Published var error: Error?
    @Published var showSuccess: Bool = false
    @Published var result: AxiomResponse?
    
    private let axiomService: AxiomHiveService
    private let appState: AppState
    
    init(axiomService: AxiomHiveService, appState: AppState) {
        self.axiomService = axiomService
        self.appState = appState
    }
    
    func executeTransaction(
        type: TransactionType,
        operation: String,
        parameters: [String: AnyCodable]
    ) async {
        guard let user = appState.currentUser else {
            error = AxiomError.authenticationFailed
            return
        }
        
        isProcessing = true
        defer { isProcessing = false }
        
        let request = TransactionRequest(
            operation: operation,
            parameters: parameters
        )
        
        var transaction = Transaction(
            userId: user.id,
            type: type,
            status: .processing,
            request: request
        )
        
        currentTransaction = transaction
        appState.addTransaction(transaction)
        
        do {
            let response = try await axiomService.executeTransaction(request)
            
            transaction.status = .completed
            transaction.response = response
            transaction.completedAt = Date()
            
            currentTransaction = transaction
            appState.updateTransaction(transaction)
            
            result = response
            showSuccess = true
        } catch {
            transaction.status = .failed
            transaction.completedAt = Date()
            transaction.error = TransactionError(
                code: "EXECUTION_FAILED",
                message: error.localizedDescription
            )
            
            currentTransaction = transaction
            appState.updateTransaction(transaction)
            
            self.error = error
        }
    }
    
    func cancelTransaction() {
        guard var transaction = currentTransaction else { return }
        
        transaction.status = .cancelled
        transaction.completedAt = Date()
        
        currentTransaction = transaction
        appState.updateTransaction(transaction)
    }
    
    func clearResult() {
        result = nil
        showSuccess = false
        currentTransaction = nil
    }
    
    func retryTransaction() async {
        guard let transaction = currentTransaction else { return }
        
        await executeTransaction(
            type: transaction.type,
            operation: transaction.request.operation,
            parameters: transaction.request.parameters
        )
    }
}
