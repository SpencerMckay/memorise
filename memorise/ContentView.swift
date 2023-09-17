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
                    LazyVGrid(columns: [GridItem(.adaptive(minimum:75))]) { // Why is this a lazy grid?
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
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRaidus)
                
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                }
                else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.fill()
                }
            }
        })

    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.emojiScaler)
    }
    
    private struct DrawingConstants {
        static let cornerRaidus: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let emojiScaler: CGFloat = 0.75
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
