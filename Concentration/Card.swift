//
//  Card.swift
//  Lecture 2 - Concentration
//
//  Created by aisulubekbossynova on 5/29/19.
//  Copyright © 2019 Aisulu Bekbossynova. All rights reserved.
//

import Foundation

struct Card {
	
	
	var isFaceUp = false
	var isMatched = false
	var identifier: Int
	
	static var identifierFactory = 0
	
	static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return identifierFactory
	}
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
	}
}
