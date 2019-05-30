//  ViewController.swift
//  Concentration
//
//  Created by aisulubekbossynova on 5/29/19.
//  Copyright © 2019 Aisulu Bekbossynova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
    var game: Concentration!
	
	var flipCount = 0 {
		didSet {
			flipCountLabel.text = "Flips: \(flipCount)"
		}
        
	}
 
    @IBOutlet weak var scoreCounterLabel: UILabel!
    typealias themes = (emoji: [String], backGroundColor: UIColor, cardBackColor: UIColor)
    var themeList: [themes] = [
        (["👩", "👮🏻‍♂️", "👩‍💻", "👨🏾‍🌾", "🧟‍♀️", "👩🏽‍🎨", "👩🏼‍🍳", "🧕🏼", "💆‍♂️", "🤷🏽‍♂️"], #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)),
        (["🐶", "🙊", "🐧", "🦁", "🐆", "🐄", "🐿", "🐠", "🦆", "🦉"], #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
        (["😀", "🤪", "😬", "😭", "😎", "😍", "🤠", "😇", "🤩", "🤢"], #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)),
        (["🍏", "🥑", "🍇", "🍒", "🍑", "🥝", "🍐", "🍎", "🍉", "🍌"], #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),
        (["🚗", "🚓", "🚚", "🏍", "✈️", "🚜", "🚎", "🚲", "🚂", "🛴"], #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
        (["🏊🏽‍♀️", "🤽🏻‍♀️", "🤾🏾‍♂️", "⛹🏼‍♂️", "🏄🏻‍♀️", "🚴🏻‍♀️", "🚣🏿‍♀️", "⛷", "🏋🏿‍♀️", "🤸🏼‍♂️"], #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)),
        (["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🥳"], #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) ),
        ]
    
    
    @IBAction func startNewGame(_ sender: UIButton) {
        startGame()
    }
    private var newTheme: themes {
        let randomIndex = themeList.count.arc4Random
        return themeList[randomIndex]
    }
    private var nowTheme: themes! {
        didSet{
            view.backgroundColor = nowTheme.backGroundColor
            for button in cardButtons{
                button.backgroundColor = nowTheme.cardBackColor
            }
            emojiChoices = nowTheme.emoji
        }
    }
    func startGame(){
        nowTheme = newTheme
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCount = 0
        emoji = [:]
    }
    @IBOutlet weak var flipCountLabel: UILabel!
	
	@IBOutlet var cardButtons: [UIButton]!
	
    override func viewDidLoad() {
        startGame()
    }
	@IBAction func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.firstIndex(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
            scoreCounterLabel.text = "Score: \(game.score)"
		} else {
			print("choosen card was not in cardButtons")
		}
	}
	
	func updateViewFromModel() {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControl.State.normal)
				button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			} else {
				button.setTitle("", for: UIControl.State.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : nowTheme.cardBackColor
//                if card.isMatched {
//                    scoreCount+=2
//                }
//                else{
//                    scoreCount-=1
//
//                }

			}
		}
		
	}
	
	var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
	
	var emoji = [Int: String]()
	
	func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
			emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
		}
		return emoji[card.identifier] ?? "?"
	}
}
extension Int {
    var arc4Random: Int {
        switch self {
        case 1...Int.max:
            return Int(arc4random_uniform(UInt32(self)))
        case -Int.max..<0:
            return Int(arc4random_uniform(UInt32(self)))
        default:
            return 0
        }
    }
}














