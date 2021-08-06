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
            if viewModel.gameOver {
                Spacer()
                Text("Acabou o Jogo")
                    .font(.system(size: 40))
                Spacer()
            } else {
                Grid(viewModel.cards) {
                    card in
                    GeometryReader{
                        geometry in
                        Text(card.content)
                            .makeCard(isFacedUp: card.isFacedUp)
                            .padding(4)
                            .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                            .opacity(card.isMatched ? 0 : 1)
                            .font(.system(size: fontSize(for: geometry.size)))
                            .onTapGesture {
                                withAnimation {
                                    viewModel.choose(card: card)
                                }
                            }
                    }
                }
            }
            Button("Novo Jogo") {
                withAnimation(.easeInOut) {
                    viewModel.newGame()
                }
            }
        }
//        .font(Font.system(size: CGFloat(10) / (CGFloat(viewModel.cards.count / 2) / 10) ) )
        .foregroundColor(Color.red)
        .preferredColorScheme(.dark)
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.7
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemorizando())
    }
}
