//
//  ModelExtension.swift
//  DMW
//
//  Created by Anıl Göktaş on 6/10/15.
//  Copyright (c) 2015 DMW. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Global

let mainQueue = NSOperationQueue.mainQueue()

// MARK: - Alamofire

extension Alamofire.Request {
    
    class func imageResponseSerializer() -> Serializer {
        return { request, response, data in
            if let data = data {
                //let image = UIImage(data: data!, scale: UIScreen.mainScreen().scale)
                let image = UIImage(data: data)
                return (image, nil)
            }
            return (nil, nil)
        }
    }
    
    func responseImage(completionHandler: (NSURLRequest, NSHTTPURLResponse?, UIImage?, NSError?) -> Void) -> Self {
        return response(serializer: Request.imageResponseSerializer(), completionHandler: { (request, response, image, error) in
            completionHandler(request, response, image as? UIImage, error)
        })
    }
    
}