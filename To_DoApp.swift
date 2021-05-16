//
//  To_DoApp.swift
//  To-Do
//
//  Created by Alejo Acosta on 15/05/2021.
//

import SwiftUI

@main
struct To_DoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
