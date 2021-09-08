//
//  Game_CounterApp.swift
//  Game Counter
//
//  Created by Adam Garrett-Harris on 9/8/21.
//

import SwiftUI

@main
struct Game_CounterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
