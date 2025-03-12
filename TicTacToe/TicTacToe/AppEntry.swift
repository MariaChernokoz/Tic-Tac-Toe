//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Chernokoz on 12.03.2025.
//

import SwiftUI

@main
struct AppEntry: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            StartView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
