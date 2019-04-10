//
//  PlayingBoardView.swift
//  SetSolo
//
//  Created by Nils on 2019-03-16.
//  Copyright © 2019 Nils. All rights reserved.
//


protocol CardClickDelegate: class {
    func touchCard(_ card: SetCardView?)
}

import UIKit

@IBDesignable

class PlayingBoardView: UIView {
    
    weak var delegate: CardClickDelegate?
    
    var cardsViewData = [cardViewData]() {didSet
    {setNeedsLayout()}}
    
    lazy var cardGrid = Grid(layout: Grid.Layout.aspectRatio(5.0/8.0), frame: self.frame.adjustRect())
    
    @objc func cardTouched(recognizer: UITapGestureRecognizer){
        delegate?.touchCard(sender)
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        self.contentMode = .redraw
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        cardGrid.cellCount = cardsViewData.count
        
        for gridIndex in 0..<cardGrid.cellCount{
            let myCard = SetCardView()
            myCard.cardData = cardsViewData[gridIndex]
            let tap = UITapGestureRecognizer(target: self, action: #selector(cardTouched(sender:)))
            
            
            myCard.addGestureRecognizer(tap)
            if cardGrid[gridIndex] != nil {
                myCard.frame = cardGrid[gridIndex]!.insetBy(dx: 2.0, dy: 2.0)
                myCard.isOpaque = false
                myCard.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                
            }
            addSubview(myCard)
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
