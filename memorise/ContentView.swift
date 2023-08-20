//
//  ContentView.swift
//  memorise
//
//  Created by Spencer Mckay on 16/07/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame

    var body: some View {
        VStack {
            Text("Memorise")
                .font(.title)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(emojiMemoryGame.cards) {
                        card in CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                emojiMemoryGame.tapCard(card)
                            }
                    }
                }
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                
                VStack{
                    Image(systemName: "globe.americas")
                    Text("Flags")
                }
                VStack{
                    Image(systemName: "lock.circle")
                    Text("Locks & Keys")
                }
                VStack{
                    Image(systemName: "bolt.circle")
                    Text("Other")
                }
                
                Spacer()
            }
        }
        
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                Text(card.content)
            }
            else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill(Color(hue: 1.0, saturation: 0.0, brightness: 0.328))
            }
                
        }
    }
}

