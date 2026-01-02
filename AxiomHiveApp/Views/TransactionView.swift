//
//  TransactionView.swift
//  AxiomHiveApp
//
//  Transaction creation and management view
//

import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel: TransactionViewModel
    @State private var showNewTransaction = false
    
    init() {
        let appState = AppState()
        let service = AxiomHiveService(apiKey: "demo-key")
        _viewModel = StateObject(wrappedValue: TransactionViewModel(axiomService: service, appState: appState))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Transaction List
                if appState.transactions.isEmpty {
                    EmptyStateView(
                        icon: "arrow.left.arrow.right.circle",
                        title: "No Transactions",
                        message: "Create your first transaction to get started"
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: Constants.UI.padding) {
                            ForEach(appState.transactions) { transaction in
                                TransactionDetailRowView(transaction: transaction)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showNewTransaction = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showNewTransaction) {
                NewTransactionView(viewModel: viewModel, isPresented: $showNewTransaction)
            }
            .alert("Success", isPresented: $viewModel.showSuccess) {
                Button("OK") {
                    viewModel.clearResult()
                }
            } message: {
                Text("Transaction completed successfully")
            }
            .errorAlert(error: $viewModel.error, isPresented: .constant(viewModel.error != nil))
        }
    }
}

struct TransactionDetailRowView: View {
    let transaction: Transaction
    @State private var showDetails = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.UI.padding) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(transaction.type.rawValue.capitalized)
                        .font(.headline)
                    
                    Text("ID: \(transaction.id.uuidString.prefix(8))...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(transaction.createdAt.formatted())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(transaction.status.rawValue.capitalized)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.statusColor(for: transaction.status).opacity(0.2))
                        .foregroundColor(Color.statusColor(for: transaction.status))
                        .cornerRadius(Constants.UI.cornerRadius / 2)
                    
                    if let duration = transaction.duration {
                        Text(duration.formatted())
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            if showDetails {
                Divider()
                
                VStack(alignment: .leading, spacing: Constants.UI.smallPadding) {
                    Text("Operation: \(transaction.request.operation)")
                        .font(.caption)
                    
                    if let response = transaction.response {
                        Text("Confidence: \(response.result.confidence.formatAsPercentage())")
                            .font(.caption)
                        
                        if let reasoning = response.result.reasoning {
                            Text("Reasoning: \(reasoning.truncated(to: 100))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    if let error = transaction.error {
                        Text("Error: \(error.message)")
                            .font(.caption)
                            .foregroundColor(Constants.Colors.error)
                    }
                }
            }
            
            Button(action: { withAnimation { showDetails.toggle() }}) {
                HStack {
                    Text(showDetails ? "Hide Details" : "Show Details")
                        .font(.caption)
                    Image(systemName: showDetails ? "chevron.up" : "chevron.down")
                        .font(.caption)
                }
                .foregroundColor(Constants.Colors.primary)
            }
        }
        .padding()
        .cardStyle()
    }
}

struct NewTransactionView: View {
    @ObservedObject var viewModel: TransactionViewModel
    @Binding var isPresented: Bool
    
    @State private var selectedType: TransactionType = .aiQuery
    @State private var operation = ""
    @State private var parameters: [String: String] = [:]
    @State private var newKey = ""
    @State private var newValue = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Transaction Type") {
                    Picker("Type", selection: $selectedType) {
                        ForEach(TransactionType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Operation") {
                    TextField("Operation name", text: $operation)
                }
                
                Section("Parameters") {
                    ForEach(Array(parameters.keys.sorted()), id: \.self) { key in
                        HStack {
                            Text(key)
                                .font(.subheadline)
                            Spacer()
                            Text(parameters[key] ?? "")
                                .foregroundColor(.secondary)
                            Button(action: { parameters.removeValue(forKey: key) }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    HStack {
                        TextField("Key", text: $newKey)
                        TextField("Value", text: $newValue)
                        Button(action: addParameter) {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(newKey.isEmpty || newValue.isEmpty)
                    }
                }
                
                Section {
                    Button(action: executeTransaction) {
                        if viewModel.isProcessing {
                            HStack {
                                ProgressView()
                                Text("Processing...")
                            }
                        } else {
                            Text("Execute Transaction")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(viewModel.isProcessing || !isValid)
                }
            }
            .navigationTitle("New Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
    
    private var isValid: Bool {
        !operation.isEmpty
    }
    
    private func addParameter() {
        parameters[newKey] = newValue
        newKey = ""
        newValue = ""
    }
    
    private func executeTransaction() {
        let params = parameters.mapValues { AnyCodable($0) }
        
        Task {
            await viewModel.executeTransaction(
                type: selectedType,
                operation: operation,
                parameters: params
            )
            
            if viewModel.error == nil {
                isPresented = false
            }
        }
    }
}

#Preview {
    TransactionView()
        .environmentObject(AppState())
}
