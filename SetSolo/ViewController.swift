//
//  ViewController.swift
//  SetSolo
//
//  Created by Nils on 2019-02-10.
//  Copyright © 2019 Nils. All rights reserved.
//




import UIKit

@IBDesignable

class ViewController: UIViewController {

    @objc func touchCard(recognizer: UITapGestureRecognizer) {
        guard let tappedCard = recognizer.view as? SetCardView else { return }
        tappedCard.stateOfSetCardButton = tappedCard.stateOfSetCardButton == .selected ? .unselected : .selected
        if true {
            
        }
    }
    
    @IBOutlet weak var playingBoardView: UIView!
    
    let cardAspectRatio : CGFloat = 5.0/8.0
    
    @IBOutlet var mainView: UIView!
    
    lazy var cardGrid = Grid(layout: Grid.Layout.aspectRatio(cardAspectRatio), frame: playingBoardView.frame)

    var game = SetGame()
    var cardViews = [SetCardView]()
    
    @IBAction func threeMoreCardsButton(_ sender: UIButton) {
        game.dealThreeCards()
        updateViewFromModel()
    }
    @IBAction func newGame(_ sender: UIButton) {
        game = SetGame()
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        //playingView.cardsViewData.append(card)
        updateViewFromModel()
        print(playingBoardView.frame)
    }

    func updateViewFromModel(){
        layout()
    }
    
    func layout(){
        for subview in playingBoardView.subviews{
            subview.removeFromSuperview()
        }
        
        cardGrid.cellCount = game.cardsOnBoard.count
        for gridIndex in 0..<cardGrid.cellCount{
            let myCard = SetCardView()
            cardViews.append(myCard)
            myCard.color = game.cardsOnBoard[gridIndex].color.rawValue
            myCard.shape = game.cardsOnBoard[gridIndex].symbol.rawValue
            myCard.numberOfShapes = game.cardsOnBoard[gridIndex].number.rawValue
            myCard.shading = game.cardsOnBoard[gridIndex].shading.rawValue
            myCard.isOpaque = false

            let tap = UITapGestureRecognizer(target: self, action: #selector(touchCard(recognizer:)))
            myCard.addGestureRecognizer(tap)
            
            if cardGrid[gridIndex] != nil {
                myCard.frame = cardGrid[gridIndex]!.insetBy(dx: 2.0, dy: 2.0)
            }
            playingBoardView.addSubview(myCard)
        }
    }
}




extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}

extension CGRect {
    
    static let padding : CGFloat = 0.0
    
    func adjustRect() -> CGRect {
        return CGRect(x: CGRect.padding, y: CGRect.padding, width: width - CGRect.padding*2, height: height - CGRect.padding*2)
    }
}
