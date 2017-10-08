//
//  disPlayController.swift
//  ofo
//
//  Created by 马异峰 on 2017/10/8.
//  Copyright © 2017年 Yifeng. All rights reserved.
//

import UIKit
import SwiftyTimer
import SwiftySound
import FTIndicator

class disPlayController: UIViewController {
    
    //:车牌以及解锁码
    var code = 0
    var passcode = 0
    
    var remindSeconds = 121
    var isTorchOn = true
    var isVoiceOn = true
    let defaults = UserDefaults.standard
    
    @IBAction func backItemTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reportBtnTap(_ sender: UIButton) {
        /*
         没有导航，就dismiss，返回上一级控制器
         有导航，就POP，返回上一级控制器
         */
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var countDownLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.every(1) { (timer : Timer) in
            self.remindSeconds -= 1
           self.countDownLabel.text = self.remindSeconds.description
            if self.remindSeconds == 0{
                timer.invalidate()
            }
        }
        Sound.play(file: "您的解锁码为_D.m4a")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
