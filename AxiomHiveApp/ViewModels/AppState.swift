//
//  AppState.swift
//  AxiomHiveApp
//
//  Central application state management
//

import Foundation
import SwiftUI

@MainActor
class AppState: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var showError: Bool = false
    @Published var transactions: [Transaction] = []
    
    private let authService: AuthenticationService
    private let axiomService: AxiomHiveService?
    
    init(
        authService: AuthenticationService = AuthenticationService(),
        axiomService: AxiomHiveService? = nil
    ) {
        self.authService = authService
        self.axiomService = axiomService
        
        Task {
            await loadCurrentUser()
        }
    }
    
    func loadCurrentUser() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            if let user = try await authService.getCurrentUser() {
                currentUser = user
                isAuthenticated = true
            }
        } catch {
            handleError(error)
        }
    }
    
    func signIn(email: String, password: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let user = try await authService.signIn(email: email, password: password)
            currentUser = user
            isAuthenticated = true
        } catch {
            handleError(error)
        }
    }
    
    func signUp(username: String, email: String, password: String, fullName: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let user = try await authService.signUp(
                username: username,
                email: email,
                password: password,
                fullName: fullName
            )
            currentUser = user
            isAuthenticated = true
        } catch {
            handleError(error)
        }
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
        transactions.removeAll()
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions.insert(transaction, at: 0)
        
        // Update user statistics
        if var user = currentUser {
            user.statistics.totalTransactions += 1
            if transaction.status == .completed {
                user.statistics.successfulTransactions += 1
            } else if transaction.status == .failed {
                user.statistics.failedTransactions += 1
            }
            currentUser = user
        }
    }
    
    func updateTransaction(_ transaction: Transaction) {
        if let index = transactions.firstIndex(where: { $0.id == transaction.id }) {
            transactions[index] = transaction
        }
    }
    
    func clearTransactions() {
        transactions.removeAll()
    }
    
    private func handleError(_ error: Error) {
        self.error = error
        self.showError = true
    }
    
    func clearError() {
        error = nil
        showError = false
    }
}
