//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Bradley GIlmore on 6/9/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        MovieController.fetchResponses(searchTerm: searchTerm) { (movies) in
            print("Outside dispatch")
            DispatchQueue.main.async {
                print("inside dispatch")
                MovieController.movies = movies
            }
        }
    }
    
    //MARK: - NotifcationCenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: MovieController.moviesWereUpdatedNotification, object: nil)
    }
    
    func refresh() {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = MovieController.movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.ratingLabel.text = "Rating: \(movie.rating)"
        cell.summaryLabel.text = movie.summary
        
        if let url = movie.image {
            ImageController.image(forURL: url) { (image) in
                guard let image = image else { return }
                cell.posterImageView.image = image
            }
        }
        
        return cell
    }
}
