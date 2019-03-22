//
//  SetCardView.swift
//  SetSolo
//
//  Created by Nils on 2019-03-15.
//  Copyright © 2019 Nils. All rights reserved.
//

// TODO Step1: Create only bounds based constants that are containted in extension and struct
// TODO Step 2: Create Symbol class that draws and change this class to laying out three parts of each card that are "Draw areas" depending on number of objects

import UIKit

@IBDesignable

class SetCardView: UIView {
    
    var color = "Red"
    
    var shape = "Diamond"
    
    var numberOfShapes = 3
    
    var shading = "Squiggle"
    
    
    
    var pathToDraw : UIBezierPath {
        switch numberOfShapes {
        case 1 : return layoutForOneCard()
        case 2 : return layoutForTwoCards()
        case 3 : return layoutForThreeCards()
        default : return drawDefault()
        }
    }
    
    func layoutForOneCard() -> UIBezierPath{
        
        
    }
    
    func layoutForTwoCards() -> UIBezierPath{
        
        
        func layoutForThreeCards() -> UIBezierPath{
        }
        
        func drawDefault() -> UIBezierPath{
            
        }
        
        override func layoutSubviews(){
            super .layoutSubviews()
            
            
        }
}

//extension SetCardView {
//    private struct SizeRatio {
//        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
//        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
//        static let cornerOffsetToCornerRadius: CGFloat = 0.33
//        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
//    }
//
//    private var cornerRadius: CGFloat {
//        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
//    }
//
//    private var cornerOffset: CGFloat {
//        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
//    }
//
//    private var cornerFontSize: CGFloat {
//        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
//    }
//
//
//
//}
