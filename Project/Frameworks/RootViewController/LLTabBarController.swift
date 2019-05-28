//
//  LLTabBarController.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/10/29.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import UIKit

/// 自定义父类TabBarController
class LLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.white;
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage(named: Icon_TabBar_Bg)
        
        let vcArr : Array<String> = ["LLHomeViewController",
                                     "LLTaskViewController",
                                     "LLInviteViewController",
                                     "LLMineViewController"]
        let titleArr : Array<String> = ["首页",
                                        "任务广场",
                                        "邀请",
                                        "我的"]
        let tabTitleArr : Array<String> = ["首页",
                                           "任务",
                                           "邀请",
                                           "我的"]
        let imageNameArr : Array<String> = [Icon_TabBar_Home_Normal,
                                            Icon_TabBar_Task_Normal,
                                            Icon_TabBar_Invite_Normal,
                                            Icon_TabBar_Mine_Normal]
        let selectImageNameArr : Array<String> = [Icon_TabBar_Home_Select,
                                                  Icon_TabBar_Task_Select,
                                                  Icon_TabBar_Invite_Select,
                                                  Icon_TabBar_Mine_Select]
        
        for i in 0..<4 {
            let childVC = vcArr[i].viewControllerFromString() as! LLViewController
            addChildViewController(childVC, title: titleArr[i], tabTitle: tabTitleArr[i], imageName: imageNameArr[i], selectImageName: selectImageNameArr[i])
        }

        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func addChildViewController(_ childVC : LLViewController, title : String, tabTitle : String, imageName : String, selectImageName : String) {
        
        // 1、设置自控制器的属性
        childVC.title = title
        childVC.tabBarItem.title = tabTitle
        childVC.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        
        let dic = [NSAttributedString.Key.foregroundColor : Color_gray_abb1c0,
                   NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)]
        let selectedDic = [NSAttributedString.Key.foregroundColor : Color_orange_ffa400,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)]
        childVC.tabBarItem.setTitleTextAttributes(dic, for: .normal)
        childVC.tabBarItem.setTitleTextAttributes(selectedDic, for: .selected)
        
        // 2、包装导航控制器
        let childNav = LLNavigationController(rootViewController: childVC)
        
        // 3、添加控制器
        addChild(childNav)
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
