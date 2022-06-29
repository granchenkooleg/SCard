//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 4/27/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import SwiftUI
import Combine

class EmojiArtDocument: ObservableObject
{
    static let palette: String = "⭐️⛈🍎🌏🥨⚾️"
    
    @Published private var emojiArt: EmojiArt
    
    private static let untitled = "EmojiArtDocument.Untitled"
    
    private var autosaveCancellable: AnyCancellable?
    
    init() {
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocument.untitled)) ?? EmojiArt()
        autosaveCancellable = $emojiArt.sink { emojiArt in
            UserDefaults.standard.set(emojiArt.json, forKey: EmojiArtDocument.untitled)
        }
        fetchBackgroundImageData()
    }
        
}
