//
//  ViewController.swift
//  lifecounter
//
//  Created by Amelia Li on 4/20/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loserLabel: UILabel!
    @IBOutlet weak var mainContainerStack: UIStackView!
    @IBOutlet weak var playerContainerStack: UIStackView!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var resetGameButton: UIButton!
    
    var players: [UIView] = []
    var playerLives: [Int] = []
    var historyLog: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame(self)
    }

    @IBAction func showHistory(_ sender: UIButton) {
//        let historyVC = HistoryViewController(nibName: "HistoryView", bundle: nil)
//        historyVC.history = historyLog
//        present(historyVC, animated: true, completion: nil)
    }

    func addPlayer(name: String) {
        let playerIndex = players.count
        playerLives.append(20)

        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textAlignment = .center

        let lifeLabel = UILabel()
        lifeLabel.text = "Remaining Life: 20"
        lifeLabel.textAlignment = .center

        let inputField = UITextField()
        inputField.placeholder = "Enter amount"
        inputField.textAlignment = .center
        inputField.keyboardType = .numberPad
        inputField.borderStyle = .roundedRect
//        inputField.widthAnchor.constraint(equalToConstant: 80).isActive = true

        func updateLifeLabel() {
            lifeLabel.text = "Remaining Life: \(playerLives[playerIndex])"
        }

        func checkForLoser() {
            for (index, life) in playerLives.enumerated() {
                if life <= 0 {
                    loserLabel.text = "Player \(index + 1) loses!"
                    loserLabel.alpha = 1
                    return
                }
            }
            loserLabel.alpha = 0
        }

        func grayButton(title: String) -> UIButton {
            var config = UIButton.Configuration.gray()
            config.title = title
            config.cornerStyle = .medium
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
            return UIButton(configuration: config)
        }

        let minusOne = grayButton(title: "-1")
        minusOne.addAction(UIAction { _ in
            self.playerLives[playerIndex] = max(self.playerLives[playerIndex] - 1, 0)
            updateLifeLabel()
            checkForLoser()
            self.historyLog.append("\(name) lost 1 life.")
            self.addPlayerButton.isEnabled = false
        }, for: .touchUpInside)

        let plusOne = grayButton(title: "+1")
        plusOne.addAction(UIAction { _ in
            self.playerLives[playerIndex] += 1
            updateLifeLabel()
            checkForLoser()
            self.historyLog.append("\(name) gained 1 life.")
            self.addPlayerButton.isEnabled = false
        }, for: .touchUpInside)

        let subtract = grayButton(title: "-")
        subtract.addAction(UIAction { _ in
            if let delta = Int(inputField.text ?? "") {
                let actual = min(delta, self.playerLives[playerIndex])
                self.playerLives[playerIndex] -= actual
                updateLifeLabel()
                checkForLoser()
                self.historyLog.append("\(name) lost \(actual) life.")
                self.addPlayerButton.isEnabled = false
            }
        }, for: .touchUpInside)

        let add = grayButton(title: "+")
        add.addAction(UIAction { _ in
            if let delta = Int(inputField.text ?? "") {
                self.playerLives[playerIndex] += delta
                updateLifeLabel()
                checkForLoser()
                self.historyLog.append("\(name) gained \(delta) life.")
                self.addPlayerButton.isEnabled = false
            }
        }, for: .touchUpInside)

        let quickAdjustStack = UIStackView(arrangedSubviews: [minusOne, plusOne])
        quickAdjustStack.axis = .horizontal
        quickAdjustStack.distribution = .fillEqually
        quickAdjustStack.spacing = 8

        let customAdjustStack = UIStackView(arrangedSubviews: [subtract, inputField, add])
        customAdjustStack.axis = .horizontal
        customAdjustStack.distribution = .fillEqually
        customAdjustStack.spacing = 8

        let fullStack = UIStackView(arrangedSubviews: [nameLabel, lifeLabel, quickAdjustStack, customAdjustStack])
        fullStack.axis = .vertical
        fullStack.spacing = 12
        fullStack.translatesAutoresizingMaskIntoConstraints = false
        fullStack.isLayoutMarginsRelativeArrangement = true
        fullStack.setContentHuggingPriority(.required, for: .vertical)
        fullStack.setContentCompressionResistancePriority(.required, for: .vertical)

        players.append(fullStack)
        playerContainerStack.addArrangedSubview(fullStack)
    }


    @IBAction func addPlayerButtonTapped(_ sender: UIButton) {
        guard players.count < 8 else { return }
        let nextPlayerIndex = players.count + 1
        addPlayer(name: "Player \(nextPlayerIndex)")
        if players.count == 8 {
            sender.isEnabled = false
        }
    }

    @IBAction func resetGame(_ sender: Any) {
        for player in players {
            player.removeFromSuperview()
        }
        players.removeAll()
        playerLives.removeAll()

        for i in 1...4 {
            addPlayer(name: "Player \(i)")
        }

        loserLabel.alpha = 0
        addPlayerButton.isEnabled = true
    }
}
