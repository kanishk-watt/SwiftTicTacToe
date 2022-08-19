//
//  ViewController.swift
//  SwiftTicTacToe
//
//  Created by Kanishk Gupta on 19/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    var playerX = Player(type: .X, turn: true)
    var playerO = Player(type: .O, turn: false)
    
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var vStackView: UIStackView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func makeMove(_ sender: Any) {
        guard let btn = sender as? UIButton  else {
            return
        }
        
        let rowColumn = getRowColumn(tag: btn.tag)
        var response = ""
        
        if playerX.isTurn {
            response = "\(PlayerType.X)"
            playerX.makeMove(row: rowColumn.0, column: rowColumn.1) {[weak self] (state) in
                self!.checkState(player: .X, state: state)
            }
        } else {
            response = "\(PlayerType.O)"

            playerO.makeMove(row: rowColumn.0, column: rowColumn.1) {[weak self] (state) in
                self!.checkState(player: .O, state: state)
            }
        }
        
        toggleTurn()
        
        btn.setTitle(response, for: .normal)
        btn.isEnabled = false
    }
    
    @IBAction func resetGame(_ sender: Any) {
        resetGame()
    }
    
    func resetGame() {
        statusView.alpha = 0
        vStackView.alpha = 1
        turnLabel.text = "X's Turn"
        playerX.reset()
        playerO.reset()
        for i in 1...9 {
            let btn = self.view.viewWithTag(i) as! UIButton
            btn.setTitle("Tap", for: .normal)
            btn.isEnabled = true
        }
    }
    
    func checkState(player : PlayerType, state : GameState) {
        switch state {
        case .Win:
            statusView.alpha = 1
            statusLabel.text = "\(player) Wins!"
            vStackView.alpha = 0.2
        case .GameOn:
            print("Game ON")
        case .Draw:
            statusView.alpha = 1
            statusLabel.text = "Draw!"
            vStackView.alpha = 0.2
        }
    }
    
    func toggleTurn() {
        playerX.isTurn = playerO.isTurn
        playerO.isTurn = !playerO.isTurn
        turnLabel.text = playerX.isTurn ? "X's Turn" : "O's Turn"
    }
    
    func getRowColumn(tag : Int) -> (Int, Int){
        return ((tag - 1 ) / 3 , (tag - 1) % 3)
    }
    
}

