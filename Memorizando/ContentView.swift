//
//  ContentView.swift
//  Memorizando
//
//  Created by Filipe Lopes on 22/07/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        HStack{
            VStack {
                RoundedRectangle(cornerRadius: 12)
                    .makeCard()
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                
                Text("🍎")
                    .makeCard()
                
                Text("🍐")
                    .makeCard()
                
                Text("🍊")
                    .makeCard()
            }
            
            VStack {
                Text("🥑")
                    .makeCard()
                
                Text("🍎")
                    .makeCard()
                
                Text("🍐")
                    .makeCard()
                
                Text("🍊")
                    .makeCard()
            }
        }
        .font(Font.system(size: 120))
        .foregroundColor(Color.red)
        .preferredColorScheme(.dark)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
