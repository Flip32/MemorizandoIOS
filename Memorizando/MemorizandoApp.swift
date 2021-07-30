//
//  MemorizandoApp.swift
//  Memorizando
//
//  Created by Filipe Lopes on 22/07/21.
//

import SwiftUI

@main
struct MemorizandoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: EmojiMemorizando())
        }
    }
}
