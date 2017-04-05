//
//  ImageFetcher.swift
//  TMDB Top 20
//
//  Created by Robin Spinks on 07/08/2016.
//  Copyright © 2016 UglyBlueCat. All rights reserved.
//

import Foundation
import UIKit

class ImageFetcher {
    let defaultImage : UIImage = UIImage(color: UIColor.clear)!
    
    init() {}
    
    /**
     Returns an image named with the given path if it exists, otherwise returns a default image and triggers download of the desired image
     
     - parameter path: The path of the image
     - returns: The image
     */
    func imageWithPath (path: String) -> UIImage {
        let directory : FileManager.SearchPathDirectory = .documentDirectory
        let domain : FileManager.SearchPathDomainMask = .userDomainMask
        let directoryURLs = FileManager.default.urls(for: directory, in: domain)
        
        let imageLocation : URL = directoryURLs[0].appendingPathComponent(path, isDirectory: false)
        
        if let foundImage : UIImage = UIImage(contentsOfFile: imageLocation.relativePath) {
            return foundImage
        } else {
            DLog("Cannot find image at \(imageLocation.relativePath)")
        }
        
        downloadImage(path: path)
        
        return defaultImage
    }
    
    
    /**
     Downloads an image and stores it named with the given path
     
     - parameters:
        - path: The image path
     */
    func downloadImage (path: String) {
        
        var imageWidth : Int = 0
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            imageWidth = 154
        } else {
            imageWidth = 92
        }
        
        let imageURLString: String = "https://image.tmdb.org/t/p/w\(imageWidth)\(path)"
        
        if let imageURL : URL = URL(string: imageURLString) {
            
            let request : URLRequest = URLRequest(url: imageURL)
            
            NetworkManager.sharedInstance.handleRequest(request: request) { (data, urlResponse, error) in
                
                let directory : FileManager.SearchPathDirectory = .documentDirectory
                let domain : FileManager.SearchPathDomainMask = .userDomainMask
                let directoryURLs = FileManager.default.urls(for: directory, in: domain)
                let imageFileURL : URL = directoryURLs[0].appendingPathComponent(path, isDirectory: false)
                
                if (try? data!.write(to: imageFileURL, options: [])) != nil {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "kImageReceived"), object: nil)
                } else {
                    DLog("Unable to write to file: \(imageFileURL)")
                }
            }
        } else {
            DLog("Cannot construct URL from \(imageURLString)")
        }
    }
}

/*
 * Create image from colour
 * Taken from http://stackoverflow.com/questions/26542035/create-uiimage-with-solid-color-in-swift
 */
public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
