//
//  sideBarController.swift
//  ofo
//
//  Created by 马异峰 on 2017/10/9.
//  Copyright © 2017年 Yifeng. All rights reserved.
//

import UIKit

class sideBarController: UIViewController {

    @IBOutlet weak var userInfo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(userInfo)
        // Do any additional setup after loading the view.
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
