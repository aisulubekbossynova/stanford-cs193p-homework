//
//  Concentration.swift
//  Lecture 2 - Concentration
//
//  Created by aisulubekbossynova on 5/29/19.
//  Copyright © 2019 Aisulu Bekbossynova. All rights reserved.
//

import Foundation

class Concentration {
	
	var cards = [Card]()
    var shuff = [Card]()
	var indexOfOneAndOnlyFaceUpCard: Int?
	var score = 0
	func chooseCard(at index: Int) {
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				// check if cards match
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
                    score += 2
					cards[index].isMatched = true
				}
                else{
                    score -= 1
                }
				cards[index].isFaceUp = true
				indexOfOneAndOnlyFaceUpCard = nil	// not one and only ...
			} else {
				// either no card or two cards face up
				for flipdownIndex in cards.indices {
					cards[flipdownIndex].isFaceUp = false
				}
				cards[index].isFaceUp = true
				indexOfOneAndOnlyFaceUpCard = index
			}
			
		}
	}
	
	init(numberOfPairsOfCards: Int) {
		for _ in 1...numberOfPairsOfCards {
			let card = Card()
			shuff += [card, card]
		}
        while !shuff.isEmpty{
            let indexForShuffle = shuff.count.arc4Random
            let cardi = shuff.remove(at: indexForShuffle)
            cards += [cardi]
        }
	}
	
}
