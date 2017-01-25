//
//  ViewController.swift
//  Tap of War
//
//  Created by FNU Richard on 1/23/17.
//  Copyright © 2017 cookiesNcream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Intros UI elements
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    
    //Play Buttons
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var botButton: UIButton!
    
    //Line between play buttons
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!

    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    //get screen height
    let screenHeight:Double = Double(UIScreen.main.bounds.height)
    
    var centerLine:Double  = 0
    
    var incriment:Double = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //console.
        updateUI()
        resetButton.isEnabled = false
        topButton.isEnabled = false
        botButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func topButtonTapped(_ sender: UIButton) {
        ////when top button is pressed move top bar down
        UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
            self.centerConstraint.constant += 20.0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
        //track where the line between 2 bars are
        centerLine += 20.0
        
        //this is debugger
            //print("center Line now is: \(centerLine)")
        
        //if top bar reaches the end of the screen player 1 won
        if(centerLine > screenHeight){
            winnerLabel.text = "Orange Won!"
            updateGameOverUI()
        }
    }
    
    @IBAction func botButtonTapped(_ sender: UIButton) {
        //when bottom button is pressed move bottom bar up
        UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.centerConstraint.constant -= 20.0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
        //track where the line between 2 bars are
        centerLine -= 20.0
        
        //Debugger
            //print("center Line now is: \(centerLine)")
        
        //if bottom bar fills the screen, from bottom to top, player 2 won
        if(centerLine < 0){
            winnerLabel.text = "Blue Won!"
            updateGameOverUI()
        }
        
        
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        //update UI element when start button is pressed
        introLabel.text = " "
        introLabel.isEnabled = false
        startButton.setTitle(" ", for: .normal)
        startButton.isEnabled = false
        topButton.isEnabled = true
        botButton.isEnabled = true
    }
    
    
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        updateUI()
    }
    
    
    func updateGameOverUI(){
        //update UI elements when game is over
        topButton.isEnabled = false
        botButton.isEnabled = false
        resetButton.isEnabled = true
        resetButton.setTitle("Play Again",for: .normal)
    }
    
    func updateUI() {
        //start the game
        centerLine = screenHeight / 2.0
        topButton.isEnabled = true
        botButton.isEnabled = true
        
        //animate the bars back to it's original position
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            self.centerConstraint.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
        winnerLabel.text = " "
        resetButton.setTitle(" ", for: .normal)
    }
}

