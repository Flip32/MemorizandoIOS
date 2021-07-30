//
//  EmojiMemorizando.swift
//  Memorizando
//
//  Created by Filipe Lopes on 29/07/21.
//

import Foundation

// ViewModel
class EmojiMemorizando: ObservableObject {
    
    @Published
    var model: MemoryGame<String> = EmojiMemorizando.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        
//        let emojis = ["🥑", "🍎", "🍊", "🍐", "🥝", "🍇", "🍉" ]
        let emojis = ["🥑", "🍎", "🍊", ]
        
        return MemoryGame(numberOfPairs: emojis.count){
            emojis[$0]
        }
    }
    
    // MARK: Acesso da View à model
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: Processamento de Intenções
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}
