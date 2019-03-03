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
        let threerange = 1...3
        for color in threerange{
            for symbol in threerange{
                for number in threerange{
                    for shading in threerange{
                        unshuffledCards.append(SetCard(c: color,s: symbol,n: number,sh: shading))
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
