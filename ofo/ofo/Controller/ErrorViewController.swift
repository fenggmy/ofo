//
//  ErrorViewController.swift
//  ofo
//
//  Created by 马异峰 on 2017/10/8.
//  Copyright © 2017年 Yifeng. All rights reserved.
//

import UIKit
import MIBlurPopup

class ErrorViewController: UIViewController {

    @IBAction func gestureTap(_ sender: UITapGestureRecognizer) {
        self.close()
    }
    @IBOutlet weak var myPopView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtnTap(_ sender: Any) {
        close()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func close()  {
        dismiss(animated: true, completion: nil)
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
extension ErrorViewController: MIBlurPopupDelegate{
    var popupView: UIView{
        return myPopView
    }
    var blurEffectStyle: UIBlurEffectStyle{
        return .dark
    }
    var initialScaleAmmount: CGFloat{
        return 0.2
    }
    var animationDuration: TimeInterval{
        return 0.2
    }
    
}
