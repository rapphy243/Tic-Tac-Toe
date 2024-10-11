//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Raphael Abano on 10/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var moves =  Array(repeating: "", count: 9)
    @State private var isXturn = true
    @State private var gameOver = false
    @State private var winMessage = ""
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(120)), count: 3), content: {
                ForEach(0..<9) { index in
                    ZStack {
                        Color.blue
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                        Text(moves[index])
                            .font(.system(size: 90))
                            .fontWeight(.heavy)
                    }
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
                    .onTapGesture {
                        withAnimation(.default){
                            if moves[index] == "" {
                                moves[index] = isXturn ? "X" : "O"
                                isXturn.toggle()
                            }
                        }
                    }
                    .rotation3DEffect(
                        .degrees(moves[index] == "" ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                }
            })
        }
        .preferredColorScheme(.dark)
        .alert(isPresented: $gameOver) {
            Alert(title: Text(winMessage), dismissButton: .destructive(Text("Play Again?"),                      action : {
                withAnimation {
                    moves = Array(repeating: "", count: 9)
                    gameOver = false
                }
            }))
        }
        .onChange(of: moves) { oldValue, newValue in
            checkForWinner()
            if !(gameOver || moves.contains("")) {
                winMessage = "Cat's Game!"
                gameOver = true
            }
        }
        
    }
    private func checkForWinner() {
        checkLine(a: 0, b: 1, c: 2) //top row
        checkLine(a: 3, b: 4, c: 5) //middle row
        checkLine(a: 6, b: 7, c: 8) //bottom row
        checkLine(a: 0, b: 3, c: 6) //first column
        checkLine(a: 1, b: 4, c: 7) //second column
        checkLine(a: 2, b: 5, c: 8) //third column
        checkLine(a: 0, b: 4, c: 8) // \ diagonal
        checkLine(a: 2, b: 4, c: 6) // / diagonal
    }
    
    private func checkLine(a: Int, b: Int, c: Int) {
        if moves[a] != "" && moves[a] == moves[b] && moves[b] == moves[c] {
            winMessage = "\(moves[a]) is the winner!"
            gameOver = true
        }
    }
}

#Preview {
    ContentView()
}
