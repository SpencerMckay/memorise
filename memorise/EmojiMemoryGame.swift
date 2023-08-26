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
    
    private let themes: [Theme]
    private(set) var activeTheme: Theme
    @Published private var model: MemoryGame<String>
    
    init() {
        
        self.themes = [
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
        
        self.activeTheme = self.themes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(theme: self.activeTheme)
    }
    

    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        var cardsToUse = theme.cardDeck.shuffled()
        
        let availableCards = min(theme.cardDeck.count, theme.numPairs) // Don't cause error allow having more pairs than unique cards
        for _ in 0..<(theme.cardDeck.count-availableCards) { // remove cards if deck has more than number to be used by theme
            cardsToUse.removeLast()
        }
        
        return MemoryGame<String>(numberofPairsOfCards: cardsToUse.count) {
            pairIndex in cardsToUse[pairIndex]
        }
    }
    
    

    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func tapCard(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        activeTheme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: activeTheme)
    }
    
}
