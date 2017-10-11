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
@IBDesignable class MyPreviewButton : UIButton{
    
}

import AVFoundation
func turnTorch()  {
    guard let device = AVCaptureDevice.default(for : AVMediaType.video) else {
        print("初始化出错")
        return
    }
    if device.hasTorch && device.isTorchAvailable {
        try?device.lockForConfiguration()
        //print("后置摄像头正常工作")
        if device.torchMode == .off{
            device.torchMode = .on
        }else{
            device.torchMode = .off
        }
        
        device.unlockForConfiguration()
    }
        /*
     else if !device.hasTorch{
     print("无后置摄像头")
     }
     else if !device.isTorchAvailable{
     print("后置摄像头被其他程序占用")
     }
         */
    
}

