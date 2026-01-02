//
//  AxiomHiveAppApp.swift
//  AxiomHiveApp
//
//  Production-grade iOS app with deterministic AI
//

import SwiftUI

@main
struct AxiomHiveAppApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
