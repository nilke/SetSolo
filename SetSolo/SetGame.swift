//
//  SetGame.swift
//  SetSolo
//
//  Created by Nils on 2019-02-10.
//  Copyright © 2019 Nils. All rights reserved.
//

import Foundation


struct SetGame {
    private var deck = SetDeck()
    var cardsInDeck: Int {
        get {
            return deck.cards.count
        }
    }
    var score = 0
    
    var deckEmpty : Bool  {
        if deck.cards.count == 0 {
            return true
        } else {
            return false
        }
    }
    var boardFull = false
    private var match = false
    var cardsOnBoard = [SetCard]()
    private var matchedCards = [SetCard]()
    
    private let startingDeck = 12
    private let newCards = 3
    
    init() {
        for _ in 1...startingDeck{
            cardsOnBoard.append(deck.cards.remove(at: 0))
        }
        
    }
    
    
    public mutating func dealThreeCards() {
        for _ in 1...newCards{
            cardsOnBoard.append(deck.cards.remove(at: 0))
        }
    }
    
    mutating func ifSetThenRemoveFromTable(cards: [SetCard]) -> Bool {
        guard isMatch(selectedCards: cards) else {
            score -= 3
            return false }
        for card in cards {
            if let index = cardsOnBoard.index(of: card) {
                let cardFromBoard = cardsOnBoard.remove(at: index)
                matchedCards.append(cardFromBoard)
            }
        }
        score += 3
        
        return true
    }
    
    mutating func isMatch(selectedCards : [SetCard]) -> Bool {
        
        let card1 = selectedCards[0]
        let card2 = selectedCards[1]
        let card3 = selectedCards[2]
        var matches = [Int]()
        
        for index in 0...3 {
            if card1.attributes[index] == card2.attributes[index] && card2.attributes[index] == card3.attributes[index]{
                matches.append(1)
            } else if card1.attributes[index] != card2.attributes[index] && card2.attributes[index] != card3.attributes[index] {
                matches.append(1)
            } else {
                matches.append(0)
            }
        }
        if matches[0] == 1 && matches[1] == 1 && matches[2]==1 && matches[3]==1 {
            return true
        } else {
            return false
        }
    }
}
