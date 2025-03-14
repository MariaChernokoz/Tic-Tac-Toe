//
//  ContentView.swift
//  TicTacToe
//
//  Created by Chernokoz on 12.03.2025.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var game: GameService
    @State private var gameType: GameType = .undetermined
    @State private var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus: Bool
    @State private var startGame: Bool = false
    var body: some View {
            VStack {
                Picker("Select Game", selection: $gameType) {
                    Text("Select Game Type").tag(GameType.undetermined)
                    Text("Two Sharing devices").tag(GameType.single)
                    Text("Challange your device").tag(GameType.bot)
                    Text("Challange a friend").tag(GameType.peer)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 50, style: .continuous).stroke(lineWidth: 2))
                Text(gameType.description)
                    .padding()
                VStack {
                    switch gameType {
                    case .single:
                        VStack {
                            TextField("Your name", text: $yourName)
                            TextField("Opponent name", text: $opponentName)
                        }
                    case .bot:
                        TextField("Your Name", text: $yourName)
                    case .peer:
                        EmptyView()
                    case .undetermined:
                        EmptyView()
                    }
                }
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($focus)
                .frame(width: 350)
                if gameType != .peer {
                    Button("Start Game") {
                        game.setupGame(gameType: gameType, playerName: yourName, player2Name: opponentName)
                        focus = false
                        startGame.toggle()
                    }
                    .padding(30)
                    .buttonStyle(.borderedProminent)
                    .disabled(
                        gameType == .undetermined ||
                        gameType == .bot && yourName.isEmpty ||
                        gameType != .single &&
                        (yourName.isEmpty || opponentName.isEmpty)
                    )
                    Image("LaunchScreen")
                }
                Spacer()
            }
            .padding()
            .navigationTitle(Text("Tic Tac Toe"))
            .fullScreenCover(isPresented: $startGame) {
                GameView()
            }
            .inNavigationStack()
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(GameService())
    }
}
