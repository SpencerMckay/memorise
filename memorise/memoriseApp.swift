//
//  memoriseApp.swift
//  memorise
//
//  Created by Spencer Mckay on 16/07/23.
//

import SwiftUI

@main
struct memoriseApp: App {
    let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            ContentView(emojiMemoryGame: game)
        }
    }
}
