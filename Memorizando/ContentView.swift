//
//  ContentView.swift
//  Memorizando
//
//  Created by Filipe Lopes on 22/07/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Text("Oi")
                .makeCard()
            
            Text("🍎")
                .makeCard()
            
            Text("🍐")
                .makeCard()
        }
        .font(Font.system(size: 120))
        .foregroundColor(Color.red)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
