//
//  ViewController.swift
//  TMDB Top 20
//
//  Created by Robin Spinks on 05/04/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "kDataLoaded"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadTable() {
        // testing code for now
        let moviesArray : NSArray = DB_Interface.sharedInstance.allMovies()
        
        for index in 0..<moviesArray.count {
            if let movie : NSDictionary = moviesArray[index] as? NSDictionary {
                if let poster_path = movie["poster_path"] as? String {
                    DLog("poster_path: \(poster_path)")
                } else {
                    DLog("Cannot extract poster_path from movie[\(index)]:\n\(movie)\n")
                }
                
                if let title = movie["title"] as? String {
                    DLog("title: \(title)")
                } else {
                    DLog("Cannot extract title from movie[\(index)]:\n\(movie)\n")
                }
                
                if let overview = movie["overview"] as? String {
                    DLog("overview: \(overview)")
                } else {
                    DLog("Cannot extract overview from movie[\(index)]:\n\(movie)\n")
                }
                
                if let vote_average = movie["vote_average"] as? Float {
                    DLog("vote_average: \(vote_average)")
                } else {
                    DLog("Cannot extract vote_average from movie[\(index)]:\n\(movie)\n")
                }
            }
        }
    }
}

