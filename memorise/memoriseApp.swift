//
//  memoriseApp.swift
//  memorise
//
//  Created by Spencer Mckay on 16/07/23.
//

import SwiftUI

@main
struct memoriseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
