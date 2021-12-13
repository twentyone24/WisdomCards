//
//  WisdomCardsApp.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/11/21.
//

import SwiftUI

@main
struct WisdomCardsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    
    @StateObject var authViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(authViewModel)
                .onAppear(perform: authViewModel.checkAuthStatus)
        }
    }
}


