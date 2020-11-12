import UIKit

// UIViewController knows everything about what's happening in Main.storuboard
// class ClassName: SuperClass { ...
class ViewController: UIViewController {
    
    private lazy var game: Concetration = Concetration(numberOfPairsOfCards: numberOfPairsOfCards )
    
    var numberOfPairsOfCards: Int {
        // get { // u can do not add get if it's read only variable
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 { // Property Observer
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 0.5,
            .strokeColor : #colorLiteral(red: 0.7566379905, green: 0.7112870216, blue: 1, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet { // when it did set by ios
            updateFlipCountLabel()
        }
    }
    
    // all args must have names. (argument: type)
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        // u can use `!` instead of `if`
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        game = Concetration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
        flipCount = 0
        emojiChoices = "🧜‍♀️🎋🦢🦚🍇🩰🎠🧸🎏🎐"
    }
    
    private func updateViewFromModel() {
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
    
    private var emojiChoices = "🧜‍♀️🎋🦢🦚🍇🩰🎠🧸🎏🎐"
    
    private var emoji = [Card:String]() // or Dictionary<Int,String>()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random) // i use here my extension
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?" // if it's not nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}
