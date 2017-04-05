//
//  MovieCell.swift
//  TMDB Top 20
//
//  Created by Robin Spinks on 05/04/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    var posterImage : UIImageView!
    var titleLabel : UILabel!
    var overviewLabel : UILabel!
    var voteAverageLabel : UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sizeObjects()
    }
    
    /**
     Set up objects in the cell..
     Separate from sizeObjects() so it can be called from initialisers.
     */
    func setupView() {
        
        posterImage = UIImageView()
        self.addSubview(posterImage!)
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel!)
        
        overviewLabel = UILabel()
        overviewLabel.numberOfLines = 0
        self.addSubview(overviewLabel!)
        
        voteAverageLabel = UILabel()
        voteAverageLabel.textAlignment = .right
        self.addSubview(voteAverageLabel!)
    }
    
    /**
     Change the size of objects in the cell.
     These are in a separate function so they can be called from layoutSubviews()
     */
    func sizeObjects() {
        
        let margin : CGFloat = 2.0
        let cellHeight : CGFloat = bounds.size.height
        let cellWidth : CGFloat = bounds.size.width
        let standardLabelHeight : CGFloat = 30.0
        
        var imageWidth : CGFloat = 0
        var imageHeight : CGFloat = 0
        
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            imageWidth = 154.0
            imageHeight = 231.0
        } else {
            imageWidth = 92.0
            imageHeight = 138.0
        }
        
        posterImage.frame = CGRect(x: margin,
                                   y: margin,
                                   width: imageWidth,
                                   height: imageHeight)
        
        titleLabel.frame = CGRect(x: imageWidth + 3*margin,
                                  y: margin,
                                  width: cellWidth - imageWidth - 4*margin,
                                  height: standardLabelHeight)
        
        voteAverageLabel.frame = CGRect(x: imageWidth + 3*margin,
                                        y: cellHeight - standardLabelHeight - margin,
                                        width: cellWidth - imageWidth - 4*margin,
                                        height: standardLabelHeight)
        
        overviewLabel.frame = CGRect(x: imageWidth + 3*margin,
                                     y: standardLabelHeight + 2*margin,
                                     width: cellWidth - imageWidth - 4*margin,
                                     height: cellHeight - 2*standardLabelHeight - 4*margin)
    }
}
