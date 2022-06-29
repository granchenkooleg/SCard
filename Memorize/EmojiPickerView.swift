//
//  EmojiPickerView.swift
//  EmojiArt

import SwiftUI
import Combine

enum FavoriteChose: String, CaseIterable, Identifiable {
    case Animals
    case Food
    case Sport
    case Flags
//        case Travel
    case Faces

    var id: FavoriteChose { self }
}

struct EmojiPickerView: View {
    var viewModel: EmojiMemoryGame
    @State private var selectedElement = FavoriteChose.Faces

        var body: some View {
            VStack {
                Picker("Favorite Chose", selection: $selectedElement, content: {
                    ForEach(FavoriteChose.allCases, content: { element in
                        Text(element.rawValue.capitalized)
                    }).onChange(of: selectedElement) { newValue in
//                        viewModel.clearAll()
//                        EmojiMemoryGame.createMemoryGame(key: selectedElement.rawValue)
                    }
                })
            }

        }

//    @ObservedObject var document: EmojiArtDocument
    
//    @State private var chosenPalette: String = ""
//
//    var body: some View {
////        VStack {
////            HStack {
//////                PaletteChooser(document: document, chosenPalette: $chosenPalette)
//////                ScrollView(.horizontal) {
//////                    HStack {
//////                        ForEach(chosenPalette.map { String($0) }, id: \.self) { emoji in
//////                            Text(emoji)
//////                                .font(Font.system(size: self.defaultEmojiSize))
//////                                .onDrag { NSItemProvider(object: emoji as NSString) }
//////                        }
//////                    }
//////                }
//////                .onAppear { self.chosenPalette = self.document.defaultPalette }
////            }
////        }
//    }
}

