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
                
            AspectVGrid(items: emojiMemoryGame.cards, aspectRatio: 2/3, content: { card in
                CardView(card: card, cardColor: emojiMemoryGame.activeTheme.cardsColour)
                    .aspectRatio(2/3, contentMode: .fit )
                    .onTapGesture {
                        emojiMemoryGame.tapCard(card) // Wtf???
                    }
            })
//                        }
//                    }
//                }
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
        GeometryReader{ geometry in
            ZStack {
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20)).opacity(0.5).padding(5)
                    Text(card.content)
                        .font(font(in: geometry.size))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: 2)) {
                            
                            }
                        }
                    }
                        
                .cardify(isFaceUp: card.isFaceUp)
                
            }

    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.emojiScaler)
    }
    
    private struct DrawingConstants {
        static let cornerRaidus: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let emojiScaler: CGFloat = 0.65
    }
}


struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.tapCard(game.cards.first!)
        return ContentView(emojiMemoryGame: game)
            .preferredColorScheme(.dark)
        
    }
}
