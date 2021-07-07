//
//  ArtistTrackTableViewCell.swift
//  iArtists
//
//  Created by Mike Conner on 7/7/21.
//

import UIKit

class ArtistTrackTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    

    // MARK: - Properties
    var track: Track? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Functions
    func updateView() {
        guard let track = track else { return }
        artistNameLabel.text  = track.displayArtistName
        trackNameLabel.text   = track.displayTrackName
        genreNameLabel.text   = track.displayPrimaryGenreName
        releaseDateLabel.text = track.displayReleaseDate
        trackPriceLabel.text  = track.displayTrackPrice
    }

} // End of class
