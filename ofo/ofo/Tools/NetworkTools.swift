//
//  NetworkTools.swift
//  ofo
//
//  Created by 马异峰 on 2017/10/8.
//  Copyright © 2017年 Yifeng. All rights reserved.
//

import AVOSCloud
struct NetworkTools {
    
}

extension NetworkTools{
    static func getPasscode(code : String,completion : @escaping (String?) -> Void)  {
        let query = AVQuery(className: "Code")
        query.whereKey("Code_Num", equalTo: code)
        query.getFirstObjectInBackground { (code, error) in
            if let error = error {
                print("出错",error.localizedDescription)
                completion(nil)
            }
            if let code = code,let passcode = code["passcode"] as? String{
                completion(passcode)
            }
        }
        
    }
}
