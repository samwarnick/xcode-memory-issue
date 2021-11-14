//
//  Savings_TrackerApp.swift
//  Shared
//
//  Created by Sam Warnick on 11/14/21.
//

import SwiftUI

@main
struct Savings_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
