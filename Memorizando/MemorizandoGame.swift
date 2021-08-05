//
//  MemorizandoGame.swift
//  Memorizando
//
//  Created by Filipe Lopes on 29/07/21.
//

import Foundation



// Model do MVVM
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    var cards: [Card]
    private var indexOfPreviousChosenCard: Int?
    
//    func creatCard(pairIndex) -> CardContent {
        
//    }
    
    init(numberOfPairs: Int, cardFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairs{
            let content = cardFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards = cards.shuffled()
    }
    
    mutating func choose(card: Card){
        print("Carta escolhida: \(card)")
        
        if let chosenCardIndex = cards.firstIndex(matching: card){
            
            if let possibleMatch = indexOfPreviousChosenCard {
                if cards[chosenCardIndex].content == cards[possibleMatch].content {
                    cards[chosenCardIndex].isMatched = true
                    cards[possibleMatch].isMatched = true
                }
                
                
                
            } else {
                indexOfPreviousChosenCard = chosenCardIndex
            }
            
            cards[chosenCardIndex].isFacedUp = true
            
        }
    }
    
    
    struct Card: Identifiable {
        var id: Int
        var isFacedUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
    }
    
}
