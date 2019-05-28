//
//  LLViewController.swift
//  Swift_demo
//
//  Created by 徐其威 on 2018/10/29.
//  Copyright © 2018年 徐其威. All rights reserved.
//

import UIKit

/// 自定义父类ViewController
class LLViewController: UIViewController {
    
    lazy var backManager : ViewControllerBackManager = {
        return ViewControllerBackManager.init(self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            backManager.getBackBarButtonItem()
        }
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
