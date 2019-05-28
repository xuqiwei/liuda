//
//  ProgressHUD.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/11/1.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import UIKit

/// 提示框
class ProgressHUD {
    
    /// 显示提示信息
    ///
    /// - Parameter text: 信息内容
    static func show(_ text : String) {
    
        ProgressHUD.show(text, toView: nil)
    }
    
    /// 显示提示信息
    ///
    /// - Parameters:
    ///   - text: 信息内容
    ///   - toView: 显示视图
    static func show(_ text : String, toView : UIView?) {
        
        let view = toView ?? UIApplication.shared.windows.last
        
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .text
        hud.removeFromSuperViewOnHide = true
        hud.isUserInteractionEnabled = false
        hud.bezelView.backgroundColor = Color_gray_a0a0a0
        hud.detailsLabel.text = text
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 14)
        hud.hide(animated: true, afterDelay: 2.0)
    }
    
    /// 显示信息
    ///
    /// - Parameters:
    ///   - text: 信息内容
    ///   - icon: 图标
    ///   - toView: 显示视图
    static func show(_ text : String, icon : String, toView : UIView?) {
        
        let view = toView ?? UIApplication.shared.windows.last
        
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .customView
        hud.customView = UIImageView.init(image: UIImage.init(named: icon))
        hud.removeFromSuperViewOnHide = true
        hud.isUserInteractionEnabled = false
        hud.bezelView.backgroundColor = Color_gray_a0a0a0
        hud.detailsLabel.text = text
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 14)
        hud.hide(animated: true, afterDelay: 2.0)
    }
    
    /// 显示一些信息
    ///
    /// - Returns: 直接返回一个MBProgressHUD，需要手动关闭
    static func showMessage() {
        
        ProgressHUD.showMessage("", toView: nil)
    }
    
    /// 显示一些信息
    ///
    /// - Parameter message: 信息内容
    /// - Returns: 直接返回一个MBProgressHUD，需要手动关闭
    static func showMessage(_ message : String) {
        
        ProgressHUD.showMessage(message, toView: nil)
    }
    
    /// 显示一些信息
    ///
    /// - Parameters:
    ///   - message: 信息内容
    ///   - toView: 需要显示信息的视图
    static func showMessage(_ message : String, toView : UIView?) {
        let view = toView ?? UIApplication.shared.windows.last
        
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.removeFromSuperViewOnHide = true
        hud.isUserInteractionEnabled = false
        hud.bezelView.backgroundColor = Color_gray_a0a0a0
        hud.detailsLabel.text = message
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    /// 手动关闭MBProgressHUD
    static func hideHUD() {
        ProgressHUD.hideHUD(forView: nil)
    }
    
    /// 手动关闭MBProgressHUD
    ///
    /// - Parameter forView: 显示MBProgressHUD的视图
    static func hideHUD(forView : UIView?) {
        let view = forView ?? UIApplication.shared.windows.last
        MBProgressHUD.hide(for: view!, animated: true)
    }
}
