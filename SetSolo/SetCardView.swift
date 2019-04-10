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
    
    var cardData = cardViewData(
        color: 1,
        shape: 1,
        numberOfShapes: 2,
        shading: 1)  {didSet
        {setNeedsDisplay()}}
    
    private func symbolSetter(view: SymbolView)->SymbolView{
        view.shape = cardData.shape
        view.color = cardData.color
        view.shading = cardData.shading
        view.isOpaque = false
        return view
    }
    
    private func emptySetter(view: SymbolView)->SymbolView{
        view.shape = 0
        view.color = 0
        view.shading = 0
        view.isOpaque = false
        return view
    }
    
    private func layoutForCard(){
                
        for sections in 0..<SizeRatio.cardSectionsInt{
            var fillView = SymbolView(frame:
                CGRect(origin:
                    CGPoint(x: cardSectionOriginX, y: cardSectionsHeight * CGFloat(sections)),
                       size: cardSectionSize)
            )
            switch cardData.numberOfShapes {
            case 1 :
                if sections == 3 {
                    fillView = symbolSetter(view: fillView)
                }
                else {
                    fillView = emptySetter(view: fillView)
                }
            case 2 :
                if sections == 2 || sections == 4 {
                    fillView = symbolSetter(view: fillView)
                }
                else {
                    fillView = emptySetter(view: fillView)
                }
            case 3 :
                if sections == 1 || sections == 3 || sections == 5 {
                    fillView = symbolSetter(view: fillView)
                }
                else {
                    fillView = emptySetter(view: fillView)
                }
            default :
                fillView = emptySetter(view: fillView)
            }
            fillView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            fillView.isOpaque = false
            addSubview(fillView)
        }
    }
    
    
    override func layoutSubviews(){
        super .layoutSubviews()
        self.contentMode = .redraw
        layoutForCard()
    }
    
    override func draw(_ rect: CGRect) {
        self.contentMode = .redraw
 
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        self.isOpaque = false
        roundedRect.fill()
    }
    
}

// Understand why constants are created this way

extension SetCardView {
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
