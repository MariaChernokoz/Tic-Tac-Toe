//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by Chernokoz on 12.03.2025.
//

import SwiftUI

@main
struct AppEntry: App {
    @StateObject var game = GameService()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(game)
        }
    }
}
