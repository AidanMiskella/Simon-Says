//
//  ViewController.swift
//  Simon Says
//
//  Created by Aidan Miskella on 31/03/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colourButtons: [CircularButton]!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet var playerName: [UILabel]!
    @IBOutlet var scoreLabels: [UILabel]!
    
    var currentPlayer = 0
    var scores = [0,0]
    
    var sequenceIndex = 0
    var colourSequence = [Int]()
    var colourToTap = [Int]()
    
    var gameEnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sortButtonTags()
        createNewGame()
    }
    
    func sortButtonTags() {
        
        colourButtons = colourButtons.sorted() {
            $0.tag < $1.tag
        }
        
        playerName = playerName.sorted() {
            $0.tag < $1.tag
        }
        
        scoreLabels = scoreLabels.sorted() {
            $0.tag < $1.tag
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameEnded {
            
            gameEnded = false
            createNewGame()
        } else {
            
            
        }
    }

    func createNewGame() {
        colourSequence.removeAll()
        
        actionButton.setTitle("Start Game", for: .normal)
        actionButton.isEnabled = true
        
        for button in colourButtons {
            
            button.alpha = 0.5
            button.isEnabled = false
        }
        
        currentPlayer = 0
        scores = [0,0]
        
        playerName[currentPlayer].alpha = 1.0
        playerName[1].alpha = 0.75
        updateScoreLabels()
    }
    
    func updateScoreLabels() {
        
        for (index, label) in scoreLabels.enumerated() {
            
            label.text = "\(scores[index])"
        }
    }
    
    func switchPlayers() {
        
        playerName[currentPlayer].alpha = 0.75
        currentPlayer = currentPlayer == 0 ? 1 : 0
        playerName[currentPlayer].alpha = 1.0
    }
    
    func addNewColour() {
        
        colourSequence.append(Int(arc4random_uniform(UInt32(4))))
        
    }
    
    func playSequence() {
        
        if sequenceIndex < colourSequence.count {
            
            flash(button: colourButtons[colourSequence[sequenceIndex]])
            sequenceIndex += 1
        } else {
            
            colourToTap = colourSequence
            view.isUserInteractionEnabled = true
            actionButton.setTitle("Tap the Circles", for: .normal)
            
            for button in colourButtons {
                
                button.isEnabled = true
            }
        }
    }
    
    func flash(button: CircularButton) {
        
        UIView.animate(withDuration: 0.5, animations: {
            button.alpha = 1.0
            button.alpha = 0.5
        }) { (Bool) in
            
            self.playSequence()
        }
    }
    
    func endGame() {
        
        let message = currentPlayer == 0 ? "Player 2 wins!" : "Player 1 wins!"
        actionButton.setTitle(message, for: .normal)
        gameEnded = true
    }
    
    @IBAction func colourButtonHandler(_ sender: CircularButton) {
        
        if sender.tag == colourToTap.removeFirst() {
            
            
        } else {
            
            for button in colourButtons {
                
                button.isEnabled = false
            }
            
            endGame()
            return
        }
        
        if colourToTap.isEmpty {
            
            for button in colourButtons {
                
                button.isEnabled = false
            }
            
            scores[currentPlayer] += 1
            updateScoreLabels()
            switchPlayers()
            
            actionButton.setTitle("Continue", for: .normal)
            actionButton.isEnabled = true
        }
    }
    
    @IBAction func actionButtonHandler(_ sender: UIButton) {
        
        sequenceIndex = 0
        actionButton.setTitle("Memorize", for: .normal)
        actionButton.isEnabled = false
        view.isUserInteractionEnabled = false
        
        addNewColour()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            self.playSequence()
        }
    }
    
}

