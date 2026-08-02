//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Sovanlal Maity on 10/03/26.
//

import SwiftUI

@main
struct NewsAppApp: App {
    @StateObject  private var loginViewModel = LoginViewModel()
    init() {
           if ProcessInfo.processInfo.arguments.contains("UI-TESTING-RESET-LOGIN") {
               UserDefaultsManager.shared.clearUserData()
           }
       }
    var body: some Scene {
        WindowGroup {
            AppRouter()
                            .environmentObject(loginViewModel)
        }
    }
}
