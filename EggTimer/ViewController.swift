import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progresBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimer = ["Soft": 5, "Medium": 8, "Hard": 12]
    
    var timer = Timer()
    var totalTime = 0
    var SecondsPass = 0
    var player: AVAudioPlayer?
    
    @IBAction func HardNess(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        totalTime = eggTimer[hardness]!
        progresBar.progress = 0.0
        SecondsPass = 0
        titleLabel.text = hardness
          
        timer.invalidate()  // Stop any previous timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if SecondsPass < totalTime {
            SecondsPass += 1
            progresBar.progress = Float(SecondsPass) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        if let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

