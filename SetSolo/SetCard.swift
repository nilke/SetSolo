//
//  SoloCard.swift
//  SetSolo
//
//  Created by Nils on 2019-02-10.
//  Copyright © 2019 Nils. All rights reserved.
//

import Foundation

struct SetCard: Hashable, Equatable{
    
    private static var identifierFactory = 0
    
    var hashValue: Int {
        SetCard.identifierFactory += 1
        return SetCard.identifierFactory}
    
    static func == (lhs: SetCard, rhs: SetCard) -> Bool {
        if lhs.color == rhs.color && lhs.symbol == rhs.symbol && lhs.number == rhs.number && lhs.shading == rhs.shading {
            return true
        } else {
            return false
        }
    }
    
    
    let color: cardColor
    let symbol: cardSymbol
    let number: cardNumber
    let shading: cardShading
    var attributes : [Int] {
        return [color.rawValue, symbol.rawValue, number.rawValue, shading.rawValue]
    }
    
    
    
    enum cardColor: Int{
        case Color1 = 1
        case Color2
        case Color3
        
        static var all = [Color1, Color2, Color3]
    }
    enum cardSymbol: Int {
        case Symbol1 = 1
        case Symbol2
        case Symbol3
        
        static var all = [Symbol1, Symbol2, Symbol3]
    }
    enum cardNumber: Int{
        case Number1 = 1
        case Number2
        case Number3
        
        static var all = [Number1, Number2, Number3]
    }
    enum cardShading: Int{
        case Shading1 = 1
        case Shading2
        case Shading3
        
        static var all = [Shading1, Shading2, Shading3]
    }
    
}



