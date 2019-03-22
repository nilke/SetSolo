//
//  SymbolOnCard.swift
//  SetSolo
//
//  Created by Nils on 2019-03-22.
//  Copyright © 2019 Nils. All rights reserved.
//

import UIKit

@IBDesignable

class SymbolOnCard: UIView {
    
    var color = "Red"
    
    var shape = "Diamond"
    
    var numberOfShapes = "two"
    
    var shading = "Squiggle"
    
    
    
    var pathToDraw : UIBezierPath {
        switch shape {
        case "Squiggle" : return drawSquiggle()
        case "Rounded" : return drawRounded()
        case "Diamond" : return drawDiamond()
        default : return drawDefault()
        }
    }
    
    func drawSquiggle() -> UIBezierPath{
        
        let middleY : CGFloat = bounds.height / 2
        let startX : CGFloat = 25
        let endX : CGFloat = 325
        let heighoffset : CGFloat = 50
        let firstCntrlX : CGFloat = (endX - startX) / 3
        let secondCntrlX : CGFloat = (endX - startX) / 3 * 2
        let firstCntrlY : CGFloat =  (heighoffset * 4)
        let secondCntrlY : CGFloat = (heighoffset * 1)
        
        let roundPath = UIBezierPath()
        
        roundPath.move(to: CGPoint(x: startX, y: middleY + heighoffset))
        
        roundPath.addCurve(
            to: CGPoint(x: endX, y: middleY - heighoffset),
            controlPoint1: CGPoint(x: startX + firstCntrlX ,y: middleY - firstCntrlY ),
            controlPoint2: CGPoint(x: startX + secondCntrlX ,y: middleY + secondCntrlY)
        )
        
        roundPath.addCurve(
            to: CGPoint(x: startX, y: middleY + heighoffset),
            controlPoint1: CGPoint(x: startX + secondCntrlX ,y: middleY + firstCntrlY ),
            controlPoint2: CGPoint(x: startX + firstCntrlX ,y: middleY - secondCntrlY)
        )
        
        return roundPath
        
    }
    
    func drawRounded() -> UIBezierPath{
        let roundPath = UIBezierPath()
        roundPath.move(to: CGPoint(x: 0.24*bounds.width,y: bounds.height/2 * 8/10))
        roundPath.addArc(
            withCenter: CGPoint(x: bounds.width - 0.24*bounds.width, y: bounds.height/2),
            radius: bounds.height/10,
            startAngle: CGFloat.pi * 3/2 ,
            endAngle: CGFloat.pi / 2,
            clockwise: true
        )
        roundPath.addArc(
            withCenter: CGPoint(x: 0.24*bounds.width, y: bounds.height/2),
            radius: bounds.height/10,
            startAngle: CGFloat.pi/2 ,
            endAngle: CGFloat.pi * 3/2,
            clockwise: true
        )
        roundPath.close()
        
        return roundPath    }
    
    func drawDiamond() -> UIBezierPath{
        let roundPath = UIBezierPath()
        
        roundPath.move(
            to: CGPoint(x: 0.15*bounds.width,y: bounds.height/2)
        )
        roundPath.addLine(
            to: CGPoint(x: bounds.width/2, y:bounds.height/2 * 8/10)
        )
        roundPath.addLine(
            to: CGPoint(x: 0.85*bounds.width, y:bounds.height/2)
        )
        roundPath.addLine(
            to: CGPoint(x: bounds.width/2, y:bounds.height/2 * 12/10)
        )
        
        roundPath.close()
        
        return roundPath    }
    
    func drawDefault() -> UIBezierPath{
        let roundPath = UIBezierPath()
        return roundPath
    }
    
    override func draw(_ rect: CGRect){
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        // self.isOpaque = true
        roundedRect.fill()
        
        UIColor.green.setFill()
        UIColor.red.setStroke()
        pathToDraw.lineWidth = 1.0
        //pathToDraw.fill()
        pathToDraw.stroke()
        
        
    }
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
