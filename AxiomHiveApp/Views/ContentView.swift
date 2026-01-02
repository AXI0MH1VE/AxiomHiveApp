//
//  ContentView.swift
//  AxiomHiveApp
//
//  Main content view with tab navigation
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab = 0
    
    var body: some View {
        if appState.isAuthenticated {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)
                
                TransactionView()
                    .tabItem {
                        Label("Transactions", systemImage: "arrow.left.arrow.right")
                    }
                    .tag(1)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(2)
            }
            .accentColor(Constants.Colors.primary)
        } else {
            LoginView()
        }
    }
}

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var username = ""
    @State private var fullName = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.UI.largePadding) {
                    // Logo/Header
                    VStack(spacing: Constants.UI.padding) {
                        Image(systemName: "cube.transparent.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(Constants.Colors.primary)
                        
                        Text("AxiomHive")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Deterministic AI Platform")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 40)
                    
                    // Form
                    VStack(spacing: Constants.UI.padding) {
                        if isSignUp {
                            TextField("Username", text: $username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                            
                            TextField("Full Name", text: $fullName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: handleAuth) {
                            if appState.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text(isSignUp ? "Sign Up" : "Sign In")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Constants.Colors.primary)
                        .foregroundColor(.white)
                        .cornerRadius(Constants.UI.cornerRadius)
                        .disabled(appState.isLoading || !isFormValid)
                        
                        Button(action: { isSignUp.toggle() }) {
                            Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                                .foregroundColor(Constants.Colors.primary)
                        }
                    }
                    .padding(.horizontal, Constants.UI.largePadding)
                }
            }
            .navigationBarHidden(true)
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private var isFormValid: Bool {
        if isSignUp {
            return !email.isEmpty && email.isValidEmail && 
                   !password.isEmpty && password.isValidPassword &&
                   !username.isEmpty && !fullName.isEmpty
        } else {
            return !email.isEmpty && !password.isEmpty
        }
    }
    
    private func handleAuth() {
        Task {
            if isSignUp {
                await appState.signUp(
                    username: username,
                    email: email,
                    password: password,
                    fullName: fullName
                )
            } else {
                await appState.signIn(email: email, password: password)
            }
            
            if let error = appState.error {
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
