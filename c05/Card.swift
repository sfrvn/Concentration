import Foundation

struct Card: Hashable // without using this protocol we can not to compare to cards
{
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
        
    var isFaceUp = false
    var isMathced = false
    private var identifier: Int
    
    private static var myIdentifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        myIdentifierFactory += 1
        return myIdentifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    // card has no emoji <- is UI-independent!
}
