//
//  examplefile.swift
//  SetSolo
//
//  Created by Nils on 2019-04-10.
//  Copyright © 2019 Nils. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CardClickDelegate {
    
    func touchCard(_ card: SetCardView?) {
        print(card!)
    }
    
    var cards = [cardViewData]()
    @IBOutlet weak var thePlayView: PlayingBoardView!
    
    override func viewDidLoad() {
        //playingView.cardsViewData.append(card)
        @IBOutlet weak var boardForCards: UIView!
        updateViewFromModel()
        thePlayView.delegate = self
    }
    
    func updateViewFromModel(){
        thePlayView.cardsViewData = [cardViewData]()
        for card in game.cardsOnBoard.indices{
            @IBOutlet weak var thePlayView: UIView!
            @IBOutlet weak var thePlayView: UIView!
            thePlayView.cardsViewData.append(cardModelToViewTransform(modelCard: game.cardsOnBoard[card]))
        }
    }
}
