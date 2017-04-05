//
//  ViewController.swift
//  TMDB Top 20
//
//  Created by Robin Spinks on 05/04/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allMovies : NSArray = DB_Interface.sharedInstance.allMovies()
    var resultsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "kDataLoaded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "kImageReceived"), object: nil)
        createObjects()
        setupObjects()
        positionObjectsWithinSize(size: view.bounds.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        positionObjectsWithinSize(size: size)
        resultsTable.reloadData()
    }
    
    func createObjects() {
        
        resultsTable = UITableView()
        self.view.addSubview(resultsTable)
    }
    
    func setupObjects() {
        
        resultsTable.dataSource = self
        resultsTable.delegate = self
        resultsTable.separatorStyle = .none
        resultsTable.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            resultsTable.rowHeight = 235
        } else {
            resultsTable.rowHeight = 142
        }
    }
    
    func positionObjectsWithinSize(size: CGSize) {
        let topMargin : CGFloat = 20.0
        let margin : CGFloat = 10.0
        let viewHeight : CGFloat = size.height
        let viewWidth : CGFloat = size.width
        
        resultsTable.frame = CGRect(x: margin,
                                    y: topMargin + margin,
                                    width: viewWidth - 2*margin,
                                    height: viewHeight - 2*margin - topMargin)
    }
    
    func reloadTable() {
        
        DispatchQueue.main.async {
            self.resultsTable!.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        if let movie: NSDictionary = allMovies[indexPath.row] as? NSDictionary {
            if let vote_average = movie.object(forKey: "vote_average") as? Float,
                let title = movie.object(forKey: "title") as? String,
                let overview = movie.object(forKey: "overview") as? String,
                let path = movie.object(forKey: "poster_path") as? String {
                
                cell.voteAverageLabel!.text = "Average Vote: \(vote_average)"
                cell.titleLabel!.text = title
                cell.overviewLabel!.text = "\(overview)"
                
                let imageFetcher : ImageFetcher = ImageFetcher()
                cell.posterImage.image = imageFetcher.imageWithPath(path: path)
            }
        }
        
        return cell;
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

