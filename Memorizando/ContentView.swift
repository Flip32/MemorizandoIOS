//
//  ContentView.swift
//  Memorizando
//
//  Created by Filipe Lopes on 22/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject
    var viewModel: EmojiMemorizando
    
    var body: some View {
        
        VStack{
            ForEach(viewModel.cards) {
                card in
                Text(card.content)
                    .makeCard(isFacedUp: card.isFacedUp)
                    .onTapGesture {
                        viewModel.choose(card: card)
                    }
            }
        }
        .font(Font.system(size: 40))
        .foregroundColor(Color.red)
        .preferredColorScheme(.dark)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemorizando())
    }
}
