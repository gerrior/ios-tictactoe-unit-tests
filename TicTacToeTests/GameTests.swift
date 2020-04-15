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

}
