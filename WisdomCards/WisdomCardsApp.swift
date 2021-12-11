//
//  WisdomCardsApp.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/11/21.
//

import SwiftUI

@main
struct WisdomCardsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
