//
//  ViewController.swift
//  countdown
//
//  Created by 蔡佳穎 on 2021/5/6.
//

import UIKit
import Foundation
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet weak var workDayBtn: UIButton!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var workDayLabel: UILabel!
    
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var workDayDatePicker: UIDatePicker!
    
    @IBOutlet weak var countDownView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hrsLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //獲得今天日期
        let today = Date()
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: today)
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateString = dateFormatter.string(from: today)
        todayLabel.text = dateString
        print(dateString)
        
        //datePickerView、workDayLabel隱藏
        datePickerView.isHidden = true
        workDayLabel.isHidden = true
    }

    @IBAction func appearDatePicker(_ sender: UIButton) {
        datePickerView.isHidden = false
    }
    
    @IBAction func closeDatePickerAndCountdown(_ sender: UIButton) {
        datePickerView.isHidden = true
        
        //取得使用者輸入的工作日
        let workDay = workDayDatePicker.date
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let workDayString = dateFormatter.string(from: workDay)
        workDayLabel.text = workDayString
        workDayLabel.sizeToFit()
        
        //倒數
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self]_ in
            let interval = Int(workDay.timeIntervalSinceNow)
            let day = interval / 60 / 60 / 24
            let hrs = interval / 60 / 60 % 24
            let min = interval / 60 % 60
            let sec = interval % 60

            self.secLabel.text = "\(sec)"
            self.minLabel.text = "\(min)"
            self.hrsLabel.text = "\(hrs)"
            self.dayLabel.text = "\(day)"
            self.dayLabel.sizeToFit()
            self.dayLabel.center = CGPoint(x: 122.5, y: 92)
        }
        
        //顯示workDayLabel、Btn隱藏
        workDayLabel.isHidden = false
        workDayLabel.frame = CGRect(x: 213, y: 110, width: 125, height: 28)
        workDayBtn.isHidden = true
        
        //火焰效果
        let skView = SKView(frame: view.frame)
        view.insertSubview(skView, at: 0)
        
        let scene = SKScene(size: skView.frame.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.2)
        
        let emitterNode = SKEmitterNode(fileNamed: "MyFireParticle")
        scene.addChild(emitterNode!)
        
        skView.presentScene(scene)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if timer != nil {
            timer?.invalidate()
        }
    }
}



