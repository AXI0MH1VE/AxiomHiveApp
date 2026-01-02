//
//  HomeView.swift
//  AxiomHiveApp
//
//  Home dashboard view
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        let appState = AppState()
        let service = AxiomHiveService(apiKey: "demo-key")
        _viewModel = StateObject(wrappedValue: HomeViewModel(axiomService: service, appState: appState))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.UI.largePadding) {
                    // User Header
                    if let user = appState.currentUser {
                        UserHeaderView(user: user)
                            .padding(.horizontal)
                    }
                    
                    // Statistics Cards
                    if let stats = viewModel.statistics {
                        StatisticsView(statistics: stats)
                            .padding(.horizontal)
                    }
                    
                    // Recent Transactions
                    VStack(alignment: .leading, spacing: Constants.UI.padding) {
                        HStack {
                            Text("Recent Transactions")
                                .font(.headline)
                            Spacer()
                            if !viewModel.recentTransactions.isEmpty {
                                Button("View All") {
                                    // Navigate to transactions
                                }
                                .font(.subheadline)
                                .foregroundColor(Constants.Colors.primary)
                            }
                        }
                        .padding(.horizontal)
                        
                        if viewModel.recentTransactions.isEmpty {
                            EmptyStateView(
                                icon: "tray",
                                title: "No Transactions",
                                message: "Start by creating your first transaction"
                            )
                            .padding()
                        } else {
                            ForEach(viewModel.recentTransactions.prefix(5)) { transaction in
                                TransactionRowView(transaction: transaction)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Dashboard")
            .refreshable {
                await viewModel.refreshData()
            }
            .task {
                await viewModel.loadDashboard()
            }
        }
    }
}

struct UserHeaderView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: Constants.UI.padding) {
            Circle()
                .fill(Constants.Colors.primary.opacity(0.2))
                .frame(width: 60, height: 60)
                .overlay(
                    Text(user.fullName.prefix(1))
                        .font(.title)
                        .foregroundColor(Constants.Colors.primary)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullName)
                    .font(.headline)
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .cardStyle()
    }
}

struct StatisticsView: View {
    let statistics: DashboardStatistics
    
    var body: some View {
        VStack(spacing: Constants.UI.padding) {
            HStack(spacing: Constants.UI.padding) {
                StatCard(
                    title: "Total",
                    value: "\(statistics.totalTransactions)",
                    icon: "chart.bar.fill",
                    color: Constants.Colors.primary
                )
                
                StatCard(
                    title: "Success",
                    value: "\(statistics.completedTransactions)",
                    icon: "checkmark.circle.fill",
                    color: Constants.Colors.success
                )
            }
            
            HStack(spacing: Constants.UI.padding) {
                StatCard(
                    title: "Failed",
                    value: "\(statistics.failedTransactions)",
                    icon: "xmark.circle.fill",
                    color: Constants.Colors.error
                )
                
                StatCard(
                    title: "Success Rate",
                    value: statistics.successRate.formatAsPercentage(),
                    icon: "percent",
                    color: Constants.Colors.warning
                )
            }
            
            if statistics.averageResponseTime > 0 {
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(Constants.Colors.secondary)
                    Text("Avg Response Time: \(statistics.averageResponseTime.formatted())")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding()
                .cardStyle()
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.UI.smallPadding) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Spacer()
            }
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .cardStyle()
    }
}

struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: Constants.UI.padding) {
            Circle()
                .fill(Color.statusColor(for: transaction.status).opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: iconForType(transaction.type))
                        .foregroundColor(Color.statusColor(for: transaction.status))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.type.rawValue.capitalized)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(transaction.createdAt.timeAgo())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(transaction.status.rawValue.capitalized)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.statusColor(for: transaction.status).opacity(0.2))
                .foregroundColor(Color.statusColor(for: transaction.status))
                .cornerRadius(Constants.UI.cornerRadius / 2)
        }
        .padding()
        .cardStyle()
    }
    
    private func iconForType(_ type: TransactionType) -> String {
        switch type {
        case .aiQuery: return "brain"
        case .dataAnalysis: return "chart.line.uptrend.xyaxis"
        case .prediction: return "crystal.ball"
        case .optimization: return "speedometer"
        case .verification: return "checkmark.shield"
        }
    }
}

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: Constants.UI.padding) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .foregroundColor(.secondary)
            
            Text(title)
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
