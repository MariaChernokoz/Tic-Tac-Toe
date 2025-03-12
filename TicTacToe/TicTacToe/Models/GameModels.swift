//
//  GameModels.swift
//  TicTacToe
//
//  Created by Chernokoz on 13.03.2025.
//

import Foundation

enum GameType {
    case single, bot, peer, undetermined
    
    var description: String {
        switch self {
        case .single:
            return "Share your iPhone/iPad and against a friend"
        case .bot:
            return "Play against this iPhone/iPad"
        case .peer:
            return "Invite someone near you who has this app running to play"
        case .undetermined:
            return ""
        }
    }
}
