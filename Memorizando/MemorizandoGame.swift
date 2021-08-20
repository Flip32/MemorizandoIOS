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
    private var indexOfPreviousChosenCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFacedUp }.only
//            let filtered = cards.indices.filter { index in
//                cards[index].isFacedUp
//            }
//            if filtered.count == 1 {
//                return filtered.first
//            } else {
//                return nil
//            }
        }
        
        set {
            for index in cards.indices {
                cards[index].isFacedUp = index == newValue
            }
        }
    }
    
    var gameOver: Bool {
        cards.allSatisfy { $0.isMatched }
    }
    
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
        var isFacedUp: Bool = false {
            didSet {
                if isFacedUp {
                    beginUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
//                oldValue - valor antigo da variavel
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var bonusTime: TimeInterval = 10
        
        var lastTimeFacingUp: Date?
        var lastIntervalFacingUp: TimeInterval = 0
        
        private var timeFacingUp: TimeInterval {
           
            if let lastFlip = lastTimeFacingUp {
                return lastIntervalFacingUp + Date().timeIntervalSince(lastFlip)
            }
            
            return lastIntervalFacingUp
        }
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTime - timeFacingUp)
        }
        
        var bonusRemaining: Double {
            (bonusTime > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTime : 0
        }
        
        var isConsumingBonusTime: Bool {
            isFacedUp && !isMatched && bonusTimeRemaining > 0
        }
        

        private mutating func beginUsingBonusTime() {
            if lastTimeFacingUp == nil {
                lastTimeFacingUp = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            lastIntervalFacingUp = timeFacingUp
            lastTimeFacingUp = nil
        }
    }
    
}
