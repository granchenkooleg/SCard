//
//  MemoryGame.swift
//  Memorize
//
//  Created by CS193P Instructor on 04/06/2020.
//  Copyright © 2020 cs193p instructor. All rights reserved.
//

import Foundation

struct MemoryGame <CardContent> where CardContent: Equatable {
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

    var cards : Array<Card>
    
//    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
//        get {cards.indices.filter { cards[$0].isFaceUp}.only}
//        set {
//            for index in cards.indices {
//                cards[index].isFaceUp = index == newValue
//            }
//        }
//    }
    
    mutating func choose(card:Card) {
        if let chosenIndex = cards.firstIndex(matching: card) {
            self.cards[chosenIndex].isFaceUp.toggle()
        }

        //        if let chosenIndex = cards.firstIndex(matching: card),
        //                                 !cards[chosenIndex].isFaceUp,
        //                                 !cards[chosenIndex].isMatched {
        //            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
        //                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
        //                    cards[chosenIndex].isMatched = true
        //                    cards[potentialMatchIndex].isMatched = true
        //                }
        //               self.cards[chosenIndex].isFaceUp = true
        //            } else {
        //                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        //            }
        //        }
    }
    
    init (numberOfPairsOfCards: Int,cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
//            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
         cards.shuffle ()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
//        {
//            didSet{
//                if isFaceUp {
////                    startUsingBonusTime()
//                }else {
////                    stopUsingBonusTime()
//                }
//            }
//        }
        var isMatched: Bool = false{
            didSet{
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        
        // MARK: - Bonus Time
               
               // this could give matching bonus points
               // if the user matches the card
               // before a certain amount of time passes during which the card is face up
               // can be zero which means "no bonus points" for this card
               var bonusTimeLimit: TimeInterval = 6

               // how long this card has ever face up
               private var faceUptime: TimeInterval {
                   if let lastFaceUpDate = lastFaceUpDate {
                       return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
                   } else {
                       return pastFaceUpTime
                   }
               }

               // the last time this card was turned face up (and is still face up)
               var lastFaceUpDate: Date?
               // the accumulated time this card has been face up in the past
               // (i.e. not including the current time it's been face up if it is currently so)
               var pastFaceUpTime: TimeInterval = 0

               // how much time left before the bonus opportunity runs out
               var bonusTimeRemaining: TimeInterval {
                   max(0, bonusTimeLimit - pastFaceUpTime)
               }

               // percentage of the bonus time remaining
               var bonusRemaining: Double {
                   (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
               }

               // whether the card was matched during the bonus time period
               var hasEarnedBonus: Bool {
                   isMatched && bonusTimeRemaining > 0
               }

               // whether we are currently face up, unmatched and
               // have not yet used up the bonus window
//               var isConsumingBonusTime: Bool {
//                   isFaceUp && !isMatched && bonusTimeRemaining > 0
//               }

               // called when the card transitions to face up state
//               private mutating func startUsingBonusTime() {
//                   if isConsumingBonusTime, lastFaceUpDate == nil {
//                       lastFaceUpDate = Date()
//                   }
//               }

               // called when the card goes back face down (or gets matched)
               private mutating func stopUsingBonusTime() {
                   pastFaceUpTime = faceUptime
                   lastFaceUpDate = nil
               }
    }
    
}
