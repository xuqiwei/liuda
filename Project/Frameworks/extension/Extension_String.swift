//
//  Extension_String.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/10/30.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import UIKit
import CommonCrypto

// MARK: - String 扩展
extension String {
    
    /// 截取字符串from后到to前的子串
    ///
    /// - Parameters:
    ///   - from: from后
    ///   - to: to前
    /// - Returns: 截取后的子串
    public func subString(from : Int, to : Int) -> String {
        
        if from > self.count || to < 0 || from > to  {
            return ""
        }
        
        let indexFrom = from < 0 ? self.startIndex : self.index(self.startIndex, offsetBy: from)
        let indexTo = to > self.count ? self.endIndex : self.index(self.startIndex, offsetBy: to)
        
        return String(self[indexFrom..<indexTo])
    }
    
    /// 删除指定位置字符串
    ///
    /// - Parameter at: 位置
    public mutating func remove(_ at : Int) {
        
        if at < 0 || at > self.count {
            return
        }
        
        let indexAt : Index = self.index(self.startIndex, offsetBy: at)
        
        self.remove(at: indexAt)
    }
    
    /// 删除from后到to前的子串
    ///
    /// - Parameters:
    ///   - from: from后
    ///   - to: to前
    public mutating func remove(from : Int, to : Int) {
        if from > self.count || to < 0 || from > to  {
            return
        }
        
        let indexFrom = from < 0 ? self.startIndex : self.index(self.startIndex, offsetBy: from)
        let indexTo = to > self.count ? self.endIndex : self.index(self.startIndex, offsetBy: to)
        
        self.removeSubrange(indexFrom..<indexTo)
    }
    
    /// 删除from后长度为length的子串
    ///
    /// - Parameters:
    ///   - from: from后
    ///   - length: 长度为length
    public mutating func remove(from : Int, length : Int) {
        if from > self.count || length < 0  {
            return
        }
        
        let indexFrom = from < 0 ? self.startIndex : self.index(self.startIndex, offsetBy: from)
        let indexTo = from+length > self.count ? self.endIndex : self.index(indexFrom, offsetBy: length)
        
        self.removeSubrange(indexFrom..<indexTo)
    }
    
    /// 根据字符创获取对应的Class
    ///
    /// - Returns: Class
    public func classFromString() ->AnyClass? {
        
        guard let nameSpace = (Bundle.main.infoDictionary!["CFBundleExecutable"] as? String)  else {
            return nil
        }
        let swiftClass : AnyClass? = NSClassFromString(nameSpace + "." + self)
        if (swiftClass as? UIViewController.Type) != nil {
            
            return swiftClass
        }
        
        let objcClass : AnyClass? = NSClassFromString(self)
        if (objcClass as? UIViewController.Type) != nil {
            return objcClass
        }
        
        return nil
    }
    
    /// 根据字符创获取对应的控制器的类型
    ///
    /// - Returns: 控制器的类型
    public func viewControllerFromString() -> UIViewController? {
        // get the project name
        if let type = self.classFromString() as? UIViewController.Type  {
            let newVC = type.init()
            return newVC
        }
        return nil
    }
    
    
    /// md5加密
    ///
    /// - Returns: 加密后的字符串
    public func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
}
