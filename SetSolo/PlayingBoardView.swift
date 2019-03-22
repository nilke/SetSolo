//
//  PlayingBoardView.swift
//  SetSolo
//
//  Created by Nils on 2019-03-16.
//  Copyright © 2019 Nils. All rights reserved.
//

import UIKit

@IBDesignable

class PlayingBoardView: UIView {
    
    var numberOfCards = 1 { didSet {setNeedsDisplay(); setNeedsLayout()}}
    
    private func createCard() -> SetCardView{
        let testCard = SetCardView()
        
        addSubview(testCard)
        return testCard
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        var cardGrid = Grid(layout: Grid.Layout.aspectRatio(5.0/8.0), frame: self.frame.adjustRect())
        
        cardGrid.cellCount = numberOfCards
        
        for card in 0..<cardGrid.cellCount{
            let myCard = createCard()
            if cardGrid[card] != nil {
                myCard.frame = cardGrid[card]!.insetBy(dx: 2.0, dy: 2.0)
                myCard.isOpaque = false
                
            }
        }
    }
}


extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}

extension CGRect {
    
    static let padding : CGFloat = 10.0
    
    func adjustRect() -> CGRect {
        return CGRect(x: CGRect.padding, y: CGRect.padding, width: width - CGRect.padding*2, height: height - CGRect.padding*2)
    }
}
