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
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(120)), count: 3), content: {
                ForEach(0..<9) { index in
                    ZStack {
                        Color.blue
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
                }
            })
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
