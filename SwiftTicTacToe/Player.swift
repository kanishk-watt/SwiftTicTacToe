//
//  Player.swift
//  SwiftTicTacToe
//
//  Created by Kanishk Gupta on 20/08/22.
//

import Foundation

class Player : GameField {
    
    var isTurn : Bool
    var type : PlayerType
    
    init(type : PlayerType, turn : Bool) {
        self.isTurn = turn
        self.type = type
        super.init()
    }
    
    
    func makeMove(row : Int, column : Int, completion : ((_ state : GameState) -> Void)) {
        
        moves += 1
        rowContainer[row] += 1
        columnContainer[column] += 1
            
        if row == column {
            diagonalContainer[row] += 1
        }
            
        if row + column + 1 == size {
            oppDiagonalContainer[row] += 1
        }
        
        self.checkBoard(row: row, column: column, completion: completion)
    }
    
    func reset() {
        rowContainer = Array(repeating: 0, count: 3)
        columnContainer = Array(repeating: 0, count: 3)
        diagonalContainer = Array(repeating: 0, count: 3)
        oppDiagonalContainer = Array(repeating: 0, count: 3)
        moves = 0
        isTurn = type == .X
        
    }
}
