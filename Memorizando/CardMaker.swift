//
//  CardMaker.swift
//  Memorizando
//
//  Created by Filipe Lopes on 22/07/21.
//

import SwiftUI

struct CardMaker: ViewModifier {
    
    let cornerRadius: CGFloat
    let lineWidth: CGFloat
    
    init(cornerRadius: CGFloat = 12, lineWidth: CGFloat = 8) {
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth
    }
    
    func body(content: Content) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
            RoundedRectangle(cornerRadius: lineWidth)
                .stroke(lineWidth: 4)
            content
        }
        .padding()
        .foregroundColor(Color.red)
    }
}


extension View {
    func makeCard() -> some View {
        self.modifier(CardMaker())
    }
    
    func makeCard(withCornner cornerRadius: CGFloat, andLineWidth lineWidth: CGFloat) -> some View {
        self.modifier(CardMaker(cornerRadius: cornerRadius, lineWidth: lineWidth))
    }
    
}
