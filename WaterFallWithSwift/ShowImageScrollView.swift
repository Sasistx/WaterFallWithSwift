//
//  ShowImageScrollView.swift
//  WaterFallWithSwift
//
//  Created by baidu on 15/3/3.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

import Foundation
import UIKit

class ShowImageScrollView : UIScrollView, UIScrollViewDelegate {
    
    var imageView : UIImageView?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }

    internal func initialShowImage(image : UIImage){
    
        imageView = UIImageView(frame: CGRectMake(0, 0, image.size.width, image.size.height))
        imageView?.userInteractionEnabled = true
        imageView?.image = image
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "imageTapped:")
        tapGesture.numberOfTapsRequired = 2
        imageView?.addGestureRecognizer(tapGesture)
        self.addSubview(imageView!)
        
        var minimumScale = self.frame.size.width / ((imageView?.frame.size.width)!)
        self.minimumZoomScale = minimumScale
        self.maximumZoomScale = minimumScale * 3.0
        self.zoomScale = minimumScale
    }
    
    func imageTapped(gesture:UITapGestureRecognizer) {
    
        var newScale = self.zoomScale * 1.5
        var zoomRect = self.zoomRectForScale(newScale, center: gesture.locationInView(gesture.view))
        self.zoomToRect(zoomRect, animated: true)
    }
    
    func zoomRectForScale(scale : CGFloat, center : CGPoint) -> CGRect {
        
        var zoomRect = CGRectZero
        zoomRect.size.height = self.frame.size.height / scale
        zoomRect.size.width = self.frame.size.width / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        
        scrollView.setZoomScale(scale, animated: true)
    }
}
