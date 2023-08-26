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
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) { // Why is this a lazy grid?
                        ForEach(emojiMemoryGame.cards) {
                            card in CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    emojiMemoryGame.tapCard(card) // Wtf???
                                }
                        }
                    }
                }
                .padding(.horizontal)
                
            
            HStack {
                Spacer()
                
                Button("New Game") {
                    print("nothing")
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
                shape.fill()
            }
                
        }
    }
}
    

    

