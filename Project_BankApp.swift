//
//  Project_BankApp.swift
//  Project_Bank
//
//  Created by roger_jove on 23/6/25.
//

import SwiftUI

@main
struct Project_BankApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
