//
//  ArtistSearchModelController.swift
//  iArtists
//
//  Created by Mike Conner on 7/7/21.
//

import Foundation

struct ArtistSearchModelController {
    
    // MARK: - Properties
    var artistName: String = ""
    var artistTracks: [Track] = []
    
    // MARK: - Functions
    func getArtistTracks() {
        print(artistName)
    }
} // End of struct
