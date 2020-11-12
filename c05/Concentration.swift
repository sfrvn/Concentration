import Foundation // it's a Model file

// essentials of what is it that this thing does
// and how are people going to use it
struct Concetration
{
    private(set) var cards = [Card]() // no need to import (or `Array<Card>()`)
    // can't be private -> UI lose access to cards
    
    private var indexOfOneAndOnlyFaceUpCard: Int? { // optional because it can be more than one face up card
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly // closure + extension
        }
        set { // set(newValue: whatever)
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
                
        }
    }
    
    mutating func chooseCard(at index: Int) { // mutable because i use struct
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMathced {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMathced = true
                    cards[index].isMathced = true
                }
                cards[index].isFaceUp = true
            } else { // either 2 cards (or no cards) are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(String(describing: index)): u must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
