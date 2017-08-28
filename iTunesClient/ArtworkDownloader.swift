//
//  ArtworkDownloader.swift
//  iTunesClient
//
//  Created by Rohit Devnani on 26/8/17.
//  Copyright © 2017 Rohit Devnani. All rights reserved.
//

import Foundation
import UIKit


class ArtworkDownloader: Operation {
    let album: Album
    
    init(album: Album) {
        self.album = album
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: album.artworkUrl) else {
            return
        }
        
        // getting URL from server
        
        let imageData = try! Data(contentsOf: url)
        // TODO: Error Handling
        
        if self.isCancelled {
            return
        }
        
        // Checking if the data is valid
        if imageData.count > 0 {
            album.artwork = UIImage(data: imageData)
            album.artworkState = .downloaded
        } else {
            album.artworkState = .failed
        }
        
        
    }
}


























