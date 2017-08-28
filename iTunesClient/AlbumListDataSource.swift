//
//  AlbumListDataSource.swift
//  iTunesClient
//
//  Created by Rohit Devnani on 22/8/17.
//  Copyright © 2017 Rohit Devnani. All rights reserved.
//
//



import UIKit

class AlbumListDataSource: NSObject, UITableViewDataSource {
    
    private var albums: [Album]
    
    let pendingOperations = PendingOperations()
    var tableView = UITableView()
    
    
    init(albums: [Album], tableView: UITableView) {
        self.albums = albums
        self.tableView = tableView
        super.init()
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.reuseIdentifier, for: indexPath) as! AlbumCell
        
        let album = albums[indexPath.row]
        let viewModel = AlbumCellViewModel(album: album)
        
        albumCell.configure(with: viewModel)
        albumCell.accessoryType = .disclosureIndicator
        
        // Firing off a request for album artwork
        if album.artworkState  == .placeholder {
            downloadArtworkForAlbum(album, atIndexPath: indexPath)
        }
        
        return albumCell
    }
    
    // MARK: - Helper
    
    func album(at indexPath: IndexPath) -> Album {
        return albums[indexPath.row]
}


    // MARK : IMAGE LOGIC
    
func update(with albums: [Album]) {
    self.albums = albums
}
    
    // Defining a new method for artwork
    
    func downloadArtworkForAlbum(_ album: Album, atIndexPath indexPath: IndexPath) {
        // In this method, we're going to create an operation using the album,add it to the operation queue, and execute the logic.
        // We are omiting the instance name as we dont care about the operation, just want to check if its in the dictionary
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
        // Creating the instance of the downloader for the cell
        let downloader = ArtworkDownloader(album: album)
        
        // Displaying the image by trigrring the tableview load process
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            // Reloading the tableview
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}













