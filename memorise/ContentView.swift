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
            
            Text("\(emojiMemoryGame.activeTheme.themeName)")
                
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) { // Why is this a lazy grid?
                        ForEach(emojiMemoryGame.cards) {
                            card in CardView(card: card, cardColor: emojiMemoryGame.activeTheme.cardsColour)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    emojiMemoryGame.tapCard(card) // Wtf???
                                }
                        }
                    }
                }
                .foregroundColor(.blue)
                .padding(.horizontal)
                
            
            HStack {
                Spacer()
                
                Button("New Game") {
                    emojiMemoryGame.newGame()
                }
                
                
                Spacer()
            }
            
        }
        
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    let cardColor: String

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
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
    


struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(emojiMemoryGame: game)
            .preferredColorScheme(.dark)
        ContentView(emojiMemoryGame: game)
            .preferredColorScheme(.light)
        
    }
}
    

