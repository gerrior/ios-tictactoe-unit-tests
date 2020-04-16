//
//  Game.swift
//  TicTacToe
//
//  Created by Mark Gerrior on 4/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Game {

    // MARK: - Properites
    
    /// Externally read-only property for the game board. Game itself modifies this as the game progresses
    private(set) var board: GameBoard
    
    /// The currently active player, either .x or .o. That is, the player whose turn it is. nil if the game is over.
    internal var activePlayer: GameBoard.Mark?

    /// true if the game is over (either won or a cat's game), false if the game is still running
    internal var gameIsOver: Bool
    
    /// The player that won the game, either .x or .o. nil if the game is still running, or it's a cat's game (no one won).
    internal var winningPlayer: GameBoard.Mark?

    // MARK: - Functions
    
    init() {
        board = GameBoard()
        activePlayer = .x
        gameIsOver = false
        winningPlayer = nil
    }
    
    /// Restarts the game to a fresh state with an empty board, and player X starting.
    mutating internal func restart() {
        board = GameBoard()
        activePlayer = .x
        gameIsOver = false
        winningPlayer = nil
    }

    /// adds a mark for the currently active player at the given coordinate. Updates game state
    /// - Parameter coordinate: x and y coordiantes of where to make mark
    /// - Throws: If game is over or it's an illegal move
    mutating internal func makeMark(at coordinate: Coordinate) throws {
        if gameIsOver == true {
            NSLog("Game is over")
            return
        }
        
        guard let activePlayer = activePlayer else { return }
        
        do {
            try board.place(mark: activePlayer, on: coordinate)
            if game(board: board, isWonBy: activePlayer) {
                gameIsOver = true
                winningPlayer = activePlayer
            } else if board.isFull {
                gameIsOver = true
                winningPlayer = nil
            } else {
                self.activePlayer = activePlayer == .x ? GameBoard.Mark.o : GameBoard.Mark.x
                gameIsOver = false
            }
        }
    }
}
