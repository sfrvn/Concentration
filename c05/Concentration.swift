import Foundation // it's a Model file

// essentials of what is it that this thing does
// and how are people going to use it
class Concetration
{
    var cards = [Card]() // no need to import (or `Array<Card>()`)
    
    var indexOfOneAndOnlyFaceUpCard: Int? // optional because it can be more than one face up card
    
    func chooseCard(at index: Int) {
        if !cards[index].isMathced {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMathced = true
                    cards[index].isMathced = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else { // either 2 cards (or no cards) are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
}
