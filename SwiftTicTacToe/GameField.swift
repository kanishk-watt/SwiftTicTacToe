//
//  GameField.swift
//  SwiftTicTacToe
//
//  Created by Kanishk Gupta on 19/08/22.
//

import Foundation

protocol GameFieldProtocol {
    var rowContainer : [Int] {get set}
    var columnContainer : [Int] {get set}
    var diagonalContainer : [Int] {get set}
    var oppDiagonalContainer : [Int] {get set}
    var size : Int {get}
}

enum PlayerType{
    case X
    case O
}

enum GameState {
    case Win
    case Draw
    case GameOn
}

class GameField : GameFieldProtocol {
    
    var size: Int = 3
    
    var moves : Int = 0
    
    var rowContainer: [Int] = Array(repeating: 0, count: 3)
    
    var columnContainer: [Int] = Array(repeating: 0, count: 3)
    
    var diagonalContainer: [Int] = Array(repeating: 0, count: 3)
    
    var oppDiagonalContainer: [Int] = Array(repeating: 0, count: 3)
    
    
    func checkBoard(row: Int, column : Int, completion : (_ state : GameState) -> Void) {
        if rowContainer[row] == size {
            completion(.Win)
            return
        }
            
        if columnContainer[column] == size {
            completion(.Win)
            return
        }
        
        var sumForRegularDiagonalElements = 0
        var sumForOppositeDiagonalElements = 0
        
        for (index, _) in diagonalContainer.enumerated() {
        
            sumForRegularDiagonalElements += diagonalContainer[index]
            sumForOppositeDiagonalElements += oppDiagonalContainer[index]

        }
        
        if sumForRegularDiagonalElements == size {
            completion(.Win)
            return
        }
        
        if sumForOppositeDiagonalElements == size {
            completion(.Win)
            return
        }
        
        if moves > 4 {
            completion(.Draw)
            return
        }
        
        completion(.GameOn)
    }
    
}

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


