//
//  MovieController.swift
//  MovieSearch
//
//  Created by Bradley GIlmore on 6/9/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

class MovieController {
    
    //MARK: - NotificationCenter
    
    static let moviesWereUpdatedNotification = Notification.Name("moviesWereUpdated")
    
    static var movies = [Movie](){
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: moviesWereUpdatedNotification, object: self)
            }
        }
    }
    
    //MARK: - baseURL
    
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie?")
    
    //MARK: - Fetch Method / GET
    
    static func fetchResponses(searchTerm: String, completion: @escaping (_ responses: [Movie]) -> Void) {
        
        // Unwrapp baseURL
        guard let url = baseURL else { NSLog("baseURL was nil"); completion([]); return }

        // Create URLParamaters
        let urlParameters = [
            "api_key" : "5e7143caf64c9dcaf5a72c99b24535e3",
            "language": "en-US",
            "query": searchTerm.lowercased()
        ]
        
        // Perform Request
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: urlParameters) { (data, error) in
            
            // Array that we will return
            var movies: [Movie] = []
            
            // Error Handle
            if let error = error {
                NSLog("Error performing fetch request. \(error.localizedDescription)")
                completion([])
                return
            }
            
            // Make sure data is there
            guard let data = data else { NSLog("Data was invalid"); completion([]); return }
            
            //Serialize the json from the bits we get back
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { NSLog("Error during JSONSerialization"); completion([]); return }

            // Drill down one more layer
            guard let movieDictionary = jsonDictionary["results"] as? [[String: Any]] else {
                NSLog("Error Drilling Down Data")
                completion([])
                return
            }
            
            // Create movie objects
            movies = movieDictionary.flatMap { Movie(dictionary: $0) }

            completion(movies)
        }
    }
}



