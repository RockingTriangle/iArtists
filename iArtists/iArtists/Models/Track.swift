//
//  Track.swift
//  iArtists
//
//  Created by Mike Conner on 7/7/21.
//

import Foundation

struct Tracks: Codable {
    
    // MARK: - Properties
    let results: [Track]
    
} // End of struct

struct Track: Codable {
    
    // Properties
    /// - iTunes API Result Keys
    private let artistName          : String?
    private let trackName           : String?
    private let releaseDate         : String?
    private let primaryGenreName    : String?
    private let trackPrice          : Double?
    private let trackCover          : String?
    private let trackPreview        : String?
    
    enum CodingKeys: String, CodingKey {
        case artistName, trackName, releaseDate, primaryGenreName, trackPrice
        case trackCover   = "artworkUrl100"
        case trackPreview = "previewUrl"
    }
    
    /// Properties for use in App to prevent API from providing nil values resulting in crash.
    var displayArtistName       : String { artistName                   ?? "Not Available" }
    var displayTrackName        : String { trackName                    ?? "Not Available" }
    var displayPrimaryGenreName : String { primaryGenreName             ?? "N/A" }
    var displayReleaseDate      : String { convertDateToDisplayString() ?? "N/A" }
    var displayTrackCover       : String { trackCover                   ?? "itunesSearch" }
    var displayTrackPreview     : String { trackPreview                 ?? "" }
    var displayTrackPrice       : String {
        if let trackPrice = trackPrice {
            if trackPrice < 0 {
                return "N/A"
            }
            return "$\(trackPrice)"
        } else { return "N/A" }
    }
    /// Helper property for sorting data.
    var sortingDate             : String { releaseDate                  ?? "N?A" }

    /// Helper function to convert API string to desired display format.
    func convertDateToDisplayString() -> String? {
        if let releaseDate = releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: releaseDate)
            dateFormatter.dateFormat = "MMM dd, yyyy"
            if let date = date {
                return dateFormatter.string(from: date)
            }
        }
        return "N/A"
    } // End of convertDateToDisplayString function
    
} // End of struct
