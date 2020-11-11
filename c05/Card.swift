import Foundation

struct Card
{
    var isFaceUp = false
    var isMathced = false
    var identifier: Int
    
    static var myIdentifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        myIdentifierFactory += 1
        return myIdentifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    // card has no emoji <- is UI-independent!
}
