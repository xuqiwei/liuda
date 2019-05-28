//
//  MacroTool.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/11/30.
//  Copyright © 2018 徐其威. All rights reserved.
//

import Foundation


public let infoDictionary = Bundle.main.infoDictionary!
public let appDisplayName = infoDictionary["CFBundleDisplayName"] //程序名称
public let majorVersion = infoDictionary["CFBundleShortVersionString"]//主程序版本号
public let minorVersion = infoDictionary["CFBundleVersion"]//版本号（内部标示）
public let appVersion = majorVersion as! String

public let systemVersion = UIDevice.current.systemVersion

public let S_Width = UIScreen.main.bounds.size.width
public let S_Height = UIScreen.main.bounds.size.height

///过滤null对象
public let FilterNullOfObj:((Any)->Any?) = {(obj: Any) -> Any? in
    if obj is NSNull {
        return nil
    }
    return obj
}

///过滤null的字符串，当nil时返回一个初始化的空字符串
public let FilterNullOfString:((Any)->String) = {(obj: Any) -> String in
    if obj is String {
        return obj as! String
    }
    return ""
}

/// 过滤null的数组，当nil时返回一个初始化的空数组
public let FilterNullOfArray:((Any)->Array<Any>) = {(obj: Any) -> Array<Any> in
    if obj is Array<Any> {
        return obj as! Array<Any>
    }
    return Array()
}


/// 过滤null的字典，当为nil时返回一个初始化的字典
public let FilterNullOfDictionary:((Any) -> Dictionary<AnyHashable, Any>) = {( obj: Any) -> Dictionary<AnyHashable, Any> in
    if obj is Dictionary<AnyHashable, Any> {
        return obj as! Dictionary<AnyHashable, Any>
    }
    return Dictionary()
    }

