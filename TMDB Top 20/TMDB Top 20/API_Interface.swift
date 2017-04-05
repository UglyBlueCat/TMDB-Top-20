//
//  API_Interface.swift
//  TMDB Top 20
//
//  Created by Robin Spinks on 05/03/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import Foundation

class API_Interface {
    
    init() {}
    
    enum Method: String {
        case GET, POST, PUT, DELETE
    }
    
    let urlSession : URLSession = NetworkManager.sharedInstance.defaultSession
    let dataHandler : DataHandler = DataHandler()
    
    /**
     Calls an HTTP request with the GET method
     
     - parameters:
         - params: The parameters for the GET request
         - urlString: the URL of the GET request
         - completion: a completion method to be called after the request is handled
     */
    func getRequest (params: Dictionary<String, String>, urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        makeRequest(method: .GET, params: params, urlString: urlString, completion: completion)
    }
    
    /**
     Calls an HTTP request with the POST method
     
     - parameters:
         - params: The parameters for the POST request
         - urlString: the URL of the POST request
         - completion: a completion method to be called after the request is handled
     */
    func postRequest (params: Dictionary<String, String>, urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        makeRequest(method: .POST, params: params, urlString: urlString, completion: completion)
    }
    
    /**
     Calls an HTTP request with the DELETE method
     
     - parameters:
         - params: The parameters for the DELETE request
         - urlString: the URL of the DELETE request
         - completion: a completion method to be called after the request is handled
     */
    func deleteRequest (params: Dictionary<String, String>, urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        makeRequest(method: .DELETE, params: params, urlString: urlString, completion: completion)
        
    }
    
    /**
     Makes an HTTP request with the provided parameters
     
     - parameters:
         - method: The method for the request
         - params: The parameters for the request
         - urlString: the URL of the request
         - completion: a completion method to be called after the request is handled
     */
    func makeRequest (method: Method, params: Dictionary<String, String>, urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        if var urlComponents = URLComponents(string: urlString) {
            
            var requestParams: [URLQueryItem] = []
            
            for (paramName, paramValue) in params {
                requestParams.append(URLQueryItem(name: paramName, value: paramValue))
            }
            
            urlComponents.queryItems = requestParams
            
            if let url : URL = urlComponents.url {
                var request : URLRequest = URLRequest(url: url)
                request.httpMethod = method.rawValue
                NetworkManager.sharedInstance.handleRequest(request: request, completion: completion)
            } else {
                DLog("Could not obtain NSURL from \(urlComponents.debugDescription)")
            }
        } else {
            DLog("Could not construct NSURLComponents from \(urlString)")
        }
    }
    
    /**
     Performs actions based on response code
     Actions are only logging to console initially
     but this method can be modified to cover more cases
     and perform more useful actions
     
     - parameter response: The response from the request
     */
    func handleResponse (response: HTTPURLResponse) {
        switch response.statusCode {
        case 200:
            return
        case 500:
            DLog("Status Code 500: Server Error")
        default:
            DLog("Status Code \(response.statusCode)")
        }
    }
}
