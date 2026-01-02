//
//  HomeViewModel.swift
//  AxiomHiveApp
//
//  ViewModel for Home screen
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var recentTransactions: [Transaction] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var statistics: DashboardStatistics?
    
    private let axiomService: AxiomHiveService
    private let appState: AppState
    
    init(axiomService: AxiomHiveService, appState: AppState) {
        self.axiomService = axiomService
        self.appState = appState
    }
    
    func loadDashboard() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // Load recent transactions
            recentTransactions = Array(appState.transactions.prefix(10))
            
            // Calculate statistics
            calculateStatistics()
        } catch {
            self.error = error
        }
    }
    
    func refreshData() async {
        await loadDashboard()
    }
    
    private func calculateStatistics() {
        guard let user = appState.currentUser else { return }
        
        let totalTransactions = appState.transactions.count
        let completedTransactions = appState.transactions.filter { $0.status == .completed }.count
        let failedTransactions = appState.transactions.filter { $0.status == .failed }.count
        let averageResponseTime = calculateAverageResponseTime()
        
        statistics = DashboardStatistics(
            totalTransactions: totalTransactions,
            completedTransactions: completedTransactions,
            failedTransactions: failedTransactions,
            successRate: totalTransactions > 0 ? Double(completedTransactions) / Double(totalTransactions) * 100 : 0,
            averageResponseTime: averageResponseTime
        )
    }
    
    private func calculateAverageResponseTime() -> TimeInterval {
        let completedTransactions = appState.transactions.filter { $0.status == .completed }
        guard !completedTransactions.isEmpty else { return 0 }
        
        let totalTime = completedTransactions.compactMap { $0.duration }.reduce(0, +)
        return totalTime / Double(completedTransactions.count)
    }
}

struct DashboardStatistics {
    let totalTransactions: Int
    let completedTransactions: Int
    let failedTransactions: Int
    let successRate: Double
    let averageResponseTime: TimeInterval
}
