//
//  Movie.swift
//  MovieSearch
//
//  Created by Bradley GIlmore on 6/9/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

class Movie {
    
    //MARK: - Internal Properties
    
    let title: String
    let rating: Double
    let summary: String
    let image: String?
    
    //MARK: - Initializers
    
    init(title: String, rating: Double, summary: String, image: String?) {
        self.title = title
        self.rating = rating
        self.summary = summary
        self.image = image
    }
    
    init?(dictionary: [String: Any]) {
        guard let title = dictionary[titleKey] as? String,
            let rating = dictionary[ratingKey] as? Double,
            let summary = dictionary[summaryKey] as? String,
            let image = dictionary[imageKey] as? String else { NSLog("JSON Initializer has failed"); return nil }
        
        self.title = title
        self.rating = rating
        self.summary = summary
        self.image = image // FIXME: - This is wrong, Gotta fix with the actual endpoint later.
        
    }
    
}

//MARK: - Keys

fileprivate let titleKey = "title"
fileprivate let ratingKey = "vote_average"
fileprivate let summaryKey = "overview"
fileprivate let imageKey = "poster_path"
