//
//  MemoryGame.swift
//  memorise
//
//  Created by Spencer Mckay on 30/07/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable { //It can be any type but this type will be Equatable
    // The <CardConent> represents parsing a variable of any type which will be referenced as CardContent
    
    private(set) var cards: Array<Card>

    
    private var currentFaceUpCardIndex: Int? {
        get { cards.indices.filter( {cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } } //set it to be false if the card doesn't equal the newValue
    }
    
    
    mutating func choose(_ card: Card) { // usually all function args are lets! need to find this card in the private array of cards, mutating makes this a ref/address parse type? not value parsed
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = currentFaceUpCardIndex {
                if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                    cards[potentialMatchIndex].isMatched = true 
                    cards[chosenIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                currentFaceUpCardIndex = chosenIndex
            }
            
        }
    }
    
    
    init(numberofPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add NumberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberofPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
        
        cards = cards.shuffled() //is this all good omg
    }
    

    struct Card: Identifiable {
        var id: Int // to make it identifiable
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
    
}


extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
            
    }
}
