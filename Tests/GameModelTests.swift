//	MIT License
//
//	Copyright © 2019_DEV_182
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.
//
//	ID: BD9ADD22-8EC4-438E-BE70-37495D9FB07A
//
//	Pkg: TicTacToe
//
//	Swift: 5.0
//
//	MacOS: 10.15
//

import XCTest
@testable import TicTacToe

class GameModelTests: XCTestCase {

    func testResetBoard() {
        XCTAssert(GameViewModel.reset.game.board == mockGameEmptyBoard.board)
    }
    
    func testCanSwapTurn() {
        let model = mockModelEmptyBoard()
        let swappedPlayerModel = model.swapTurn(current: .playerOne)
        
        XCTAssert(swappedPlayerModel.playerTurn == .playerTwo)
    }
}

// MARK: - Test logic for row win
extension GameModelTests {
    func testWinForFirstRow() {
        testHorizontalWin(coords: mockFirstRowWin)
    }
    
   func testWinForSecondRow() {
		testHorizontalWin(coords: mockSecondRowWin)
	}
	
	func testWinForThirdRow() {
		testHorizontalWin(coords: mockThirdRowWin)
	}
	
	private func testHorizontalWin(coords: [Coordinates]) {
		let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
		XCTAssert(winningX.checkHorizontalWin(for: .x))
		
		let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
		XCTAssert(winningO.checkHorizontalWin(for: .o))
	}
}

// MARK: - Test logic for column win
extension GameModelTests {
    func testWinForFirstColumn() {
       testVerticalWin(coords: mockFirstColumnWin)
    }
    
    func testWinForSecondColumn() {
        testVerticalWin(coords: mockSecondColumnWin)
    }
    
    func testWinForThirdColumn() {
		testVerticalWin(coords: mockThirdColumnWin)
    }
	
	private func testVerticalWin(coords: [Coordinates]) {
		let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
		XCTAssert(winningX.checkVerticalWin(for: .x))
		
		let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
		XCTAssert(winningO.checkVerticalWin(for: .o))
	}
}

// MARK: - Test logic for diagonal win
extension GameModelTests {
	func testWinForDiagonalTopLeftToBottomRight() {
		testDiagonalWin(coords: mockTopLeftToBottomRightWin)
	}
	
	func testWinForDiagonalBottomLeftToTopRight() {
		testDiagonalWin(coords: mockBottomLeftToTopRightWin)
	}
	
	private func testDiagonalWin(coords: [Coordinates]) {
		let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
		XCTAssert(winningX.checkDiagonalWin(for: .x))
		
		let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
		XCTAssert(winningO.checkDiagonalWin(for: .o))
	}
}


// MARK: - Tests for checking the processing of a move
extension GameModelTests {
    
    func testCantMakeIllegalMove() {
        
        var model = mockModelEmptyBoard()
        
        _ = model.process(move: .x, coordinates: .init(row: 0, column: 0))
        let illegalMove = model.process(move: .x, coordinates: .init(row: 0, column: 0))
        
        switch illegalMove {
        case .moveIlleagal: XCTAssert(true)
        default: XCTFail()
        }
    }
    
    func testProcessMoveReturnsPlayerWinOnWinningMove() {
        
        var model = mockModelOneSpaceLeft()
        
        let result = model.process(move: .x, coordinates: .init(row: 2, column: 2))
        
        switch result {
        case .gameWin(_): XCTAssert(true)
        default: XCTFail()
        }
    }
    
    func testProcessMoveReturnsDrawWhenBoardIsCompleteWithNoWinner() {
        
        var model = mockModelOneSpaceLeft(for: .playerTwo)
        
        let result = model.process(move: .o, coordinates: .init(row: 2, column: 2))
        
        switch result {
        case .gameDraw(_): XCTAssert(true)
        default: XCTFail()
        }
    }
    
    func testProcessMoveReturnsMoveWhenStandardMoveIsMade() {
        
        var model = mockModelEmptyBoard()
        
        let result = model.process(move: .x, coordinates: .init(row: 0, column: 0))
        
        switch result {
        case .move(_): XCTAssert(true)
        default: XCTFail()
        }
    }
}

