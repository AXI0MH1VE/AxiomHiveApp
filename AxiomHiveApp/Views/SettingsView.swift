//
//  SettingsView.swift
//  AxiomHiveApp
//
//  User settings and preferences view
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @State private var showSignOutConfirmation = false
    
    var body: some View {
        NavigationView {
            Form {
                if let user = appState.currentUser {
                    Section("Profile") {
                        HStack {
                            Text("Username")
                            Spacer()
                            Text(user.username)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Email")
                            Spacer()
                            Text(user.email)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Full Name")
                            Spacer()
                            Text(user.fullName)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Member Since")
                            Spacer()
                            Text(user.createdAt.formatted(style: .medium))
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Section("Statistics") {
                        HStack {
                            Text("Total Transactions")
                            Spacer()
                            Text("\(user.statistics.totalTransactions)")
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Success Rate")
                            Spacer()
                            Text(user.statistics.successRate.formatAsPercentage())
                                .foregroundColor(
                                    user.statistics.successRate > 80 ? Constants.Colors.success : Constants.Colors.warning
                                )
                        }
                        
                        HStack {
                            Text("Total API Calls")
                            Spacer()
                            Text("\(user.statistics.totalApiCalls)")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Section("Preferences") {
                        Toggle("Enable Notifications", isOn: .constant(user.preferences.enableNotifications))
                        
                        Toggle("Enable Biometrics", isOn: .constant(user.preferences.enableBiometrics))
                        
                        Picker("Theme", selection: .constant(user.preferences.theme)) {
                            ForEach(AppTheme.allCases, id: \.self) { theme in
                                Text(theme.rawValue.capitalized).tag(theme)
                            }
                        }
                        
                        HStack {
                            Text("Language")
                            Spacer()
                            Text(user.preferences.language.uppercased())
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section("API") {
                    HStack {
                        Text("API Version")
                        Spacer()
                        Text(Constants.API.version)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Base URL")
                        Spacer()
                        Text("api.axiomhive.com")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
                
                Section("App") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(Constants.App.version)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Build")
                        Spacer()
                        Text(Constants.App.buildNumber)
                            .foregroundColor(.secondary)
                    }
                    
                    Button("Clear Transaction History") {
                        appState.clearTransactions()
                    }
                    .foregroundColor(Constants.Colors.warning)
                }
                
                Section {
                    Button(action: { showSignOutConfirmation = true }) {
                        HStack {
                            Spacer()
                            Text("Sign Out")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .confirmationDialog("Sign Out", isPresented: $showSignOutConfirmation) {
                Button("Sign Out", role: .destructive) {
                    appState.signOut()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to sign out?")
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
