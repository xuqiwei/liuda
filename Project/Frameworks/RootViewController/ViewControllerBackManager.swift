//
//  ViewControllerBackManager.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/11/26.
//  Copyright © 2018 徐其威. All rights reserved.
//

import UIKit

/// 自定义返回按钮
class ViewControllerBackManager: NSObject {

    var viewController = LLViewController()
    var backBarButton = UIBarButtonItem()
    
    init(_ backViewController : LLViewController) {
        
        super.init()
        viewController = backViewController
        
        let backButton = UIButton.init(type: .custom)
        backButton.contentHorizontalAlignment = .left
        backButton.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        backButton.setImage(UIImage.init(named: ImageName_Nav_Return), for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let leftBarButon = UIBarButtonItem.init(customView: backButton)
        backBarButton = leftBarButon;
    }
    
    @objc func backAction(btn: UIButton) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    public func getBackBarButtonItem() {
        viewController.navigationItem.leftBarButtonItem = backBarButton
    }
}
