import Foundation // it's a Model file

// essentials of what is it that this thing does
// and how are people going to use it
class Concetration
{
    var cards = [Card]() // no need to import (or `Array<Card>()`)
    
    func chooseCard(at index: Int) {
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        print(cards)
        
        // TODO: Shuffle cards
    }
    
}
