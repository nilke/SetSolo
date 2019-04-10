//
//  SymbolOnCard.swift
//  SetSolo
//
//  Created by Nils on 2019-03-22.
//  Copyright © 2019 Nils. All rights reserved.
//

import UIKit

@IBDesignable

class SymbolView: UIView {
    
    var color = 0 {didSet {setNeedsDisplay(); setNeedsLayout()}}
    
    var shape = 0 {didSet {setNeedsDisplay(); setNeedsLayout()}}
    
    var shading = 0 {didSet {setNeedsDisplay(); setNeedsLayout()}}
    

    private var pathToDraw : UIBezierPath {
        switch shape {
        case 1 : return drawSquiggle()
        case 2 : return drawRounded()
        case 3 : return drawDiamond()
        default : return drawDefault()
        }
    }
    
    private var symbolColor : UIColor {
        switch color {
        case 1 : return UIColor.red
        case 2 : return UIColor.blue
        case 3 : return UIColor.green
        default : return UIColor.black
        }
    }
    
    private func drawSquiggle() -> UIBezierPath{
        
        let middleY : CGFloat = bounds.height / 2
        let startX : CGFloat = 0
        let endX : CGFloat = bounds.width
        let heighoffset : CGFloat = bounds.height / 3
        let firstCntrlX : CGFloat = (endX - startX) / 3
        let secondCntrlX : CGFloat = (endX - startX) / 3 * 2
        let firstCntrlY : CGFloat =  (heighoffset * 4)
        let secondCntrlY : CGFloat = (heighoffset * 1)
        
        let squigglePath = UIBezierPath()
        
        squigglePath.move(to: CGPoint(x: startX, y: middleY + heighoffset))
        
        squigglePath.addCurve(
            to: CGPoint(x: endX, y: middleY - heighoffset),
            controlPoint1: CGPoint(x: startX + firstCntrlX ,y: middleY - firstCntrlY ),
            controlPoint2: CGPoint(x: startX + secondCntrlX ,y: middleY + secondCntrlY)
        )
        
        squigglePath.addCurve(
            to: CGPoint(x: startX, y: middleY + heighoffset),
            controlPoint1: CGPoint(x: startX + secondCntrlX ,y: middleY + firstCntrlY ),
            controlPoint2: CGPoint(x: startX + firstCntrlX ,y: middleY - secondCntrlY)
        )
        squigglePath.close()
        squigglePath.lineWidth = linewidth // Needs to be here since path is calculated and otherwise returned to default 1.0 when stroked
        squigglePath.addClip()
        
        return squigglePath
        
    }
    
    private func drawRounded() -> UIBezierPath{
        let roundPath = UIBezierPath()
        roundPath.move(to: CGPoint(x: 0 + bounds.height/2,y: 0))
        
        roundPath.addArc(
            withCenter: CGPoint(x: bounds.width - (bounds.height / 2), y: bounds.height/2),
            radius: bounds.height/2,
            startAngle: CGFloat.pi * 3/2 ,
            endAngle: CGFloat.pi / 2,
            clockwise: true
        )
        roundPath.addArc(
            withCenter: CGPoint(x: 0 + bounds.height/2, y: bounds.height/2),
            radius: bounds.height/2,
            startAngle: CGFloat.pi/2 ,
            endAngle: CGFloat.pi * 3/2,
            clockwise: true
        )
        roundPath.close()
        roundPath.lineWidth = linewidth // Needs to be here since path is calculated and otherwise returned to default 1.0 when stroked

        roundPath.addClip()
        return roundPath    }
    
    private func drawDiamond() -> UIBezierPath{
        let diamondPath = UIBezierPath()
        
        diamondPath.move(
            to: CGPoint(x: 0,y: bounds.height/2)
        )
        diamondPath.addLine(
            to: CGPoint(x: bounds.width/2, y:0)
        )
        diamondPath.addLine(
            to: CGPoint(x: bounds.width, y:bounds.height/2)
        )
        diamondPath.addLine(
            to: CGPoint(x: bounds.width/2, y:bounds.height)
        )
        
        diamondPath.close()
        diamondPath.lineWidth = linewidth // Needs to be here since path is calculated and otherwise returned to default 1.0 when stroked
        diamondPath.addClip()
        return diamondPath
        
    }
    
    private func drawDefault() -> UIBezierPath{
         let whiteBlock = UIBezierPath()

        return whiteBlock
    }
    
    private func stripe(){
        let stripes = UIBezierPath()
        
        for stripenumber in 0..<8{
            stripes.move(
                to: CGPoint(x: CGFloat(stripenumber) * bounds.width / 8,y: 0)
            )
            stripes.addLine(
                to: CGPoint(x: CGFloat(stripenumber) * bounds.width / 8, y:bounds.height)
            )
        }
        stripes.lineWidth = linewidth
        stripes.stroke()
    }
    
    private func setShade(){
        switch shading {
        case 1:
            pathToDraw.fill()
        case 2:
            pathToDraw.stroke()
        case 3:
            stripe()
            pathToDraw.stroke()
        default:
            pathToDraw.stroke()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    override func draw(_ rect: CGRect){
        self.contentMode = .redraw
        symbolColor.setStroke()
        symbolColor.setFill()
        //pathToDraw.stroke()
        setShade()
    }
}

extension SymbolView{
    private struct Sizeratios{
        static let lineToWidthRatio : CGFloat = 0.04
    }
    
    private var linewidth : CGFloat {
        return bounds.width * Sizeratios.lineToWidthRatio
    }
}

