//
//  SwiftTicTacToeTests.swift
//  SwiftTicTacToeTests
//
//  Created by Kanishk Gupta on 19/08/22.
//

import XCTest
@testable import SwiftTicTacToe

var vc : ViewController!

class SwiftTicTacToeTests: XCTestCase {
    
    
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
//        vc = ViewController()
        
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTurn() throws {
        XCTAssertEqual(vc.playerX.isTurn, true)
        XCTAssertEqual(vc.playerO.isTurn, false)
        
        vc.toggleTurn()
        
        XCTAssertEqual(vc.playerX.isTurn, false)
        XCTAssertEqual(vc.playerO.isTurn, true)
        
    }
    
    func testRowColumn() {
        var rc = vc.getRowColumn(tag: 1)
        
        XCTAssertEqual(rc.0, 0)
        XCTAssertEqual(rc.1, 0)
        
        rc = vc.getRowColumn(tag: 5)
        
        XCTAssertEqual(rc.0, 1)
        XCTAssertEqual(rc.1, 1)
        
        rc = vc.getRowColumn(tag: 10)
        
        XCTAssertEqual(rc.0, -1)
        XCTAssertEqual(rc.1, -1)
        
    }
    
    func testPlayerRowWin() {
        
        let checkState : (_ state : GameState) -> Void = {  (state) in
            XCTAssertEqual(state, GameState.GameOn)
        }
        
        let checkWinState : (_ state : GameState) -> Void = {  (state) in
            XCTAssertEqual(state, GameState.Win)
        }
        
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (0,1), completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,1),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (0,0),completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,2),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (0,2),completion: checkWinState), "X")
        
        
    }
    
    func testPlayerColumnWin() {
        
        let checkState : (_ state : GameState) -> Void = {(state) in
            XCTAssertEqual(state, GameState.GameOn)
        }
        
        let checkWinState : (_ state : GameState) -> Void = { (state) in
            XCTAssertEqual(state, GameState.Win)
        }
        
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (0,1), completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,2),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,1),completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,2),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (2,1),completion: checkWinState), "X")
        
        
    }
    
    func testPlayerDiagonalWin() {
        
        let checkState : (_ state : GameState) -> Void = { (state) in
            XCTAssertEqual(state, GameState.GameOn)
        }
        
        let checkWinState : (_ state : GameState) -> Void = { (state) in
            XCTAssertEqual(state, GameState.Win)
        }
        
        print(vc.playerX.rowContainer)
        
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,1), completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (2,1),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (0,0),completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,2),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (2,2),completion: checkWinState), "X")
        
        
    }
    
    func testPlayerOppDiagonalWin() {
        
        let checkState : (_ state : GameState) -> Void = { (state) in
            XCTAssertEqual(state, GameState.GameOn)
        }
        
        let checkWinState : (_ state : GameState) -> Void = { (state) in
            XCTAssertEqual(state, GameState.Win)
        }
        
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (0,2), completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (2,1),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,1),completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,2),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (2,0),completion: checkWinState), "X")
        
        
    }
    
    func testDraw() {
        let checkState : (_ state : GameState) -> Void = { (state) in
            XCTAssertEqual(state, GameState.GameOn)
        }
        
        let checkDrawState : (_ state : GameState) -> Void = { (state) in
            XCTAssertEqual(state, GameState.Draw)
        }
        
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (0,2), completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (2,1),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,1),completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (2,0),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (2,2),completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,2),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (0,1),completion: checkState), "X")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (0,0),completion: checkState), "O")
        XCTAssertEqual(vc.makePlayerMove(rowColumn: (1,0),completion: checkDrawState), "X")
    }
    
    func testPlayerReset() {
        vc.playerX.reset()
        vc.playerO.reset()
        
        XCTAssertEqual(vc.playerX.rowContainer, [0,0,0])
        XCTAssertEqual(vc.playerX.columnContainer, [0,0,0])
        XCTAssertEqual(vc.playerX.diagonalContainer, [0,0,0])
        XCTAssertEqual(vc.playerX.oppDiagonalContainer, [0,0,0])
        XCTAssertEqual(vc.playerX.isTurn, true)
        
        
        XCTAssertEqual(vc.playerO.rowContainer, [0,0,0])
        XCTAssertEqual(vc.playerO.columnContainer, [0,0,0])
        XCTAssertEqual(vc.playerO.diagonalContainer, [0,0,0])
        XCTAssertEqual(vc.playerO.oppDiagonalContainer, [0,0,0])
        XCTAssertNotEqual(vc.playerO.isTurn, true)
        
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
