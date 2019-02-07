//
//  CreateTableViewController.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/7.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class CreateTableViewController: UIViewController {

    //MARK: - 主角是PopupListView中创建的自定义TableView实例
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.startButton.frame = CGRect.init(x: 0, y: 0, width: self.view.width, height: 50)
        
        self.popupListView.show()
    }
    
    @objc func p_tapStartButton() {
        self.popupListView.show()
    }
    
    //MARK: - 懒加载添加视图
    private lazy var popupListView:PopupListView = { () -> PopupListView in
        let _popupListView = PopupListView()
        _popupListView.title = "世界上最牛B的语言"
        _popupListView.dataArray = Mock.popupOptions
        return _popupListView
    }()
    
    private lazy var startButton:UIButton = { () -> UIButton in
        let _startButton = UIButton.init(type: UIButton.ButtonType.system)
        _startButton.backgroundColor = TVStyle.colorPrimaryDishes
        _startButton.setTitle("弹  出", for: UIControl.State.normal)
        _startButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        _startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(_startButton)
        
        _startButton.addTarget(self, action: #selector(p_tapStartButton), for: UIControl.Event.touchUpInside)
        return _startButton
    }()
    
}
