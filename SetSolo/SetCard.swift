//
//  SoloCard.swift
//  SetSolo
//
//  Created by Nils on 2019-02-10.
//  Copyright © 2019 Nils. All rights reserved.
//

import Foundation

struct SetCard: Hashable, Equatable{
    
    let color: cardColor
    let symbol: cardSymbol
    let number: cardNumber
    let shading: cardShading
    let attributes: [Int]
    
    
    
    init (c: Int, s: Int, n: Int, sh: Int ){
        self.color = cardColor(rawValue: c)!
        self.symbol = cardSymbol(rawValue: s)!
        self.number = cardNumber(rawValue: n)!
        self.shading = cardShading(rawValue: sh)!
        self.attributes = [c, s, n, sh]
    }
}

enum cardColor: Int{
    case Color1 = 1
    case Color2
    case Color3
}
enum cardSymbol: Int {
    case Symbol1 = 1
    case Symbol2
    case Symbol3
}
enum cardNumber: Int{
    case Number1 = 1
    case Number2
    case Number3
}
enum cardShading: Int{
    case Shading1 = 1
    case Shading2
    case Shading3
}

