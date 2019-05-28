//
//  LLNavigationController.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/10/29.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import UIKit

/// 自定义父类NavigationController
class LLNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = Color_orange_ffa400
        self.navigationBar.tintColor = Color_white_ffffff
        self.navigationBar.barStyle = .black
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19),
                                                  NSAttributedString.Key.foregroundColor : Color_white_ffffff]
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
