//
//  AlbumCellViewModel.swift
//  iTunesClient
//
//  Created by Rohit Devnani on 23/8/17.
//  Copyright © 2017 Rohit Devnani. All rights reserved.
//

import Foundation
import UIKit

// this is to accept the data in a particular format
// Accepts it and then outputs it

struct AlbumCellViewModel {
    let artwork: UIImage
    let title: String
    let releaseDate: String
    let genre: String
}

extension AlbumCellViewModel {
    init(album: Album) {
        self.artwork = album.artworkState == .downloaded ? album.artwork! : #imageLiteral(resourceName: "AlbumPlaceholder")
        self.title = album.censoredName
        self.genre = album.primaryGenre.name
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd, yyyy"
        
        self.releaseDate = formatter.string(from: album.releaseDate)
    }
}















































