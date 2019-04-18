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
    
    
    @IBOutlet weak var playingBoardView: UIView!
    
    @IBOutlet var mainView: UIView!
    
    @IBAction func threeMoreCardsButton(_ sender: UIButton) {
        guard !game.deckEmpty else {
            sender.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            return
        }
        handleSetState()
        game.dealThreeCards()
        updateViewFromModel()
    }
    @IBAction func newGame(_ sender: UIButton) {
        game = SetGame()
        updateViewFromModel()
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var selectedViews: [SetCardView] {
        return cardViews.filter { cardView in
            cardView.stateOfSetCardView == .selected || cardView.stateOfSetCardView == .selectedAndMatched
        }
    }
    
    private var selectedSetCards: [SetCard]{
        var setCards = [SetCard]()
         selectedViews.forEach{
            setCards.append(correspondingSetCard(color: $0.color, symbol: $0.shape, number: $0.numberOfShapes, shading: $0.shading))
        }
        return setCards
    }
    
    @objc func touchCard(recognizer: UITapGestureRecognizer) {
        guard let tappedCard = recognizer.view as? SetCardView else { return }
        
        if selectedViews.count == 3 {
            if isSet {
                handleSetState()
                tappedCard.stateOfSetCardView = .selected
                return
            }
            selectedViews.forEach{$0.stateOfSetCardView = .unselected}
        }
        
        tappedCard.stateOfSetCardView = tappedCard.stateOfSetCardView == .selected ? .unselected : .selected
        if isSet {return}
    }
    
    var isSet : Bool {

            if selectedViews.count == 3 && game.isMatch(selectedCards: selectedSetCards){
                selectedViews.forEach { $0.stateOfSetCardView = .selectedAndMatched }
                return true
            }
        return false
    }
    
    private func handleSetState() {
     
        if selectedSetCards.count == 3 && game.ifSetThenRemoveFromTable(cards: selectedSetCards) {
         //   scoreLabel.text = "\(gameEngine.score)"
            selectedViews.forEach {
                $0.numberOfShapes = 0
                $0.shape = 0
                $0.shading = 0
                $0.color = 0
                cardViews.remove(at: cardViews.index(of: $0)!)
                $0.removeFromSuperview()
            }
        } else {
            game.score -= 3
        }
    }
    
    let cardAspectRatio : CGFloat = 5.0/8.0
    
    
    lazy var cardGrid = Grid(layout: Grid.Layout.aspectRatio(cardAspectRatio), frame: playingBoardView.frame)
    var game = SetGame()
    var cardViews = [SetCardView]()
    
    
    
    override func viewDidLoad() {
        //playingView.cardsViewData.append(card)
        updateViewFromModel()
    }
    
    func updateViewFromModel(){
        for subview in playingBoardView.subviews{
            subview.removeFromSuperview()
        }
        scoreLabel.text = "SC: \(game.score)"
        
        cardGrid.cellCount = game.cardsOnBoard.count
        for gridIndex in 0..<cardGrid.cellCount{
            
            let myCard = SetCardView()
            cardViews.append(myCard)
            myCard.contentMode = .redraw
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
    
    func correspondingSetCard(color : Int, symbol : Int, number : Int, shading : Int) -> SetCard {
        let setCard = game.cardsOnBoard.filter{$0.color.rawValue == color && $0.symbol.rawValue == symbol && $0.number.rawValue == number && $0.shading.rawValue == shading}
        return setCard[0]
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
        return CGRect(x: minX, y: minY, width: width, height: height - CGRect.padding*3)
    }
}
