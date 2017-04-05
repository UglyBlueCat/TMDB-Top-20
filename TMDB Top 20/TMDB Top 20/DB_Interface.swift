//
//  DB_Interface.swift
//  TMDB Top 20
//
//  Created by Robin Spinks on 08/03/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import Foundation
import SQLite

class DB_Interface {
    
    let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
        ).first!
    let database : Connection
    let movies = Table("movies")
    let id = Expression<Int>("id")
    let title = Expression<String>("title")
    let overview = Expression<String>("overview")
    let poster_path = Expression<String>("poster_path")
    let vote_average = Expression<Double>("vote_average")
    // There's a problem with Float Expressions 
    // but I don't need to use the space of a Double throughout the app
    // so I convert it in addMovie()
    
    static let sharedInstance = DB_Interface()
    fileprivate init() {
        self.database = try! Connection("\(path)/db.sqlite3") // possible crash
        self.createMovieTable()
    }
    
    /**
     Creates a table in the database for containing movie data
     */
    private func createMovieTable() {
        
        do {
            try database.run(movies.create { table in
                table.column(id, primaryKey: true)
                table.column(title)
                table.column(overview)
                table.column(poster_path)
                table.column(vote_average)
            })
        } catch {
            DLog("Unable to create movies table. Error: \(error)")
        }
    }
    
    /**
     Adds a movie to the movies table
     
     - parameters:
        - theID:            The unique ID of the movie
        - theTitle:         The title of the movie
        - theOverview:      An overview of the movie
        - thePosterPath:    The location of the poster image in the TMDb API
        - theVoteAverage:   The average user voted rating
     */
    func addMovie(theID : Int,
                  theTitle : String,
                  theOverview : String,
                  thePosterPath : String,
                  theVoteAverage : Float) {
        
        let insert = movies.insert(id <- theID, title <- theTitle, overview <- theOverview, poster_path <- thePosterPath, vote_average <- Double(theVoteAverage))
        
        do {
            _ = try database.run(insert)
        } catch {
            DLog("Cannot insert movie: '\(theTitle)'. Error: \(error)")
        }
    }
    
    /**
     Extracts all data from the movies table
     
     - returns: An NSArray of NSDictionaries, each containing data for one movie
     */
    func allMovies() -> NSArray {
        let allMovies : NSMutableArray = NSMutableArray()
        do {
            for movie in try database.prepare(movies) {
                let movieDictionary : NSDictionary = ["title":movie[title],
                                                      "overview":movie[overview],
                                                      "poster_path":movie[poster_path],
                                                      "vote_average":Float(movie[vote_average])]
                allMovies.add(movieDictionary)
            }
        } catch {
            DLog("Could not extract data from movies. Error: \(error)")
        }
        return allMovies
    }
}
