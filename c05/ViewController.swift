import UIKit

// UIViewController knows everything about what's happening in Main.storuboard
// class ClassName: SuperClass { ...
class ViewController: UIViewController {
    
    lazy var game: Concetration = Concetration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 { // Property Observer
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    // all args must have names. (argument: type)
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        // u can use `!` instead of `if`
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = Concetration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
        flipCount = 0
        emojiChoices = ["🧜‍♀️", "🎋", "🦢", "🦚", "🍇", "🩰", "🎠", "🧸", "🎏", "🎐"]
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices { // i have two interpretations of Card
            let button = cardButtons[index] // it's in UI
            let card = game.cards[index] // it's is only in Model
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMathced ? #colorLiteral(red: 0.7566379905, green: 0.7112870216, blue: 1, alpha: 0) : #colorLiteral(red: 0.7566379905, green: 0.7112870216, blue: 1, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🧜‍♀️", "🎋", "🦢", "🦚", "🍇", "🩰", "🎠", "🧸", "🎏", "🎐"]
    
    var emoji = [Int:String]() // or Dictionary<Int,String>()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?" // if it's not nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

