//
//  ViewController.swift
//  lifecounter
//
//  Created by Amelia Li on 4/20/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainContainerStack: UIStackView!
    @IBOutlet weak var playerContainerStack: UIStackView!
    
    @IBOutlet weak var loserLabel: UILabel!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var resetGameButton: UIButton!

    var playerViews: [UIView] = []
    var lifeTotals: [Int] = []
    var history: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame(self)
    }

    @IBAction func addPlayerButtonTapped(_ sender: UIButton) {
        guard playerViews.count < 8 else { return }
        let newIndex = playerViews.count + 1
        addPlayer(named: "Player \(newIndex)")
        if playerViews.count == 8 {
            sender.isEnabled = false
        }
    }

    @IBAction func resetGame(_ sender: Any) {
        playerViews.forEach { $0.removeFromSuperview() }
        playerViews.removeAll()
        lifeTotals.removeAll()
        history.removeAll() // Optional: clear history on reset

        for i in 1...4 {
            addPlayer(named: "Player \(i)")
        }

        loserLabel.alpha = 0
        addPlayerButton.isEnabled = true
    }

    func addPlayer(named name: String) {
        let index = playerViews.count
        lifeTotals.append(20)

        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textAlignment = .center

        let lifeLabel = UILabel()
        lifeLabel.text = "Remaining Life: 20"
        lifeLabel.textAlignment = .center

        let input = UITextField()
        input.placeholder = "Enter amount"
        input.textAlignment = .center
        input.keyboardType = .numberPad
        input.borderStyle = .roundedRect

        func updateLife() {
            lifeLabel.text = "Remaining Life: \(lifeTotals[index])"
        }

        func checkIfLoser() {
            for (i, life) in lifeTotals.enumerated() where life <= 0 {
                loserLabel.text = "Player \(i + 1) loses!"
                loserLabel.alpha = 1
                return
            }
            loserLabel.alpha = 0
        }

        func makeButton(_ title: String, action: @escaping () -> Void) -> UIButton {
            var config = UIButton.Configuration.gray()
            config.title = title
            config.cornerStyle = .medium
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
            let button = UIButton(configuration: config)
            button.addAction(UIAction { _ in action() }, for: .touchUpInside)
            return button
        }

        let minusOne = makeButton("-1") {
            self.lifeTotals[index] = max(self.lifeTotals[index] - 1, 0)
            updateLife()
            checkIfLoser()
            self.history.append("\(name) added 1 life.")
        }

        let plusOne = makeButton("+1") {
            self.lifeTotals[index] += 1
            updateLife()
            checkIfLoser()
            self.history.append("\(name) added 1 life.")
        }

        let subtract = makeButton("-") {
            if let amount = Int(input.text ?? "") {
                let change = min(amount, self.lifeTotals[index])
                self.lifeTotals[index] -= change
                updateLife()
                checkIfLoser()
                self.history.append("\(name) lost \(change) life.")
            }
        }

        let add = makeButton("+") {
            if let amount = Int(input.text ?? "") {
                self.lifeTotals[index] += amount
                updateLife()
                checkIfLoser()
                self.history.append("\(name) added \(amount) life.")
            }
        }

        let quickAdjust = UIStackView(arrangedSubviews: [minusOne, plusOne])
        quickAdjust.axis = .horizontal
        quickAdjust.spacing = 8
        quickAdjust.distribution = .fillEqually

        let customAdjust = UIStackView(arrangedSubviews: [subtract, input, add])
        customAdjust.axis = .horizontal
        customAdjust.spacing = 8
        customAdjust.distribution = .fillEqually

        let playerStack = UIStackView(arrangedSubviews: [nameLabel, lifeLabel, quickAdjust, customAdjust])
        playerStack.axis = .vertical
        playerStack.spacing = 12
        playerStack.translatesAutoresizingMaskIntoConstraints = false
        playerStack.isLayoutMarginsRelativeArrangement = true
        playerStack.setContentHuggingPriority(.required, for: .vertical)
        playerStack.setContentCompressionResistancePriority(.required, for: .vertical)

        playerViews.append(playerStack)
        playerContainerStack.addArrangedSubview(playerStack)
    }

    @IBAction func historyButtonTapped(_ sender: UIButton) {
        let historyVC = HistoryViewController(nibName: "HistoryView", bundle: nil)
        historyVC.history = self.history
        present(historyVC, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistory",
           let historyVC = segue.destination as? HistoryViewController {
            historyVC.history = self.history
        }
    }
}
