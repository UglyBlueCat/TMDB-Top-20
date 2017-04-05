//
//  DataHandler.swift
//  TMDB Top 20
//
//  Created by Robin Spinks on 05/03/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import Foundation

class DataHandler {
    
    init() {}
    
    /**
     Converts a raw data object to JSON, which is then passed to populateResults
     
     - parameter newData: The raw data
     */
    func newData (newData: Data) {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: newData, options: .mutableLeaves)
            self.populateResults(jsonData: jsonData as AnyObject)
        } catch {
            DLog("JSON conversion error: \(error)")
        }
    }
    
    /**
     Parses a JSON object.
     
     - parameter jsonData: The JSON object
     */
    func populateResults (jsonData: AnyObject) {
        if let resultData = jsonData as? NSDictionary {
            if let error = resultData["error"] as? String {
                DLog("error: \(error)")
            } else {
                if let results = resultData["results"] as? NSArray {
                    self.storeMovies(movieArray: results)
                }
            }
        } else {
            DLog("Cannot convert data")
        }
    }
    
    /**
     Stores movie data into the DB
     
     - parameter movieArray: The movie data
     */
    func storeMovies(movieArray : NSArray) {
        for i in 0..<movieArray.count {
            if let movie = movieArray[i] as? NSDictionary {
                if let poster_path = movie["poster_path"] as? String,
                    let title = movie["title"] as? String,
                    let overview = movie["overview"] as? String,
                    let vote_average = movie["vote_average"] as? Float {
                        DLog("poster_path: \(poster_path)")
                        DLog("title: \(title)")
                        DLog("overview: \(overview)")
                        DLog("vote_average: \(vote_average)")
                } else {
                    DLog("Cannot extract data fields from movieArray[\(i)]")
                }
            } else {
                DLog("Cannot convert movieArray[\(i)]")
            }
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "kDataLoaded"), object: nil)
    }
    
}
