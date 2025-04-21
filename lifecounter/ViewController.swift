//
//  ViewController.swift
//  lifecounter
//
//  Created by Amelia Li on 4/20/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player1Lost: UILabel!
    
    var player1Life = 20
    var player2Life = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        player1Lost.isHidden = true
    }
    
    func updateUI() {
        player1Lost.isHidden = player1Life >= 0
    }

    
    @IBAction func player1Minus1(_ sender: Any) {
        player1Life = player1Life - 1
        player1Label.text = "Remaining Life: \(player1Life)"
        updateUI()
    }
    
    
    @IBAction func player1Add1(_ sender: Any) {
        player1Life = player1Life + 1
        player1Label.text = "Remaining Life: \(player1Life)"
        updateUI()
    }
    
    
    @IBAction func player1Minus5(_ sender: Any) {
        player1Life = player1Life - 5
        player1Label.text = "Remaining Life: \(player1Life)"
        updateUI()
    }
    
    
    @IBAction func player1Add5(_ sender: Any) {
        player1Life = player1Life + 5
        player1Label.text = "Remaining Life: \(player1Life)"
        updateUI()
    }
    
}
