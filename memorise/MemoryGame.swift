//
//  MemoryGame.swift
//  memorise
//
//  Created by Spencer Mckay on 30/07/23.
//

import Foundation

struct MemoryGame<CardContent> {
    // The <CardConent> represents parsing a variable of any type which will be referenced as CardContent
    private(set) var cards: Array<Card>
    
    private var currentFaceUpCardIndex: Int?
    
    
    mutating func choose(_ card: Card) { // all function args are lets! need to find this card in the private array of cards, mutating makes this a ref/address parse type? not value parsed
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            
            if let potentialMatchIndex = currentFaceUpCardtIndex {
                if potentialMatchIndex == chosenIndex {
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                } else {
                    cards[potentialMatchIndex].isFaceUp = false
                    cards[chosenIndex].isFaceUp = false
                    currentFaceUpCardIndex = .none
                    
                }
            } else {
                currentFaceUpCardIndex = chosenIndex
                cards[chosenIndex].isFaceUp.toggle()
            }
            
            
        }
    }
    
    
    init(numberofPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add NumberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberofPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
    }
    
    struct Card: Identifiable {
        var id: Int // to make it identifiable
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
    
}
