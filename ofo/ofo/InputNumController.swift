//
//  InputNumController.swift
//  ofo
//
//  Created by 马异峰 on 2017/10/7.
//  Copyright © 2017年 Yifeng. All rights reserved.
//

import UIKit
import APNumberPad

class InputNumController: UIViewController,APNumberPadDelegate,UITextFieldDelegate {

    var isFlashOn = true
    var isVoiceOn = true
    
    @IBOutlet weak var goBtn: UIButton!
    @IBAction func scanBtnTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var scanBtn: UIButton!
    @IBAction func voiceBtnTap(_ sender: UIButton) {
        
        isVoiceOn = !isVoiceOn
        if isVoiceOn {
            voiceBtn.setImage(#imageLiteral(resourceName: "voice_icon"), for: .normal)
        } else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voice_close"), for: .normal)
        }
        
    }
    @IBOutlet weak var voiceBtn: UIButton!
    @IBAction func flashBtnTap(_ sender: UIButton) {
        
        if isFlashOn {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch_w"), for: .normal)
        } else {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_torch_disable"), for: .normal)
        }
        isFlashOn = !isFlashOn
    }
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "车辆解锁"
        //:247 215 80
        inputTextField.layer.borderWidth = 2
        inputTextField.layer.borderColor = UIColor.ofo.cgColor
        
        let numberPad = APNumberPad(delegate: self)
        numberPad.leftFunctionButton.setTitle("确定", for: .normal)
        inputTextField.inputView = numberPad
        inputTextField.delegate = self
    }

    //:左下角功能键的定制
    func numberPad(_ numberPad: APNumberPad, functionButtonAction functionButton: UIButton, textInput: UIResponder & UITextInput) {
        print("你点了我")
    }
    
    //:限制输入数字位数为4
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = inputTextField.text else {
            return true
        }
        let newLength = textField.characters.count + string.characters.count - range.length
        
        if newLength > 0 {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_enable"), for: .normal)
            goBtn.backgroundColor = UIColor.ofo
        } else {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_unenable"), for: .normal)
            goBtn.backgroundColor = UIColor.groupTableViewBackground
            
        }
        return newLength <= 4
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //:使虚拟键盘回收，不再作为第一消息响应者
        self.inputTextField.resignFirstResponder()
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
