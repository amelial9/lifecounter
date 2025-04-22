//
//  ViewController.swift
//  lifecounter
//
//  Created by Amelia Li on 4/20/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    
    @IBOutlet weak var gameEndedLabel: UILabel!
    @IBOutlet weak var restart: UIButton!
    
    @IBOutlet weak var playerStacks: UIStackView!
    
    @IBOutlet weak var mainContent: UIStackView!
    var player1Life = 20
    var player2Life = 20
    var gameOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameEndedLabel.isHidden = true
        restart.isHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            let isLandscape = size.width > size.height
            
            self.mainContent.axis = isLandscape ? .vertical : .vertical
            self.playerStacks.axis = isLandscape ? .horizontal : .vertical
        })
    }
    
    func updateLifeLabels() {
        player1Label.text = "Remaining Life: \(player1Life)"
        player2Label.text = "Remaining Life: \(player2Life)"
    }
    
    func checkGameOver() {
        if player1Life <= 0 {
            gameEndedLabel.text = "⚠️ Player 1 Lost"
            endGame()
        } else if player2Life <= 0 {
            gameEndedLabel.text = "⚠️ Player 2 Lost"
            endGame()
        }
    }
    
    func endGame() {
        gameOver = true
        gameEndedLabel.isHidden = false
        restart.isHidden = false
    }
    
    func resetGame() {
        player1Life = 20
        player2Life = 20
        gameOver = false
        gameEndedLabel.isHidden = true
        restart.isHidden = true
        updateLifeLabels()
    }
    
    
    @IBAction func player1Minus1(_ sender: Any) {
        guard !gameOver else { return }
        player1Life = player1Life - 1
        player1Label.text = "Remaining Life: \(player1Life)"
        updateLifeLabels()
        checkGameOver()
    }
    
    
    @IBAction func player1Add1(_ sender: Any) {
        guard !gameOver else { return }
        player1Life = player1Life + 1
        player1Label.text = "Remaining Life: \(player1Life)"
        updateLifeLabels()
        checkGameOver()
    }
    
    
    @IBAction func player1Minus5(_ sender: Any) {
        guard !gameOver else { return }
        player1Life = player1Life - 5
        player1Label.text = "Remaining Life: \(player1Life)"
        updateLifeLabels()
        checkGameOver()
    }
    
    
    @IBAction func player1Add5(_ sender: Any) {
        guard !gameOver else { return }
        player1Life = player1Life + 5
        player1Label.text = "Remaining Life: \(player1Life)"
        updateLifeLabels()
        checkGameOver()
    }
    
    @IBAction func player2Minus1(_ sender: Any) {
        guard !gameOver else { return }
        player2Life = player2Life - 1
        player2Label.text = "Remaining Life: \(player2Life)"
        updateLifeLabels()
        checkGameOver()
    }
    
    
    @IBAction func player2Add1(_ sender: Any) {
        guard !gameOver else { return }
        player2Life = player2Life + 1
        player2Label.text = "Remaining Life: \(player2Life)"
        updateLifeLabels()
        checkGameOver()
    }
    
    
    @IBAction func player2Minus5(_ sender: Any) {
        guard !gameOver else { return }
        player2Life = player2Life - 5
        player2Label.text = "Remaining Life: \(player2Life)"
        updateLifeLabels()
        checkGameOver()
    }
    
    
    @IBAction func player2Add5(_ sender: Any) {
        guard !gameOver else { return }
        player2Life = player2Life + 5
        player2Label.text = "Remaining Life: \(player2Life)"
        updateLifeLabels()
        checkGameOver()
    }
    
    @IBAction func restartTapped(_ sender: Any) {
        resetGame()
    }
    
}
