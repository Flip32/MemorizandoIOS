//
//  EmojiMemorizando.swift
//  Memorizando
//
//  Created by Filipe Lopes on 29/07/21.
//

import SwiftUI
import Combine

// ViewModel
class EmojiMemorizando: ObservableObject {
    
    @Published
    var model: MemoryGame<String> = EmojiMemorizando.createMemoryGame(gameMode: "Bolas")
    
    @Published
    var gameMode: String?
    
    static func createMemoryGame(gameMode: String) -> MemoryGame<String> {
        
        var gameModesEmojis: [String] {
            var modeChosen: [String] = [""]
            if gameMode == "Frutas" {
                modeChosen = ["🥑", "🍎", "🍊", "🍐", "🥝", "🍇", "🍉", "🍍", "🥥", "🫐", "🍒", "🍌" ]
            }
            if gameMode == "Bolas" {
                modeChosen = ["🏈", "⚽️", "🥎", "🏀", "🎱",]
            }
            if gameMode == "Animais" {
                modeChosen = ["🐸", "🐣", "🦐", "🐢", "🦧",]
            }
            
            return modeChosen
        }
        
        let emojisDB = gameModesEmojis
        let emojisDbShuffed = emojisDB.shuffled()
        var emojis: [String] = []
        let numberOfElements = Int.random(in: 1..<4)
        for n in 0...numberOfElements {
            emojis.append(emojisDbShuffed[n])
        }
        
        return MemoryGame(numberOfPairs: emojis.count){
            emojis[$0]
        }
    }
    
    // MARK: Acesso da View à model
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var totalScore: Int {
        model.totalScore
    }
    
    var gameOver: Bool {
        model.gameOver
    }
    
    // MARK: Processamento de Intenções
    func choose(card: MemoryGame<String>.Card) {
        if card.isFacedUp {
            return
        } else {
            model.choose(card: card)
        }
    }
    
    func newGame(gameMode: String){
        model = EmojiMemorizando.createMemoryGame(gameMode: gameMode)
    }
    
}
