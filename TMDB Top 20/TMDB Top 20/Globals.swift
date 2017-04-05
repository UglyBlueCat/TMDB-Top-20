//
//  Globals.swift
//  TMDB Top 20
//
//  Created by Robin Spinks on 05/03/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

// A place to define variables and functions that may be used throughout the project
// This improves flexibility for future configuration changes, such as using a live URL instead of a test URL

// This is a temporary solution to increase development time
// A more effective long term solution would be top store configuration in a plist

import Foundation

let userDefaults: UserDefaults = UserDefaults.standard
let apiURL = "https://api.themoviedb.org/3/movie/top_rated"
let apiKey = "449d682523802e0ca4f8b06d8dcf629c"
let testParams = ["page":"1",
                  "language":"en-US",
                  "api_key":apiKey]

/**
 Prints a message to the console prefixed with filename, function & line number.
 A replacement for \_\_PRETTY_FUNCTION__
 
 - parameters:
     - msg: The message to print
     - function: The calling function or method (Defaults to #function)
     - file: The file containing function (Defaults to #file)
     - line: The line of the DLog call (Defaults to #line)
 */
func DLog(_ msg: String, function: String = #function, file: String = #file, line: Int = #line) {
    let url = URL(fileURLWithPath: file)
    let className:String = url.lastPathComponent
    print("[\(className) \(function)](\(line)) \(msg)")
}
