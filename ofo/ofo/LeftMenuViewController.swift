//
//  LeftMenuViewController.swift
//  ofo
//
//  Created by 马异峰 on 2017/10/9.
//  Copyright © 2017年 Yifeng. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController {
    
    fileprivate let cellIdentifier = "MyCellIdentifier"
    //    weak var delegate: LeftMenuViewControllerDelegate?
    let headerViewH: CGFloat = UIScreen.main.bounds.height * 0.23
    
    var dataArray = [["我的行程","icon_slide_trip2"],["我的钱包","icon_slide_wallet2"],["邀请好友","icon_slide_invite2"],["兑优惠券","icon_slide_coupon2"],["我的客服","icon_slide_usage_guild2"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        
    }
    
    private lazy var tableView: UITableView = {
        
        let tab = UITableView(frame: CGRect(x: 0, y: self.headerViewH, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.37), style: .plain)
        //tab.backgroundColor = UIColor(colorLiteralRed: 13.0 / 255.0, green: 184.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        tab.backgroundColor = UIColor.ofo
        tab.separatorStyle = UITableViewCellSeparatorStyle.none
        tab.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tab.delegate = self
        tab.dataSource = self
        tab.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        return tab
    }()
    
    private lazy var headerView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.headerViewH))
        let bgImageView = UIImageView(frame: view.frame)
        bgImageView.image = UIImage(named: "ComeInbanner")
        bgImageView.contentMode = UIViewContentMode.scaleAspectFill
        
        bgImageView.clipsToBounds = true
        view.addSubview(bgImageView)
        return view
        
    }()
    
}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = dataArray[indexPath.row][0]
        cell.imageView?.image = UIImage(named: dataArray[indexPath.row][1])
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        vc.title = dataArray[indexPath.row][0]
        DrawerViewController.shareDrawer?.LeftViewController(didSelectController: vc)
        
    }
}
