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
        let checkState : (_ state : GameState) -> Void = { [weak self] (state) in
            self!.checkState(player: PlayerType.O, state: state)
        }
        let response = makePlayerMove(rowColumn: rowColumn, completion: checkState)
        
        changeTurnLabel()
        UIView.animate(withDuration: 0.2) { 
            btn.setTitle(response, for: .normal)
        }
        btn.isEnabled = false
    }
    
    @IBAction func resetGame(_ sender: Any) {
        UIView.animate(withDuration: 0.5) { [self] in
            statusView.alpha = 0
            vStackView.alpha = 1
            for i in 1...9 {
                let btn = self.view.viewWithTag(i) as! UIButton
                btn.setTitle("Tap", for: .normal)
                btn.isEnabled = true
            }
        }
        playerX.reset()
        playerO.reset()
        changeTurnLabel()
    }
    
    func makePlayerMove(rowColumn : (Int, Int), completion : ((_ state : GameState) -> Void)) -> String {
        var response = ""
        
        if playerX.isTurn {
            response = "\(PlayerType.X)"
            playerX.makeMove(row: rowColumn.0, column: rowColumn.1, completion: completion)
        } else {
            response = "\(PlayerType.O)"
            playerO.makeMove(row: rowColumn.0, column: rowColumn.1, completion: completion)
        }
        
        toggleTurn()
        
        return response
    }
    
    func checkState(player : PlayerType, state : GameState) {
        switch state {
        case .Win:
            UIView.animate(withDuration: 0.5) { [self] in
                statusView.alpha = 1
                statusLabel.text = "\(player) Wins!"
                vStackView.alpha = 0.2
            }
            
        case .GameOn:
            break
        case .Draw:
            UIView.animate(withDuration: 0.5) { [self] in
                statusView.alpha = 1
                statusLabel.text = "Draw!"
                vStackView.alpha = 0.2
            }
        }
    }
    
    func toggleTurn() {
        playerX.isTurn = playerO.isTurn
        playerO.isTurn = !playerO.isTurn
        
    }
    
    func changeTurnLabel() {
        turnLabel.text = playerX.isTurn ? "X's Turn" : "O's Turn"
    }
    
    func getRowColumn(tag : Int) -> (Int, Int){
        if tag > 9 || tag < 1 {
            return (-1,-1)
        }
        return ((tag - 1 ) / 3 , (tag - 1) % 3)
    }
    
}

