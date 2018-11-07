//
//  ViewController.swift
//  BullsAnotherEye
//
//  Created by 李大伟 on 2018/11/5.
//  Copyright © 2018年 李大伟. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    /* target */
    @IBOutlet weak var targetLabel: UILabel!
    var targetValue: Int = 0
    
    /* about slider */
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var minLabel: UILabel!
    var minValue: Int = 0
    
    @IBOutlet weak var maxLabel: UILabel!
    var maxValue: Int = 100
    
    @IBOutlet weak var sliderLabel: UILabel!
    var sliderValue: Int = 0
    
    /* round */
    @IBOutlet weak var roundLabel: UILabel!
    var roundValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadAssets()
        self.endAndStartNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func restart() {
        let alert = UIAlertController(title: "提示", message: "确定要重新开始游戏吗？", preferredStyle: .alert)

        let sureAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            self.restartImpl()
        })
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        alert.addAction(sureAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func loadAssets() {
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let sliderLeft = UIImage(named: "slider_left")!
        let sliderLeftResizable = sliderLeft.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(sliderLeftResizable, for: .normal)
        
        let sliderRight = UIImage(named: "slider_right")!
        let sliderRightResizable = sliderRight.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(sliderRightResizable, for: .normal)
        
        let sliderCursorNormal = UIImage(named: "football_normal")!
        slider.setThumbImage(sliderCursorNormal, for: .normal)
        
        let sliderCursorHighLight = UIImage(named: "football_highlighted")!
        slider.setThumbImage(sliderCursorHighLight, for: .highlighted)
    }
    
    func restartImpl() {
        self.roundValue = 0
        self.endAndStartNewRound()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    func endRound() {
        self.resetSlider()
    }
    
    func startRound() {
        self.updateTargetLabel()
        self.updateRoundLabel()
    }
    
    func endAndStartNewRound() {
        self.endRound()
        self.startRound()
    }
    
    func resetSlider() {
        self.sliderValue = (self.maxValue + self.minValue) / 2
        
        slider.maximumValue = Float(self.maxValue)
        slider.minimumValue = Float(self.minValue)
        slider.value = Float(self.sliderValue)
        maxLabel.text = String(self.maxValue)
        minLabel.text = String(self.minValue)
        sliderLabel.text = String(self.sliderValue)
    }
    
    func updateRoundLabel() {
        self.roundValue += 1
        roundLabel.text = String(self.roundValue)
    }
    
    func updateTargetLabel() {
        self.targetValue = Int(arc4random_uniform(100)) + 1
        targetLabel.text = String(self.targetValue)
    }

    @IBAction func sliderMoving(_ slider: UISlider) {
        self.sliderValue = lroundf(slider.value)
        // sliderLabel.text = String(self.sliderValue)
        sliderLabel.text = "*"
    }
    
    @IBAction func settleRound() {
        let actionText = "确定"
        var alertTitle: String
        var action: UIAlertAction
        let alertText = "目标 :\(self.targetValue)" + "\n" + "当前 :\(self.sliderValue)"
        
        if(self.targetValue == self.sliderValue) {
            alertTitle = "成功"
            action = UIAlertAction(title: actionText, style: .default, handler: {
                action in
                self.endAndStartNewRound()
            })
        }
        else {
            alertTitle = "失败"
            action = UIAlertAction(title: actionText, style: .default, handler: {
                action in
                self.endRound()
            })
        }
        
        let alert = UIAlertController(title: alertTitle, message: alertText, preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
}
