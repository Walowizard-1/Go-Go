//
//  ViewController.swift
//  Red or Blue
//
//  Created by Bulmaro Garcia on 4/5/20.
//  Copyright © 2020 Bulmaro Garcia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var redOrBlueButton: UIButton!
    @IBOutlet weak var redButtonClicked: UIButton!
    @IBOutlet weak var blueButtonClicked: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButtonLabel: UIButton!
    
    @IBOutlet weak var introLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var popUpView: UIView!
    
    @IBOutlet var blurView: UIVisualEffectView!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var gameTotalScoreLabel: UILabel!
    
    @IBOutlet weak var playAgainButtonClicked: UIButton!
    

    let marioFont = "SuperMarioGalaxy"
    
    var soundEffect: AVAudioPlayer = AVAudioPlayer()
    
    
    let colors = [UIColor.red.cgColor.copy(alpha: 0.5), UIColor.blue.cgColor.copy(alpha: 0.5)]
    var random = Int.random(in: 0...1)
    var score = 0
    var count = 60
    var timer: Timer!
    var highscore = 0
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBackground()
        redOrBlueButtonConfiguration()
        redButtonClickedConfiguration()
        blueButtonClickedConfiguration()
        soundConfiguration()
        scoreAndTimerFontSetUp()
        scoreLabel.isHidden = true
        timerLabel.isHidden = true
        // sets blur view size to size view
        blurView.bounds = self.view.bounds
        popUpView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
        
        startButtonConfiguration()
       // startButtonLabel.layer.cornerRadius = 10
             
        timerLabel.text = String(60)
       
        
        preStartGame()
   
    }
    // contains score at start of game
    func preStartGame() {
        score = 0

    }
    // configures start button
    func startButtonConfiguration(){
        startButtonLabel.layer.cornerRadius = 10
        startButtonLabel.layer.borderWidth = 4
        startButtonLabel.layer.borderColor = UIColor.green.cgColor
    }
    // sets score and time labels to mario font
    func scoreAndTimerFontSetUp(){
        scoreLabel.font = UIFont(name: marioFont, size: 40)
        timerLabel.font = UIFont(name: marioFont, size: 40)
    }
    // adds sound when red and blue buttons are clicked
    func soundConfiguration(){
        // allows mixable sounds in background along with program sound by setting as
        // ambient rather than soloAmbient
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        try? AVAudioSession.sharedInstance().setActive(true)
        // sets sound to play 
        let soundFile = Bundle.main.path(forResource: "successJingle", ofType: ".wav")
              
        do {
            try soundEffect = AVAudioPlayer(contentsOf: URL (fileURLWithPath: soundFile!))
        }
        catch{
            print(error)
        }
    }
    // sets background
    func setBackground(){
        
        let backgroundImageView = UIImageView()
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "benjamin-catapane-Pn7JBX42z3Q-unsplash")
        self.view.sendSubviewToBack(backgroundImageView)
        
    }
    // configures display button
    func redOrBlueButtonConfiguration(){
        
        redOrBlueButton.layer.cornerRadius = 40
        redOrBlueButton.layer.borderWidth = 7
        redOrBlueButton.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.75)
        redOrBlueButton.layer.shadowRadius = 7
        redOrBlueButton.layer.shadowColor = UIColor.black.cgColor
        redOrBlueButton.layer.shadowOpacity = 0.5
    }
    // contains redButton configuration
    func redButtonClickedConfiguration(){
        redButtonClicked.layer.cornerRadius = 25
        redButtonClicked.layer.shadowRadius = 4
        redButtonClicked.layer.shadowColor = UIColor.black.cgColor
        redButtonClicked.layer.shadowOpacity = 0.5
    }
    // contains blue button configuration
    func blueButtonClickedConfiguration(){
        blueButtonClicked.layer.cornerRadius = 25
       blueButtonClicked.layer.shadowRadius = 4
       blueButtonClicked.layer.shadowColor = UIColor.black.cgColor
       blueButtonClicked.layer.shadowOpacity = 0.5
    }
    // info on functionality for red button
    @IBAction func redButtonTapped(_ sender: UIButton) {
    
        if redOrBlueButton.layer.backgroundColor == UIColor.red.cgColor.copy(alpha: 0.5) {
            soundEffect.play()
            score += 1
            self.scoreLabel.text = String(score)
                   
        } else {
            self.scoreLabel.text = String(score)
            self.timer.invalidate()
            settingScores()
            animateIn(desiredView: blurView)
            animateIn(desiredView: popUpView)
        }
        
        redOrBlueButton.layer.backgroundColor = colors[Int.random(in: 0...1)]
        
    }
    // blue button functionality
    @IBAction func blueButtonTapped(_ sender: UIButton) {
        
        if redOrBlueButton.layer.backgroundColor == UIColor.blue.cgColor.copy(alpha: 0.5) {
            soundEffect.play()
            score += 1
            self.scoreLabel.text = String(score)
        } else {
            self.timer.invalidate()
            settingScores()
            animateIn(desiredView: blurView)
            animateIn(desiredView: popUpView)
        }
         redOrBlueButton.layer.backgroundColor = colors[Int.random(in: 0...1)]
    }
    // start button functionality
    @IBAction func startButtonPressed(_ sender: Any) {
        introLabel.isHidden = true
        timerLabel.isHidden = false
        scoreLabel.isHidden = false
        startButtonLabel.isHidden = true
        
        redOrBlueButton.layer.backgroundColor = colors[Int.random(in: 0...1)]
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
        count -= 1
        timerLabel.text = String(count)
        
    }
    // timer functionality
    @objc func timerCount() {
        count -= 1
        timerLabel.text = String(count)
        if count <= 0{
            timer.invalidate()
            animateIn(desiredView: blurView)
            animateIn(desiredView: popUpView)
        }
    }
    // play again
     func playAgain() {
        scoreLabel.text = String(0)
        timerLabel.text = String(60)
        startButtonLabel.isHidden = false
        count = 60
        score = 0
    }
    // sets scores
    func settingScores() {
        gameTotalScoreLabel.text = String(score)
        gameTotalScoreLabel.font = UIFont(name: marioFont, size: 24)
        highScoreLabel.font = UIFont(name: marioFont, size: 24)
        
        if score > highscore {
            highscore = score
            highScoreLabel.text = String(highscore)
        }
        highScoreLabel.text = String(highscore)
    }
    
    // Animate-in a specified view
    func animateIn(desiredView: UIView) {
        let backgroundView = self.view!
        
        
        // attach desired view to screen view
        backgroundView.addSubview(desiredView)
        
        // sets desired view to 120% (start)
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        // animates ends-at
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        })
    }
    // animates desired view animation removal
    func animateOut(desiredView: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: { _ in
            desiredView.removeFromSuperview()
        })
    }
    
    // adds functionality to play again button when pressed 
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        playAgain()
        animateOut(desiredView: popUpView)
        animateOut(desiredView: blurView)
    }

}

