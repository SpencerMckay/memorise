//
//  EmojiMemoryGame.swift
//  memorise
//
//  Created by Spencer Mckay on 30/07/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    
    
    static func createMemoryGame() -> MemoryGame<String> {
        
        MemoryGame<String>(numberofPairsOfCards: nightEmojis.count) {
            pairIndex in nightEmojis[pairIndex]
        }
    }
    
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func tapCard(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
}
