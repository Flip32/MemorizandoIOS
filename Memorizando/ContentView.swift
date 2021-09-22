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
                    .frame(height: 50)
                Text("Você conseguiu \(viewModel.totalScore) pontos")
                    .font(.system(size: 30))
                Spacer()
            } else {
                Grid(viewModel.cards) {
                    card in
                    GeometryReader{
                        geometry in
                        CardView(card: card)
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
    
    
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    @State
    private var bonusTimeRemaining: Double = 0
    
    private func startTimerAnimation() {
        bonusTimeRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusRemaining)){
            bonusTimeRemaining = 0
        }
    }
    
    var body: some View {
        GeometryReader{
            geometry in
            
            ZStack {
                
                Group {
                    if card.isConsumingBonusTime {
                        Timer(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-bonusTimeRemaining * 360 - 90))
                            .onAppear {
                                startTimerAnimation()
                            }
                    } else {
                        Timer(startAngle: Angle.degrees(-90), endAngle: Angle.degrees( -card.bonusRemaining * 360 - 90))
                    }
                }
                .opacity(0.7)
                .padding(6)
                
                
                Text(card.content)
                    .font(.system(size: fontSize(for: geometry.size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    
                }
                .makeCard(isFacedUp: card.isFacedUp)
                .padding(4)
                .opacity(card.isMatched ? 0 : 1)
            
            }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.65
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemorizando())
    }
}
