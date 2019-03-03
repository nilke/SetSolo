//
//  SetGame.swift
//  SetSolo
//
//  Created by Nils on 2019-02-10.
//  Copyright © 2019 Nils. All rights reserved.
//

import Foundation


// List of cards that are being played
// The seleceted cards
// WHether the selected cards are a match
// A deck of cards from which it is dealing
// Probably Keep track of the cards that have alreadu been matched



// Add closure

struct SetGame {
    private var deck = SetDeck()
    var cardsInDeck: Int {
        get{
            return deck.cards.count
        }
    }
    var score = 0
    var deckEmpty = false
    var boardFull = false
    private var match = false
    var cardsOnBoard = [SetCard?]()
    var selectedCards = [SetCard]()
    private var matchedCards = [SetCard]()
    private let startingDeck = 12
    
    init() {
        //Create an initial "Board", 12 cards and 12 empty cards
        for _ in 1...startingDeck{
            cardsOnBoard.append(deck.cards.remove(at: 0))
        }
        for _ in 1...24-startingDeck {
            cardsOnBoard.append(nil)
        }
    }
    
    public mutating func selectCard(card: SetCard){
        
        if selectedCards.count < 2 {
            if alreadySelected(card: card){
                return
            } else {
                selectedCards.append(card)
            }
        }
        else if selectedCards.count == 2 {
            if alreadySelected(card: card){
                return
            } else {
                selectedCards.append(card)
                match = isMatch()
            }
        } else if selectedCards.count == 3 {
            if match {
                removeMatchedCards()
            }
            // Controlls for the case that the user has three cards selected and then selects one of the already selected cards
            if selectedCards.contains(card){
                selectedCards = []
            } else{
                selectedCards = []
                selectCard(card: card) // recursion, also mark a new card if selected car not in selected cards
            }
        }
    }
    
    private mutating func alreadySelected(card: SetCard)->Bool{
        
        if let indexOfAlreadySelectedCard = selectedCards.index(of: card){
            selectedCards.remove(at: indexOfAlreadySelectedCard)
            return true
        } else {
            return false
        }
    }
    
    public mutating func dealThreeCards() {
        if selectedCards.count == 3 && match {
            removeMatchedCards()
        }
        
        let threerange = 1...3
        for _ in threerange {
            for index in cardsOnBoard.indices{
                if cardsOnBoard[index] == nil && !deckEmpty{
                    cardsOnBoard[index] = deck.cards.remove(at: 0)
                    break
                }
            }
            if deck.cards.count == 0 {
                deckEmpty = true
            } else if !cardsOnBoard.contains(nil){
                boardFull = true
            }
        }
    }
    
    private mutating func removeMatchedCards(){
        for index in selectedCards.indices{
            if let matchedCardIndex = cardsOnBoard.index(of: selectedCards[index]){
                matchedCards.append(cardsOnBoard[matchedCardIndex]!)
                cardsOnBoard[matchedCardIndex] = nil
            }
        }
        if cardsOnBoard.contains(nil){
            boardFull = false
        }
    }
    
    private mutating func isMatch() -> Bool {
        
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
            boardFull = false
            score += 3
            return true
        } else {
            score -= 3
            return false
        }
    }
}
