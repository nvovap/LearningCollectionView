//
//  CollectionViewController.swift
//  LernedCollectionViewLayout
//
//  Created by nvovap on 2/16/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import UIKit
import CoreLocation

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var images = [UIImage]()
    
    let myLayout = MyLayout()
    
    
    
    
    func orientationChanged() {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let device = UIDevice.currentDevice()
        
        device.beginGeneratingDeviceOrientationNotifications()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(self, selector: "orientationChanged", name: UIDeviceOrientationDidChangeNotification, object: device)
        
        
    }
  


    override func viewDidLoad() {
        super.viewDidLoad()
       
        
      //  let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>), radius: CLLocationDistance, identifier: <#T##String#>)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
        images.append(UIImage(named: "1.png")!)
        images.append(UIImage(named: "1.png")!)
        images.append(UIImage(named: "1.png")!)
       /* images.append(UIImage(named: "1.png")!)
        images.append(UIImage(named: "1.png")!)
        images.append(UIImage(named: "1.png")!)
        images.append(UIImage(named: "1.png")!)
        images.append(UIImage(named: "1.png")!)*/
        

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        
        myLayout.faceRadiuse = min(collectionView!.frame.size.width, collectionView!.frame.size.height)  / 2 - 100
        
        
        self.collectionView!.setCollectionViewLayout(myLayout, animated: true)
        
        

        //Add gesture recognizer 
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "didTapGesture")
        
        self.collectionView?.addGestureRecognizer(tapRecognizer)
        
        
        let panRecognizer = UIPinchGestureRecognizer(target: self, action: "didPinchGesture:")
        
        self.collectionView?.addGestureRecognizer(panRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Gesture handler
    
    func didTapGesture() {
        images.append(UIImage(named: "1.png")!)
        
        self.collectionView?.reloadData()
    }
    
    func didPinchGesture(pinch: UIPinchGestureRecognizer) {

        if pinch.state == UIGestureRecognizerState.Ended {
            myLayout.faceRadiuse = myLayout.faceRadiuse * pinch.scale
            myLayout.scale = 1
        } else {
            myLayout.scale = pinch.scale
        }
        
        myLayout.invalidateLayout()
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        let image = images[indexPath.row]
        
        let imageView = UIImageView(image: image)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        cell.addSubview(imageView)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    /*override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }*/

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
