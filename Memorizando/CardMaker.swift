//
//  CardMaker.swift
//  Memorizando
//
//  Created by Filipe Lopes on 22/07/21.
//

import SwiftUI

struct CardMaker: ViewModifier {
    
    var isFacedUp: Bool
    
    let cornerRadius: CGFloat = 12
    let lineWidth: CGFloat = 12
    
    private var rotation: Double
    
    init(isFacedUp: Bool) {
        self.isFacedUp = isFacedUp
        rotation = isFacedUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack{
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: lineWidth)
                    .stroke(lineWidth: 4)
                content
            }.opacity(isFacedUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.pink)
                .opacity(isFacedUp ? 0 : 1)
        }
        .padding(EdgeInsets(top: 10, leading: 4, bottom: 0, trailing: 4))
        .foregroundColor(Color.purple)
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
}


extension View {
    func makeCard(isFacedUp: Bool = false) -> some View {
        self.modifier(CardMaker(isFacedUp: isFacedUp))
    }
    
}
