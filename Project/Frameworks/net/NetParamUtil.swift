//
//  NetParamUtil.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/11/5.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import Foundation

fileprivate let BID = "1002"
fileprivate let VERSION = "v1.0.0"
fileprivate let KEY = "37cx75atx45pi9biowo709o1a38c49m"


/// 数据请求参数处理
class NetParamUtil {
    
    public static func paramsFor(dic : Dictionary<String, String>?) -> Dictionary<String, String> {
        
        var params = dic ?? Dictionary<String, String>()
        
        params.updateValue(BID, forKey: "bid")
        params.updateValue(VERSION, forKey: "version")
        params.updateValue(TimeUtil.timestamp(), forKey: "timestamp")
        
        var paramStr : String = ""
        var keyArr = [String]()
        keyArr = params.keys.sorted(by: { (key1 : String, key2 : String) -> Bool in
            return key1.localizedStandardCompare(key2) == ComparisonResult.orderedAscending
        })
        for key in keyArr {
            paramStr = paramStr + key + "=" + params[key]! + "&"
        }
        paramStr = paramStr + "key" + "=" + KEY
        params.updateValue(paramStr.md5(), forKey: "sign")
        
        return params
    }
}
 
