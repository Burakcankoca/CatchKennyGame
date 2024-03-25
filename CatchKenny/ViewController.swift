//
//  ViewController.swift
//  CatchKenny
//
//  Created by Burak Can Koca on 25.03.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    var score = 0
    var time = 10
    var kennyArray = [UIImageView]()
    var highScore = 0
    var timer = Timer()
    var timer2 = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Highscore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        scoreLabel.text = "Score : \(score)"
        timeLabel.text = "\(time)"
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)

        kennyArray.append(kenny1)
        kennyArray.append(kenny2)
        kennyArray.append(kenny3)
        kennyArray.append(kenny4)
        kennyArray.append(kenny5)
        kennyArray.append(kenny6)
        kennyArray.append(kenny7)
        kennyArray.append(kenny8)
        kennyArray.append(kenny9)
        hideKenny()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFunc), userInfo: nil, repeats: true)
    }
    @objc func increaseScore(){
        score += 1
        
        scoreLabel.text = "Score : \(score)"
        
    }
    @objc func timeFunc(){
        time -= 1
        timeLabel.text = "\(time)"
        if time == 0{
            timer2.invalidate()
            timer.invalidate()
            timeLabel.text = "Time's Up"
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            //HighScore
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
            }
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Game Over", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){(UIAlertAction) in
                
                //Replay function
                self.score = 0
                self.time = 10
                self.scoreLabel.text = "Score : \(self.score)"
                self.timeLabel.text = "\(self.time)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                self.timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeFunc), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            present(alert, animated: true)
        }
    }
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        kennyArray.randomElement()?.isHidden = false
    }

}

