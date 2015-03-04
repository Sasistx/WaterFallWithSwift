//
//  RootviewController.swift
//  WaterFallWithSwift
//
//  Created by baidu on 14-6-4.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

import Foundation
import UIKit

class RootviewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CYCollectionViewLayoutDelegate {

    let CELL_WIDTH : CGFloat = 129
    let CELL_IDENTIFIER = "WaterfallCell"
    var imageArray : NSMutableArray = []
    var collectionView : UICollectionView?
    
    override init() {
        super.init()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for i in 0...14
        {
            var image = UIImage(named: "\(i).jpg")
            imageArray.addObject(image!)
        }
        
        var layout = CYCollectionViewLayout()
        layout.sectionInset = UIEdgeInsetsMake(9, 9, 9, 9)
        layout.delegate = self
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.blackColor()
        collectionView?.registerClass(CYCollectionCell.self, forCellWithReuseIdentifier: CELL_IDENTIFIER)
        self.view.addSubview(collectionView!)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: CYCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(CELL_IDENTIFIER, forIndexPath: indexPath) as CYCollectionCell
        var image: UIImage = self.imageArray[indexPath.item] as UIImage
        cell.cellImageView.image = image
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var image = imageArray[indexPath.item] as UIImage
        var svc = ImageShowViewController()
        svc.viewImage = image
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: CYCollectionViewLayout, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if imageArray.count == 0 {
        
            return 0
        }
        
        var image = imageArray[indexPath.item] as UIImage
        var imageWidth = image.size.width
        var imageHeight = (CELL_WIDTH / imageWidth) * image.size.height
        return imageHeight
    }
    
}