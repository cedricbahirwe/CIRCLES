//
//  ViewController.swift
//  Circles
//
//  Created by Cedric Bahirwe on 5/27/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    var numberOfTouches: Int = 0
    var counter: Int = 0
    var timer = Timer()
    var targetScore = 380
    
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        targetScore = getTargetScore()
        print("My size is", view .frame.width, view.frame.height)
        print("My bounds are", view.bounds.width, view.bounds.height)
        view.backgroundColor = .black
        playView.backgroundColor = .black
        DispatchQueue.main.async {
            self.showAlert()
        }
        print(SessionManager.instance.winners)
    }
    
    func getTargetScore() -> Int {
        let defaultSurface = Int(304704) // ACCORDING TO IPHONE 6S DIMENSIONS
        let defaultTargetSCore = 350 // ACCORDING TO IPHONE 6S DIMENSIONS
        let width = view.bounds.width
        let height = view.bounds.height
        let playableSurface = Int(width * height)
        let targetScore = Int((playableSurface * defaultTargetSCore ) / defaultSurface)
        return targetScore
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let circleCenter = touch.location(in: view)
            let circleWidth = CGFloat(25 + (arc4random() % 50))
            let circleHeight = circleWidth
            let circleView = CircleView(frame: CGRect(x: circleCenter.x, y: circleCenter.y, width: circleWidth, height: circleHeight))
            circleView.alpha = 0
            UIView.animate(withDuration: 0.2) {
                circleView.alpha = 1
            }
            playView.addSubview(circleView)

        }
        numberOfTouches += 1
        updateScoreLabel(score: numberOfTouches)
        
    }
    func showAlert() {
        let alertVC = UIAlertController(title: "You gonna start the game", message: "The goal is to get the maximum number of touches in a fixed amount of time, Good Luck!!! 🧧", preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Start", style: .default) { (_) in
            DispatchQueue.main.async {
                self.timerLabel.isHidden = false
                self.timer.invalidate()
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.upCountTimer), userInfo: nil, repeats: true)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                self.timer.invalidate()
                 var message = ""
                if self.numberOfTouches >= self.targetScore {
                    message = "You won!😄"
                } else {
                  message = "You loose!☹️"
                }
                SessionManager.instance.bestScore = self.numberOfTouches
                self.alertForWinner(title: "Game Over!!!", message:  "\(message), Your score is \(self.numberOfTouches) and the target score is \(self.targetScore)", actions: [])
            }
        }
        alertVC.addAction(dismissAction)
        present(alertVC, animated: true)
        
    }
    
    @objc func upCountTimer(){
        counter += 1
        timerLabel.text = getReadableTimeFormat(amount: counter, type: "i")
    }
    
    func getReadableTimeFormat(amount: Int, type: String) -> String {
        let (hrs, minsec) = amount.quotientAndRemainder(dividingBy: 3600)
        let (min, sec) = minsec.quotientAndRemainder(dividingBy: 60)
        
        return type == "c" ? "\(hrs)h:\(min)m" : "\(hrs):\(min):\(sec)"
    }
    func updateScoreLabel(score: Int) {
        scoreLabel.text = String(describing: score)
        
    }
}


extension ViewController {
    func dispLayAlert(title: String, message: String, actions: [UIAlertAction], preferredStyle: UIAlertController.Style = .actionSheet ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { (alertAction) in
            alert.addAction(alertAction)
        }
        present(alert, animated: true)
    }
    func alertForWinner(title: String, message: String, actions: [UIAlertAction], preferredStyle: UIAlertController.Style = .actionSheet ){
        let alert = UIAlertController(title:  title, message: message, preferredStyle: .alert)
        var nameString = ""

        let updateAction = UIAlertAction(title: "Save", style: .default, handler: {
            [weak alert] (_) in
            let textField = alert?.textFields![0]
            nameString = textField!.text!
            SessionManager.instance.winners[nameString] = self.numberOfTouches
            
        })
        alert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Enter your name"
            updateAction.isEnabled = false
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nameTextField, queue: OperationQueue.main) { (notification) in
                updateAction.isEnabled = nameTextField.text!.trimmingCharacters(in: .whitespaces).count > 0
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(updateAction)
        actions.forEach { (action) in
            alert.addAction(action)
        }
        
        present(alert, animated: true, completion: nil)
    }
}
