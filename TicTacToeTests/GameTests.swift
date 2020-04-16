//
//  GameTests.swift
//  TicTacToeTests
//
//  Created by Mark Gerrior on 4/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {

    func testReset() throws {
        var game = Game()

        game.restart()
        XCTAssertTrue(game.board.isEmpty)
        XCTAssertEqual(game.activePlayer, .x)
        XCTAssertFalse(game.gameIsOver)
        XCTAssertNil(game.winningPlayer)
    }

    func testOverwriteMarkThrows() throws {

        var game = Game()

        try! game.makeMark(at: Coordinate(x: 0, y: 0))
        XCTAssertThrowsError(try game.makeMark(at: Coordinate(x: 0, y: 0)))
    }

    func testCatGame() {
        var game = Game()
        /*
         x x o
         o o x
         x x o
         */

        XCTAssertEqual(game.activePlayer, .x)
        try! game.makeMark(at: Coordinate(x: 0, y: 0))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .o)
        try! game.makeMark(at: Coordinate(x: 2, y: 0))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .x)
        try! game.makeMark(at: Coordinate(x: 1, y: 0))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .o)
        try! game.makeMark(at: Coordinate(x: 0, y: 1))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .x)
        try! game.makeMark(at: Coordinate(x: 2, y: 1))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .o)
        try! game.makeMark(at: Coordinate(x: 1, y: 1))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .x)
        try! game.makeMark(at: Coordinate(x: 1, y: 2))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .o)
        try! game.makeMark(at: Coordinate(x: 2, y: 2))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .x)
        try! game.makeMark(at: Coordinate(x: 0, y: 2))
        // ActivePlayer does not advanced when game is over (observed)
        XCTAssertEqual(game.activePlayer, .x, "⚠️ Unexpected activePlayer == \(game.activePlayer!)")
        XCTAssertEqual(game.gameIsOver, true)
        XCTAssertEqual(game.winningPlayer, nil)
    }

    func testOWinGame() {
        var game = Game()
        /*
         x - o
         - o -
         o x x
         */

        XCTAssertEqual(game.activePlayer, .x)
        try! game.makeMark(at: Coordinate(x: 0, y: 0))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .o)
        try! game.makeMark(at: Coordinate(x: 2, y: 0))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .x)
        try! game.makeMark(at: Coordinate(x: 2, y: 2))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .o)
        try! game.makeMark(at: Coordinate(x: 1, y: 1))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .x)
        try! game.makeMark(at: Coordinate(x: 1, y: 2))
        XCTAssertEqual(game.gameIsOver, false)

        XCTAssertEqual(game.activePlayer, .o)
        try! game.makeMark(at: Coordinate(x: 0, y: 2))

        // ActivePlayer does not advanced when game is over (observed)
        XCTAssertEqual(game.activePlayer, .o, "⚠️ Unexpected activePlayer == \(game.activePlayer!)")
        XCTAssertEqual(game.gameIsOver, true)
        XCTAssertEqual(game.winningPlayer, .o)
    }
}
