//
//  cardViewData.swift
//  SetSolo
//
//  Created by Nils on 2019-03-27.
//  Copyright © 2019 Nils. All rights reserved.
//

import Foundation

class cardViewData{
    
    let color : Int
    
    let shape : Int
    
    let numberOfShapes : Int
    
    let shading : Int
    
    init(color c : Int, shape s :Int, numberOfShapes nOS: Int, shading sH : Int) {
        color = c
        shape = s
        numberOfShapes = nOS
        shading = sH
    }
}
