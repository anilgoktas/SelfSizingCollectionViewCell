//
//  SelfSizingCollectionViewCell.swift
//  SelfSizingCollectionViewCell
//
//  Created by Anıl Göktaş on 6/19/15.
//  Copyright (c) 2015 Anıl Göktaş. All rights reserved.
//

import UIKit
import Alamofire

class SelfSizingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: - Properties
    
    var request: Request?
    var title: String? {
        didSet {
            titleLabel.text = title
            titleLabel.sizeToFit()
        }
    }
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
            subtitleLabel.sizeToFit()
        }
    }
    
}