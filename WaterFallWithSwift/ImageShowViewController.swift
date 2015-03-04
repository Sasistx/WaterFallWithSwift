//
//  ImageShowViewController.swift
//  WaterFallWithSwift
//
//  Created by baidu on 15/3/3.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

import Foundation
import UIKit

class ImageShowViewController : UIViewController {
    
    var viewImage : UIImage?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var scrollView = ShowImageScrollView(frame: self.view.bounds)
        scrollView.initialShowImage(viewImage!)
        
        self.view.addSubview(scrollView)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
}
