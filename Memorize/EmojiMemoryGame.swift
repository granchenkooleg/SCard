//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by CS193P Instructor on 04/06/2020.
//  Copyright © 2020 cs193p instructor. All rights reserved.
//

import SwiftUI

var paletteNames: [String: [String]] {
    get {
        [
            "Faces": ["😀", "😅", "😂", "😇", "🥰", "😉", "🙃", "😎", "🥳", "😡", "🤯", "🥶", "🤥", "😴", "🙄", "👿"],
            "Food": ["🍏", "🍎", "🥒", "🍞", "🥨", "🥓", "🍔", "🍟", "🍕", "🍰", "🍿", "🍤", "🍱", "🥝", "🌶", "🍒"],
            "Animals": ["🐮","🐭","🕷", "🐷", "🦊", "🐰", "🐻", "🐯", "🦁", "🐸", "🐵", "🐍", "🦝", "🐤", "🐶", "🐱"],
            "Sport": ["⚽️", "🏈", "⚾️", "🎾", "🏐", "🏓", "⛳️", "🥌", "⛷", "🚴‍♂️", "🎳", "🎼", "🎭", "🪂", "🥊", "🏀"],
            "Flags": ["🇪🇺", "🇷🇺", "🇹🇷", "🇩🇪", "🇺🇸", "🇯🇵", "🇮🇩", "🇨🇳", "🇪🇸", "🇨🇭", "🇺🇦", "🇫🇷", "🇮🇹", "🇰🇷", "🇧🇾", "🇧🇷"]
        ]
    }
}

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> =
                               EmojiMemoryGame.createMemoryGame()


    static func createMemoryGame(key: String? = nil) -> MemoryGame<String> {

        let emojis = key != nil ? paletteNames[key!]! : paletteNames[paletteNames.keys.randomElement()!]!
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards : Array<MemoryGame<String>.Card> {
         model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose (card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    func resetGame () {
        model = EmojiMemoryGame.createMemoryGame()
    }

//    func clearAll() -> MemoryGame<String> {
//        model.cards.removeAll()
////        let emojis = paletteNames["Food"]!
////        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
////            return emojis[pairIndex]
////        }
//    }
}

