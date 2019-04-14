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
       
        recognizer
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
  

            }
            addSubview(myCard)
        }

    }
    
}


