//
//  QuoteApp.swift
//  Quote
//
//  Created by Дарья Петренко on 29.04.2023.
//

import SwiftUI

@main
struct QuoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
