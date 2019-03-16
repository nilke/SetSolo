//
//  SetCardView.swift
//  SetSolo
//
//  Created by Nils on 2019-03-15.
//  Copyright © 2019 Nils. All rights reserved.
//

import UIKit

@IBDesignable

class SetCardView: UIView {

    var color = "Red"
    
    var shape = "Squiggle"
    
    var numberOfShapes = "two"
    
    var shading = "Striped"
    
    
    override func draw(_ rect: CGRect){
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
//        print(rankString+suit)
//        if isFaceUp{
//            if let faceCardImage = UIImage(named: rankString+suit, in: Bundle(for: self.classForCoder), compatibleWith: traitCollection){
//                faceCardImage.draw(in: bounds.zoom(by: faceCardScale))
//            } else {
//                drawPips()
//            }
//        } else {
//            if let cardBackImage = UIImage(named: "cardback", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection){
//                cardBackImage.draw(in: bounds)
//            }
//        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension SetCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    

    
}
