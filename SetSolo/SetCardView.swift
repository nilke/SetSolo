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
    
    var color = 1 {didSet{setNeedsDisplay()}}
    var shape = 1 {didSet{setNeedsDisplay()}}
    var numberOfShapes = 1 {didSet{setNeedsDisplay()}}
    var shading = 1 {didSet{setNeedsDisplay()}}
    
    private var symbolPattern : [Int]  {
        switch numberOfShapes{
        case 1 : return [0,0,0,1,0,0,0]
        case 2 : return [0,0,1,0,1,0,0]
        case 3 : return [0,1,0,1,0,1,0]
        default : return [0,0,0,0,0,0,0]
        }
    }
    
    override func layoutSubviews(){
        super .layoutSubviews()
        self.contentMode = .redraw
        for sections in 0..<symbolPattern.count{
            if symbolPattern[sections] == 1 {
                let fillView = SymbolView(frame:
                    CGRect(origin:
                        CGPoint(x: cardSectionOriginX,
                                y: cardSectionsHeight * CGFloat(sections)),
                           size: cardSectionSize))

                fillView.shape = shape
                fillView.color = color
                fillView.shading = shading
                fillView.isOpaque = false
                addSubview(fillView)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.contentMode = .redraw
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
    
    enum StateOfSetCardView {
        case unselected
        case selected
        case hinted
        case selectedAndMatched
    }
    
    var stateOfSetCardView: StateOfSetCardView = .unselected {
        didSet {
            switch stateOfSetCardView {
            case .unselected:
                layer.borderWidth = LayOutMetricsForCardView.borderWidth
                layer.borderColor = LayOutMetricsForCardView.borderColor
            case .selected:
                layer.borderWidth = LayOutMetricsForCardView.borderWidthIfSelected
                layer.borderColor = LayOutMetricsForCardView.borderColorIfSelected
            case .selectedAndMatched:
                layer.borderWidth = LayOutMetricsForCardView.borderWidthIfMatched
                layer.borderColor = LayOutMetricsForCardView.borderColorIfMatched
            case .hinted:
                layer.borderWidth = LayOutMetricsForCardView.borderWidthIfHinted
                layer.borderColor = LayOutMetricsForCardView.borderColorIfHinted
            }
        }
    }
}



// Understand why constants are created this way

extension SetCardView {
    
    private struct LayOutMetricsForCardView {
        static var borderWidth: CGFloat = 0.0
        static var borderWidthIfSelected: CGFloat = 4.0
        static var borderColorIfSelected: CGColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1).cgColor
        
        static var borderWidthIfHinted: CGFloat = 4.0
        static var borderColorIfHinted: CGColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1).cgColor
        
        static var borderWidthIfMatched: CGFloat = 4.0
        static var borderColorIfMatched: CGColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor
        
        static var borderColor: CGColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        static var borderColorForDrawButton: CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        static var borderWidthForDrawButton: CGFloat = 3.0
        static var cornerRadius: CGFloat = 8.0
    }
    
    
    private struct SizeRatio {
        static let cardSections : CGFloat = 7
        static let cardSectionsInt : Int = Int(SizeRatio.cardSections)
        static let shareOfWidthToDrawOn : CGFloat = 0.70
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    private var cardSectionsHeight: CGFloat {
        return bounds.size.height / SizeRatio.cardSections
    }
    
    private var cardSectionsWidth: CGFloat {
        return bounds.size.width * SizeRatio.shareOfWidthToDrawOn
    }
    
    private var cardSectionOriginX: CGFloat{
        return bounds.size.width * ((1 - SizeRatio.shareOfWidthToDrawOn ) / 2) // At 90 % draw area function return 5% as a padding on one side
    }
    
    private var cardSectionSize : CGSize {
        return CGSize(width: cardSectionsWidth, height: cardSectionsHeight)
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
