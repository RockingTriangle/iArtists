//
//  Track.swift
//  iArtists
//
//  Created by Mike Conner on 7/7/21.
//

import Foundation

struct Tracks: Codable {
    
    let results: [Track]
    
} // End of struct

struct Track: Codable {
    
    // Properties
    /// - iTunes API Result Keys
    let artistName          : String?
    let trackName           : String?
    let releaseDate         : String?
    let trackPrice          : String?
    let primaryGenreName    : String?
    
    /// Properties for use in App to prevent API from providing nil values resulting in crash.
    var displayArtistName       : String { artistName       ?? "Not Available" }
    var displayTrackName        : String { trackName        ?? "Not Available" }
    var displayReleaseDate      : String { releaseDate      ?? "Not Available" }
    var displayTrackPrice       : String { trackPrice       ?? "Not Available" }
    var displayPrimaryGenreName : String { primaryGenreName ?? "Not Available" }
    
} // End of struct
