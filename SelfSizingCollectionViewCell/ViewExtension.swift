//
//  ViewExtension.swift
//  DMW
//
//  Created by Anıl Göktaş on 6/11/15.
//  Copyright (c) 2015 DMW. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIImage

extension UIImage {
    
    var ratio: CGFloat {
        return size.height / size.width
    }
    
}