//
//  ImageController.swift
//  MovieSearch
//
//  Created by Bradley GIlmore on 6/9/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class ImageController {
    
    static func image(forURL url: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: url) else {
            fatalError("Optional URL is nil")
        }
        
        NetworkController.performRequest(for: url, httpMethod: .get){ (data, error) in
            guard let data = data,
                let image = UIImage(data: data) else {
                    completion(nil)
                    return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
            
        }
    }
}
