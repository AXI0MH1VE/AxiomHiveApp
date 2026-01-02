//
//  ViewModelTests.swift
//  AxiomHiveAppTests
//
//  Tests for ViewModels
//

import XCTest
@testable import AxiomHiveApp

@MainActor
final class ViewModelTests: XCTestCase {
    var appState: AppState!
    var mockAuthService: MockAuthenticationService!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthenticationService()
        appState = AppState(authService: mockAuthService)
    }
    
    override func tearDown() {
        appState = nil
        mockAuthService = nil
        super.tearDown()
    }
    
    func testAppStateInitialization() {
        XCTAssertNil(appState.currentUser)
        XCTAssertFalse(appState.isAuthenticated)
        XCTAssertFalse(appState.isLoading)
        XCTAssertTrue(appState.transactions.isEmpty)
    }
    
    func testSignInSuccess() async {
        let testUser = User(
            username: "testuser",
            email: "test@example.com",
            fullName: "Test User",
            apiKey: "test-api-key"
        )
        mockAuthService.mockUser = testUser
        
        await appState.signIn(email: "test@example.com", password: "password123")
        
        XCTAssertNotNil(appState.currentUser)
        XCTAssertEqual(appState.currentUser?.username, "testuser")
        XCTAssertTrue(appState.isAuthenticated)
    }
    
    func testSignOut() {
        appState.currentUser = User(
            username: "testuser",
            email: "test@example.com",
            fullName: "Test User",
            apiKey: "test-api-key"
        )
        appState.isAuthenticated = true
        
        appState.signOut()
        
        XCTAssertNil(appState.currentUser)
        XCTAssertFalse(appState.isAuthenticated)
        XCTAssertTrue(appState.transactions.isEmpty)
    }
    
    func testAddTransaction() {
        let user = User(
            username: "testuser",
            email: "test@example.com",
            fullName: "Test User",
            apiKey: "test-api-key"
        )
        appState.currentUser = user
        
        let transaction = Transaction(
            userId: user.id,
            type: .aiQuery,
            request: TransactionRequest(
                operation: "test",
                parameters: [:]
            )
        )
        
        appState.addTransaction(transaction)
        
        XCTAssertEqual(appState.transactions.count, 1)
        XCTAssertEqual(appState.transactions.first?.id, transaction.id)
    }
    
    func testUpdateTransaction() {
        let user = User(
            username: "testuser",
            email: "test@example.com",
            fullName: "Test User",
            apiKey: "test-api-key"
        )
        appState.currentUser = user
        
        var transaction = Transaction(
            userId: user.id,
            type: .aiQuery,
            request: TransactionRequest(
                operation: "test",
                parameters: [:]
            )
        )
        
        appState.addTransaction(transaction)
        
        transaction.status = .completed
        appState.updateTransaction(transaction)
        
        XCTAssertEqual(appState.transactions.first?.status, .completed)
    }
    
    func testHomeViewModelLoadDashboard() async {
        let service = AxiomHiveService(apiKey: "test-key")
        let homeViewModel = HomeViewModel(axiomService: service, appState: appState)
        
        await homeViewModel.loadDashboard()
        
        XCTAssertFalse(homeViewModel.isLoading)
        XCTAssertTrue(homeViewModel.recentTransactions.isEmpty)
    }
}

// MARK: - Mock Services
class MockAuthenticationService: AuthenticationService {
    var mockUser: User?
    var shouldFail = false
    
    override func signIn(email: String, password: String) async throws -> User {
        if shouldFail {
            throw AxiomError.authenticationFailed
        }
        guard let user = mockUser else {
            throw AxiomError.authenticationFailed
        }
        return user
    }
    
    override func signUp(username: String, email: String, password: String, fullName: String) async throws -> User {
        if shouldFail {
            throw AxiomError.authenticationFailed
        }
        guard let user = mockUser else {
            throw AxiomError.authenticationFailed
        }
        return user
    }
    
    override func getCurrentUser() async throws -> User? {
        return mockUser
    }
}
