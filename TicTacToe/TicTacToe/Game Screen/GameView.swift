//
//  GameView.swift
//  TicTacToe
//
//  Created by Chernokoz on 13.03.2025.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy({$0 == false}) {
                Text("Select a player to start")
            }
            HStack {
                Button {
                    game.player1.isCurrent = true
                } label: {
                    VStack {
                        Image("x") // Символ игрока 1yt
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text(game.player1.name) // Имя игрока
                            .foregroundColor(.black)
                            .font(.caption)
                    }
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player1.isCurrent))

                Button {
                    game.player2.isCurrent = true
                } label: {
                    VStack {
                        Image("o") // Символ игрока 2
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text(game.player2.name) // Имя игрока
                            .foregroundColor(.black)
                            .font(.caption)
                    }
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player2.isCurrent))
            }

            .disabled(game.gameStarted)
            VStack {
                HStack {
                    ForEach(0...2, id: \.self) { index in
                        SquareView(index: index)
                    }
                }
                HStack {
                    ForEach(3...5, id: \.self) { index in
                        SquareView(index: index)
                    }
                }
                HStack {
                    ForEach(6...8, id: \.self) { index in
                        SquareView(index: index)
                    }
                }
            }
            .disabled(game.boardDisabled)
            VStack {
                if game.gameOver {
                    Text("Game Over")
                    if game.possibleMoves.isEmpty {
                        Text("Nodody wins")
                    } else {
                        Text ("\(game.currentPlayer.name) wins!")
                    }
                    Button("New Game") {
                        game.reset()
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(width: 180, height: 80)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white.opacity(0.3), lineWidth: 2))
                    .foregroundColor(.white)
                    .font(.title)
                }
            }
            .font(.title)
            Spacer()
        }
        //.background(Color.accentColor.ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("End Game") {
                    dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("Tic Tac Toe")
        .onAppear {
            game.reset()
        }
        .inNavigationStack()
    }
        
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameService())
    }
}

/*
struct PlayerButtonStyle: ButtonStyle {
    let isCurrent: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(isCurrent ? Color.green : Color.gray)
            )
            .foregroundColor(.white)
    }
} */

struct PlayerButtonStyle: ButtonStyle {
    let isCurrent: Bool

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
                .frame(width: 80, height: 80)
                .cornerRadius(15)
                .foregroundColor(.white)
                .font(.title)
        }
        .padding(15)
    }
}

