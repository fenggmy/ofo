//
//  ScanController.swift
//  ofo
//
//  Created by 马异峰 on 2017/10/7.
//  Copyright © 2017年 Yifeng. All rights reserved.
//

import UIKit
import AVFoundation

class ScanController: UIViewController {

    var isFlashOn = false
    @IBAction func flashBtnTap(_ sender: UIButton) {
        turnTorch()
        isFlashOn = !isFlashOn
        if isFlashOn {
            flashBtn.setImage(#imageLiteral(resourceName: "手电筒_高亮"), for: .normal)
        }else{
            flashBtn.setImage(#imageLiteral(resourceName: "手电筒"), for: .normal)
        }
    }
    @IBOutlet weak var flashBtn: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.title = "扫码用车"
//        navigationController?.navigationBar.barStyle = .blackTranslucent
//        navigationController?.navigationBar.tintColor = UIColor.clear
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        //:将“车辆解锁”界面的左边返回按钮的title设置为空
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
