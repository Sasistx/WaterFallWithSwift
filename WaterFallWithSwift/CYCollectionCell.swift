//
//  CYCollectionCell.swift
//  WaterFallWithSwift
//
//  Created by baidu on 15/3/3.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

import Foundation
import UIKit

class CYCollectionCell: UICollectionViewCell {

    var tmpCellImage : UIImageView?
    
    internal var cellImageView : UIImageView {
    
        set{
        
            self.tmpCellImage = newValue
        }
        get {
            
            if self.tmpCellImage == nil {
            
                self.tmpCellImage = UIImageView(frame: self.contentView.frame)
                self.tmpCellImage?.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
                self.tmpCellImage?.backgroundColor = UIColor.lightGrayColor()
            }
            
            return self.tmpCellImage!
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.contentView.addSubview(cellImageView)
    }
}