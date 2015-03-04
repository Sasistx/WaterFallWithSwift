//
//  CYCollectionViewLayout.swift
//  WaterFallWithSwift
//
//  Created by baidu on 14-6-4.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

import Foundation
import UIKit

@objc protocol CYCollectionViewLayoutDelegate : NSObjectProtocol
{
    
    optional func collectionView(collectionView : UICollectionView, layout collectionViewLayout : CYCollectionViewLayout, heightForItemAtIndexPath indexPath : NSIndexPath) -> CGFloat
}

class CYCollectionViewLayout : UICollectionViewLayout
{
    var delegate : CYCollectionViewLayoutDelegate?
    
    var tmpColumCount = 2
    var tmpItemWidth : Double = 140.0
    var tmpSectionInset = UIEdgeInsetsZero
    var itemAttributes : NSMutableArray = []
    var columnHeights : NSMutableArray = []
    
    var itemCount = 0
    var interitemSpacing = 0.0
    
    var columnCount : Int {
    
        set{
        
            if self.tmpColumCount != newValue{
            
                self.tmpColumCount = newValue
                self.invalidateLayout()
            }
        }
        get{
        
            return self.tmpColumCount
        }
    }
    
    
    var itemWidth : Double {
    
        set{
        
            if self.tmpItemWidth != newValue {
            
                self.tmpItemWidth = newValue
                self.invalidateLayout()
            }
        }
        
        get{
        
            return self.tmpItemWidth
        }
    }
    
    var sectionInset : UIEdgeInsets {
    
        set{
        
            if !UIEdgeInsetsEqualToEdgeInsets(self.tmpSectionInset, newValue) {
            
                self.tmpSectionInset = newValue
                self.invalidateLayout()
            }
        }
        
        get{
        
            return self.tmpSectionInset
        }
    }
    
    override init() {
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareLayout() {
        
        super.prepareLayout()
        var w = self.collectionView?.frame.size.width
        itemCount = (self.collectionView?.numberOfItemsInSection(0))!
        var width = w! - self.sectionInset.left - self.sectionInset.right
        interitemSpacing = floor((Double(width) - Double(columnCount) * Double(itemWidth)) / (Double(columnCount) - 1.0))
        
        for i in 0...columnCount {
        
            columnHeights.addObject(sectionInset.top)
        }
        
        for idx in 0...(itemCount - 1) {
        
            var indexPath = NSIndexPath(forItem: idx, inSection: 0)
            var itemHeight = delegate?.collectionView!(self.collectionView!, layout: self, heightForItemAtIndexPath: indexPath)
            var columnIndex = self.shortestColumnIndex()
            var xOffset = sectionInset.left + (CGFloat(itemWidth) + CGFloat(interitemSpacing)) * CGFloat(columnIndex)
            var yOffset = columnHeights[columnIndex].floatValue
            var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attributes.frame = CGRectMake(xOffset, CGFloat(yOffset), CGFloat(itemWidth), itemHeight!)
            itemAttributes.addObject(attributes)
            columnHeights[columnIndex] = CGFloat(yOffset) + itemHeight! + CGFloat(interitemSpacing)
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        if itemCount == 0 {
        
            return CGSizeZero
        }
        
        var contentSize = self.collectionView?.frame.size;
        var columnIndex = self.longestColumnIndex()
        var height = columnHeights[columnIndex].floatValue
        contentSize!.height = CGFloat(height) - CGFloat(interitemSpacing) + CGFloat(sectionInset.bottom)
        return contentSize!
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        
        return itemAttributes[indexPath.item] as UICollectionViewLayoutAttributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        

        return itemAttributes.filteredArrayUsingPredicate(NSPredicate { (evaluatedObject, bindings) -> Bool in
            
            return CGRectIntersectsRect(rect, evaluatedObject.frame)
        })
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        
        return false
    }
    
    func shortestColumnIndex() -> Int{
    
        var index = 0
        var shortestHeight = MAXFLOAT
        columnHeights.enumerateObjectsUsingBlock { (obj, idx, stop) -> Void in
            
            var height = obj.floatValue
            if height < shortestHeight {
            
                shortestHeight = height;
                index = idx
            }
        }
        
        return index
    }
    
    func longestColumnIndex() -> Int{
    
        var index = 0
        var longestHeight = MAXFLOAT
        columnHeights.enumerateObjectsUsingBlock { (obj, idx, stop) -> Void in
            
            var height = obj.floatValue
            if height > longestHeight {
                
                longestHeight = height;
                index = idx
            }
        }
        
        return index
    }
}