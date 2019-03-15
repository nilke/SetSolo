//
//  ViewController.swift
//  SetSolo
//
//  Created by Nils on 2019-02-10.
//  Copyright © 2019 Nils. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var game = SetGame()
    
    @IBOutlet weak var cardsInDeckLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    var cardButtons = [UIButton: SetCard]()
    @IBOutlet weak var threeMoreCardsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    @IBAction func threeMoreCards(_ sender: UIButton) {
        game.dealThreeCards()
        updateViewFromModel()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = SetGame()
        updateViewFromModel()
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let touchedCard = cardButtons[sender]{
            game.selectCard(card: touchedCard)
        }
        updateViewFromModel()
    }
    

    
    func updateViewFromModel(){
        cardsInDeckLabel.text = "Cards in deck: \(game.cardsInDeck)"
        scoreLabel.text = "Score: \(game.score)"
        for index in buttons.indices{
//            print("game data \(game.cardsOnBoard[index])")
            cardButtons[buttons[index]] = game.cardsOnBoard[index] //Sync the buttons with the game model
  //          print("copied over data \(cardButtons[buttons[index]])")
            if let cardForIndex = cardButtons[buttons[index]]{
                if game.selectedCards.contains(cardForIndex){
                    buttons[index].markSelected(for: cardForIndex)
                } else {
                    buttons[index].setSymbol(for: cardForIndex)
                }
            } else {
                buttons[index].setNoCard()
            }
        }
        
        //Update the colors of the 3 More Cards Button
        if game.deckEmpty {
            threeMoreCardsButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else if game.boardFull {
            threeMoreCardsButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else {
            threeMoreCardsButton.backgroundColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
        }
    }
}

extension UIButton {
    
    func markSelected(for card: SetCard) {
        self.layer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    func setNoCard(){
        self.layer.backgroundColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
        self.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
        self.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0)
        
    }
    
    func setSymbol(for card: SetCard){
        
        let color : UIColor
        let shading : CGFloat
        let number : Int
        let symbol : String
        let stroke : Double
        
        switch card.color {
        case .Color1: color = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        case .Color2: color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case .Color3: color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        }
        
        switch card.shading {
        case .Shading1: shading = 1.0
        case .Shading2: shading = 0.3  // Add Positive stroke width
        case .Shading3: shading = 1
        }
        
        switch card.shading {
        case .Shading1: stroke = 0
        case .Shading2: stroke = 0  // Add Positive stroke width
        case .Shading3: stroke = 6
        }
        
        switch card.number {
        case .Number1: number = 1
        case .Number2: number = 2
        case .Number3: number = 3
        }
        
        switch card.symbol {
        case .Symbol1: symbol = "▲"
        case .Symbol2: symbol = "●"
        case .Symbol3: symbol = "■"
        }
        
        var buttonText: String {
            get {
                switch number {
                case 1: return symbol
                case 2: return symbol + symbol
                case 3: return symbol + symbol + symbol
                default: return ""
                }
            }
        }
        
        
        let button = NSAttributedString(string: buttonText, attributes:
            [   NSAttributedString.Key.foregroundColor: UIColor.withAlphaComponent(color)(shading),
                NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 20.0)!,
                NSAttributedString.Key.strokeWidth : stroke
            ])
        
        self.setAttributedTitle(button, for: .normal)
        self.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.borderWidth = 3.0
        self.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        self.layer.cornerRadius = 8.0
    }
}

