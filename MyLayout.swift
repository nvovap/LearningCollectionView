//
//  MyLayout.swift
//  LernedCollectionViewLayout
//
//  Created by nvovap on 2/16/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import UIKit

class MyLayout: UICollectionViewLayout {
    
    var attributesArray = [UICollectionViewLayoutAttributes]()
    
    var faceRadiuse: CGFloat =  0
    
    var scale: CGFloat  = 1
    
    
    
    override func prepareLayout() {
        
        
        
        //let faceRadiuseY = collectionView!.frame.size.height / 2
        
        let cvCenter = CGPointMake(collectionView!.frame.size.width/2, collectionView!.frame.size.height/2)
        
        for item in 0..<self.collectionView!.numberOfItemsInSection(0) {
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let newAttribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            
            newAttribute.size = CGSize(width: 100, height: 100)
            
            let angular: Double = (2 * M_PI) / Double(self.collectionView!.numberOfItemsInSection(0))
            
            let theta = angular * Double(item)
            
            let xDisplacement = cos(theta) * Double(faceRadiuse * scale)
            let yDisplacement = sin(theta) * Double(faceRadiuse * scale)
            
            let xPosition = cvCenter.x + CGFloat(xDisplacement)
            let yPosition = cvCenter.y - CGFloat(yDisplacement)
            
            
            newAttribute.center = CGPoint(x: xPosition, y: yPosition)
            
            if let matchingAtributeIndex = attributesArray.indexOf({ (attribute: UICollectionViewLayoutAttributes) -> Bool in
                    attribute.indexPath.compare(indexPath) == NSComparisonResult.OrderedSame
                }) {
                attributesArray[matchingAtributeIndex] = newAttribute
            } else {
                attributesArray.append(newAttribute)
            }
        }
    }
    
    
    override func collectionViewContentSize() -> CGSize {
        return self.collectionView!.frame.size
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesArray.filter({ (theAttribute) -> Bool in
            theAttribute.indexPath == indexPath
        }).first
    }
    
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return false
    }

}
