//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Andrew R Madsen on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, BoardViewControllerDelegate {

    var game = Game() {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func restartGame(_ sender: Any) {
        board = GameBoard()
        game.restart()
    }
    
    // MARK: - BoardViewControllerDelegate
    
    func boardViewController(_ boardViewController: BoardViewController, markWasMadeAt coordinate: Coordinate) {
        do {
            try board.place(mark: game.activePlayer!, on: coordinate)

            try game.makeMark(at: coordinate)
        } catch {
            NSLog("Illegal move")
        }
    }
    
    // MARK: - Private
    
    private func updateViews() {
        guard isViewLoaded else { return }
        
        if game.activePlayer != nil && !game.gameIsOver {
            statusLabel.text = "Player \(game.activePlayer!)'s turn"
        } else if game.gameIsOver && game.winningPlayer == nil {
            statusLabel.text = "Cat's game!"
        } else if game.gameIsOver && game.winningPlayer != nil {
            statusLabel.text = "Player \(game.winningPlayer!) won!"
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedBoard" {
            boardViewController = segue.destination as? BoardViewController
        }
    }
    
    private var boardViewController: BoardViewController! {
        willSet {
            boardViewController?.delegate = nil
        }
        didSet {
            boardViewController?.board = board
            boardViewController?.delegate = self
        }
    }
    
    @IBOutlet weak var statusLabel: UILabel!
    
    private var board = GameBoard() {
        didSet {
            boardViewController.board = board
        }
    }
}
