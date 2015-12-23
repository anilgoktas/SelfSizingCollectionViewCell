//
//  Item.swift
//  SelfSizingCollectionViewCell
//
//  Created by Anıl Göktaş on 6/19/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit

private let imageURLStrings = ["http://i.imgur.com/34JBO.jpg", "http://i.imgur.com/KdVUt.jpg", "http://i.imgur.com/otugl.jpg", "http://i.imgur.com/AwJgD.jpg", "http://i.imgur.com/ER0hN.jpg", "http://i.imgur.com/LA8ix.jpg"]

class Item: NSObject {
    
    // MARK: - Properties
    
    var title: String?
    var subtitle: String?
    var imageURLString: String?
    var estimatedCellSize: CGSize!
    
    // MARK: - Life Cycle
    
    override init() {
        title = random() % 2 == 0 ? "some title" : "this is some long title"
        subtitle = random() % 2 == 0 ? "some subtitle" : "this is some long subtitle"
        imageURLString = imageURLStrings[random() % imageURLStrings.count]
        estimatedCellSize = CGSizeZero
        
        super.init()
    }
    
    // MARK: - Test
    
    class func random(count count: Int) -> [Item] {
        var items = [Item]()
        for _ in 0..<count {
            items.append(Item())
        }
        return items
    }
    
}