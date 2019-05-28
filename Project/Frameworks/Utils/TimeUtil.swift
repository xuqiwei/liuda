//
//  TimeUtil.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/11/5.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import Foundation

/// 时间处理工具类
class TimeUtil {
    
    /// 输出当前时间 yyyyMMddHHmmss
    ///
    /// - Returns: 时间戳字符串
    public static func timestamp() -> String {
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let timestamp = formatter.string(from: Date.init())
        
        return timestamp
    }
    
}
