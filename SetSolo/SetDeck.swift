//
//  DeckOfSoloCards.swift
//  SetSolo
//
//  Created by Nils on 2019-02-10.
//  Copyright © 2019 Nils. All rights reserved.
//

import Foundation

struct SetDeck {
    
    private var unshuffledCards = [SetCard]()
    var cards = [SetCard]()
    
    private mutating func createDeck(){
        for color in SetCard.cardColor.all{
            for symbol in SetCard.cardSymbol.all{
                for number in SetCard.cardNumber.all{
                    for shading in SetCard.cardShading.all{
                        unshuffledCards.append(SetCard(color: color, symbol: symbol, number: number, shading: shading))
                    }
                }
            }
        }
    }
    
    private mutating func shuffleDeck(){
        for _ in unshuffledCards.indices{
            let randomindex = Int(arc4random_uniform(UInt32(unshuffledCards.count)))
            cards.append(unshuffledCards.remove(at: randomindex))
        }
    }
    
    init() {
        createDeck()
        shuffleDeck()
    }
}
