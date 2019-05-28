//
//  Extension_UIColor.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/10/30.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import UIKit

// MARK: - UIColor 扩展
extension UIColor {
    ///
    /// 扩展RGB类型，类型方法
    ///
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    ///   - a: 透明度
    /// - Returns: 颜色
    static func rgba(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
        return UIColor.init(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
    }
    
    /// 扩展RGB类型，类型方法
    ///
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    /// - Returns: 颜色
    static func rgb(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
        return rgba((r), (g), (b), 1)
    }
    
    /// 十六进制的色值，类型方法
    ///
    /// - Parameters:
    ///   - value: 色值
    ///   - a: 透明度
    /// - Returns: 颜色
    static func hexa(_ value:Int, _ a:CGFloat) -> UIColor{
        return rgba(CGFloat((value & 0xFF0000) >> 16),
                    CGFloat((value & 0x00FF00) >> 8),
                    CGFloat((value & 0x0000FF)),
                    a)
    }
    
    /// 十六进制的色值，类型方法
    ///
    /// - Parameter value: 色值
    /// - Returns: 颜色
    static func hex(_ value:Int) -> UIColor {
        return hexa(value, 1)
    }
    
    /// 随机色，类型属性
    static var rand: UIColor {
        return rgb(CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)))
    }
}

