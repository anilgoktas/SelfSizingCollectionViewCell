//
//  CollectionViewController.swift
//  SelfSizingCollectionViewCell
//
//  Created by Anıl Göktaş on 6/19/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit
import Alamofire

class CollectionViewController: UICollectionViewController {
    
    // MARK: - IBOutlets
    
    private struct MainStoryboard {
        static let cellIdentifier = "SelfSizingCell"
        static let cellNibName    = "SelfSizingCollectionViewCell"
    }
    
    // MARK: - Properties
    
    var items = Item.random(count: 100)
    private let edgeInset: CGFloat = 10.0
    private var cellWidth: CGFloat!

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure collection view
        
        let waterfallLayout = CHTCollectionViewWaterfallLayout()
        waterfallLayout.sectionInset = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
        collectionView?.setCollectionViewLayout(waterfallLayout, animated: false)
        collectionView?.registerNib(UINib(nibName: MainStoryboard.cellNibName, bundle: nil), forCellWithReuseIdentifier: MainStoryboard.cellIdentifier)
        cellWidth = (view.bounds.size.width-3*edgeInset)/CGFloat(waterfallLayout.columnCount)
    }

}

// MARK: - UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MainStoryboard.cellIdentifier, forIndexPath: indexPath) as! SelfSizingCollectionViewCell
        let item = items[indexPath.row]
        
        // Prepare for re-use
        cell.request?.cancel()
        cell.imageView.image = nil // Caching can be implemented here
        
        let imageScale = UIScreen.mainScreen().scale
        let imagePixel = Int(cellWidth * imageScale)
        let filterURLString = "http://cdn.filter.to/\(imagePixel)x\(imagePixel)/"
        // We should delete "http://" of imageURLString in order to use filtering
        
        if let
        imageURLString = item.imageURLString,
        rangeOfURLString = imageURLString.rangeOfString("//", options: .allZeros, range: nil, locale: nil),
        imageURL = NSURL(string: filterURLString+imageURLString.substringFromIndex(advance(rangeOfURLString.startIndex,2)))
        {
            // Getting images via Alamofire
            
            cell.request = Alamofire.request(.GET, imageURL, parameters: nil, encoding: .URL).responseImage({
                (_, _, image, error) -> Void in
                if let image = image where error == nil {
                    // Resize cell
                    cell.imageView.image = image
                    cell.title = item.title
                    cell.subtitle = item.subtitle
                    let imageViewHeight = self.cellWidth * image.ratio
                    let extraHeight = cell.titleLabel.frame.height + cell.subtitleLabel.frame.height
                    item.estimatedCellSize = CGSize(width: self.cellWidth, height: imageViewHeight + extraHeight)
                    // Perform updates
                    collectionView.performBatchUpdates(nil, completion: nil)
                }
            })
            
            // Another option with AFNetworking, doing calculations on the fly, but requires %30-40 lower memory.
            
//            let urlRequest = NSURLRequest(URL: imageURL)
//            cell.imageView.setImageWithURLRequest(urlRequest, placeholderImage: nil, success: {
//                (request, response, image) -> Void in
//                collectionView.performBatchUpdates({ () -> Void in
//                    cell.title = item.title
//                    cell.subtitle = item.subtitle
//                    let imageViewHeight = self.cellWidth * image.ratio
//                    let extraHeight = cell.titleLabel.frame.height + cell.subtitleLabel.frame.height
//                    item.estimatedCellSize = CGSize(width: self.cellWidth, height: imageViewHeight + extraHeight)
//                    cell.imageView.image = image
//                }, completion: nil)
//            }, failure: nil)
        }
        
        return cell
    }
    
}

// MARK: - CHTCollectionViewDelegateWaterfallLayout

extension CollectionViewController: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return items[indexPath.row].estimatedCellSize
    }
    
}