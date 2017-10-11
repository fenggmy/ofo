//
//  ViewController.swift
//  ofo
//
//  Created by 马异峰 on 2017/10/6.
//  Copyright © 2017年 Yifeng. All rights reserved.
//

import UIKit
import FTIndicator
import SWRevealViewController

class DrawerViewController: UIViewController,MAMapViewDelegate,AMapSearchDelegate,AMapNaviWalkManagerDelegate {
    var mapView : MAMapView!
    var search : AMapSearchAPI!
    var pin : MyPinAnnotation!
    var pinView : MAAnnotationView!
    var nearBySearch = true
    var start,end : CLLocationCoordinate2D!
    var walkManager : AMapNaviWalkManager!
    
    @IBOutlet weak var panelView: UIView!
    @IBAction func locationBtnTap(_ sender: UIButton) {
        nearBySearch = true
        searchBikeNearBy()
    }
    
    //:搜索周边小黄车
    func searchBikeNearBy()  {
        searchCustomerLocation(mapView.userLocation.coordinate)
    }
    
    func searchCustomerLocation(_ center:CLLocationCoordinate2D) {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(center.latitude), longitude: CGFloat(center.longitude))
        
        request.keywords = "餐厅"
        request.radius = 500
        request.requireExtension = true
        search.aMapPOIAroundSearch(request)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let x = view.bounds.height
//        print(x)
        mapView = MAMapView(frame: view.bounds)
        view.addSubview(mapView)
        view.addSubview(panelView)
        
        mapView.delegate = self
        
        mapView.zoomLevel = 17
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        search = AMapSearchAPI()
        search.delegate = self
        
        walkManager = AMapNaviWalkManager()
        walkManager.delegate = self
        
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "Login_Logo"))
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "user_center_icon").withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "gift_icon").withRenderingMode(.alwaysOriginal)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if let revealVC = revealViewController() {
            revealVC.rearViewRevealWidth = self.view.bounds.width * 0.8
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
            view.addGestureRecognizer(revealVC.tapGestureRecognizer())
            
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:大头针动画
    func pinAnimation()  {
        //:坠落动画，y轴加位移
        let endFrame = pinView.frame
        
        pinView.frame = endFrame.offsetBy(dx: 0, dy: -15)
        /*
         usingSpringWithDamping:震动幅度
         initialSpringVelocity:初始速度
         animations：具体动画
         completion：完成之后做什么
         */
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            
            self.pinView.frame = endFrame
        }, completion: nil)
    }
    
    //MARK:Map View Delegate
    
    
    /// 将获取到的导航路线转换成地图上绘制折线所需要的元素
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - overlay: overlay
    /// - Returns: 返回绘制好的折线
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay is MAPolyline {
            
            //:一旦规划路线后，大头针就不在屏幕中心了
            pin.isLockedToScreen = false
            
            //:路线规划后，将当前视图移到该路线上，只对该路线有兴趣
            mapView.visibleMapRect = overlay.boundingMapRect
            
            let renderer = MAPolylineRenderer(overlay: overlay)
            renderer?.lineWidth = 8.0
            renderer?.strokeColor = UIColor.green
            
            return renderer
        }
        return nil
    }
    
    /// 选中小黄车之后规划路线
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - view: 地图上的标注（小黄车的图标）
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        start = pin.coordinate
        end = view.annotation.coordinate
        
        let startPoint = AMapNaviPoint.location(withLatitude: CGFloat(start.latitude), longitude: CGFloat(start.longitude))!
        let endPoint = AMapNaviPoint.location(withLatitude: CGFloat(end.latitude), longitude: CGFloat(end.longitude))!
        
        walkManager.calculateWalkRoute(withStart: [startPoint], end: [endPoint])
        
    }
    
    /// 对红包车以及普通车做一个弹出动画
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - views: 所有的有坐标的标注
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
        let aViews = views as! [MAAnnotationView]
        for aView in aViews{
            //:首先将大头针排除在外
            guard aView.annotation is MAPointAnnotation else{ continue }
            
            aView.transform = CGAffineTransform(scaleX: 0, y: 0)
    
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
                aView.transform = .identity
            }, completion: nil)
        }
        
    }
    
    /// 用户移动地图的交互
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - wasUserAction: 是否是用户的动作
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        if wasUserAction {
            pin.isLockedToScreen = true
            pinAnimation()
            searchCustomerLocation(mapView.centerCoordinate)
        }
    }
    
    /// 地图初始化完成后
    ///
    /// - Parameter mapView: mapView
    func mapInitComplete(_ mapView: MAMapView!) {
        pin = MyPinAnnotation()
        pin.coordinate = mapView.centerCoordinate
        pin.lockedScreenPoint = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        pin.isLockedToScreen = true
        
        mapView.addAnnotation(pin)
//        mapView.showAnnotations([pin], animated: true)
        
        //:启动app时就进行搜索
        searchBikeNearBy()
        
    }
    
    /// 自定义大头针视图
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - annotation: 标注
    /// - Returns: 大头针视图
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        //:用户自定义的位置，不需要自定义
        if annotation is MAUserLocation {
            return nil
        }
        if annotation is MyPinAnnotation {
            let reuseId = "anchor"
            
            var av = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            
            if av == nil{
                av = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            }
            av?.image = #imageLiteral(resourceName: "homePage_wholeAnchor")
            av?.canShowCallout = false
            //:给大头针一个引用
            pinView = av
            
            return av
        }
        
        let reUseId = "myId"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reUseId) as? MAPinAnnotationView
        
        if annotationView == nil {
            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reUseId)
        }
        if annotation.title == "正常可用" {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBike")
        }else{
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBikeRedPacket")
        }
        
        annotationView?.canShowCallout = true
        annotationView?.animatesDrop = true
        
        return annotationView
    }
    
    //MARK:Map Search Delegate
    //:搜索周边完成后的处理
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        guard response.count > 0 else {
            print("周边没有小黄车")
            return
            
        }
        
        var annotations : [MAPointAnnotation] = []
        annotations = response.pois.map{
            let annotation = MAPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.location.latitude), longitude: CLLocationDegrees($0.location.longitude))
            
            if $0.distance < 100 {
                annotation.title = "红包区域内开锁任意小黄车"
                annotation.subtitle = "骑行10分钟可获得现金红包"
                
            }
            else{
                annotation.title = "正常可用"
            }
            return annotation
        }
        mapView.addAnnotations(annotations)
        if nearBySearch {
            mapView.showAnnotations(annotations, animated: true)
            nearBySearch = !nearBySearch
        }
        
    }
    //MARK: AMapNaviWalkManagerDelegate 导航的代理
    
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
        //print("步行路线规划成功")
        //:将地图上的线移除掉
        mapView.removeOverlays(mapView.overlays)
        
        var coordinates = walkManager.naviRoute!.routeCoordinates!.map {
            return CLLocationCoordinate2D(latitude: CLLocationDegrees($0.latitude), longitude: CLLocationDegrees($0.longitude))
        }
        let polyLine = MAPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
        
        mapView.add(polyLine)
        
        //:提示用距离和时间
        let walkMinute = walkManager.naviRoute!.routeTime / 60
        var timeDesc = "1分钟以内"
        if walkMinute > 0 {
            //:将数字转换为字符串
            timeDesc = walkMinute.description + "分钟"
        }
        let hintTitle = "步行" + timeDesc
        let hintSubtitle = "距离" + walkManager.naviRoute!.routeLength.description + "米"
        
        /*
         系统的提示功能
         let alertController = UIAlertController(title: hintTitle, message: hintSubtitle, preferredStyle: .alert)
         let action = UIAlertAction(title: "ok", style: .default, handler: nil)
         alertController.addAction(action)
         self.present(alertController, animated: true, completion: nil)
         */
        
        //:第三方的提示功能
        FTIndicator.setIndicatorStyle(.dark)
        FTIndicator.showNotification(with: #imageLiteral(resourceName: "TimeIcon"), title: hintTitle, message: hintSubtitle)
    }
    //MARK:静态tableview
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "staticTableViewController" && segue.destination .isKind(of: MenuController.self) {
//
//        }
    }
}

