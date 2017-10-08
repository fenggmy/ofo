//
//  UIViewTools.swift
//  ofo
//
//  Created by 马异峰 on 2017/10/8.
//  Copyright © 2017年 Yifeng. All rights reserved.
//

//:对所有UIView扩展了两个计算属性borderWidth，barderColor
extension UIView{
    //:@IBInspectable:可以让属性在storyboard上进行显示
   @IBInspectable var borderWidth : CGFloat{
        get{
            return self.layer.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var barderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
}
@IBDesignable class MyPreviewLabel : UILabel{
    
}

import AVFoundation
func turnTorch()  {
    guard let device = AVCaptureDevice.default(for : AVMediaType.video) else {
        return
    }
    if device.hasTorch && device.isTorchAvailable {
        try?device.lockForConfiguration()
        
        if device.torchMode == .off{
            device.torchMode = .on
        }else{
            device.torchMode = .off
        }
        
        device.unlockForConfiguration()
    }
}

//import SwiftySound

func voiceBtnStatus(voiceBtn : UIButton)  {
    let defaults = UserDefaults.standard
    
    if defaults.bool(forKey: "isVoiceOn") {
       // Sound.play(file: "上车前_LH.m4a")
        voiceBtn.setImage(#imageLiteral(resourceName: "voice_icon"), for: .normal)
    }else{
        voiceBtn.setImage(#imageLiteral(resourceName: "voice_close"), for: .normal)
    }
}

func torchBtnStatus(torchBtn : UIButton)  {
    let defaults_torch = UserDefaults.standard
    if defaults_torch.bool(forKey: "isVoiceOn") {
        // Sound.play(file: "上车前_LH.m4a")
        torchBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch_w"), for: .normal)
    }else{
        torchBtn.setImage(#imageLiteral(resourceName: "btn_torch_disable"), for: .normal)
    }
}

