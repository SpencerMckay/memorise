//
//  EmojiMemoryGame.swift
//  memorise
//
//  Created by Spencer Mckay on 30/07/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    struct Theme {
        var themeName: String
        var cardDeck: [String]
        var numPairs: Int
        var cardsColour: String
    }
    

    static let themes = [
        Theme(
            themeName: "Night",
            cardDeck: ["👻", "😈", "😱", "🌌", "✨", "🌜"],
            numPairs: 5,
            cardsColour: "purple"
        ),
        Theme(
            themeName: "Locksmith",
            cardDeck: ["🔒","🔑","🗝️","🔐","⛓️","🚪","💎", "🥷🏻"],
            numPairs: 8,
            cardsColour: "gold"
        ),
        Theme(
            themeName: "Flags",
            cardDeck: ["🇺🇸", "🇳🇿", "🇦🇺", "🇬🇧", "🇨🇦", "🇯🇵", "🇨🇳", "🇰🇷", "🇸🇬",
                       "🇩🇪", "🇫🇷", "🇪🇸", "🇨🇭", "🇮🇹", "🇮🇱", "🇧🇷"],
            numPairs: 16,
            cardsColour: "red"
        )
    ]


    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        var cardsToUse = theme.cardDeck
        
        for _ in 0..<(theme.cardDeck.count - theme.numPairs) { // remove cards if deck has more than number to be used by theme
            let throwoutCardIndex = cardsToUse.indices.randomElement()!
            cardsToUse.remove(at: throwoutCardIndex)
        }
        
        return MemoryGame<String>(numberofPairsOfCards: cardsToUse.count) {
            pairIndex in cardsToUse[pairIndex]
        }
    }
    

    @Published private var model: MemoryGame<String> = createMemoryGame(theme: themes.randomElement()!)
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards.shuffled()
    }
    
    func tapCard(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    
}
