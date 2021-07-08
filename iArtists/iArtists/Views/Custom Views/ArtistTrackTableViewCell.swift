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
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackPreviewButton: UIButton!
    
    // MARK: - Properties
    var isPlaying: Bool = false
    var track: Track? {
        didSet {
            loadTrackCover(with: track?.displayTrackCover ?? "itunesSearch")
        }
    }
    
    // MARK: - IBActions
    @IBAction func trackPreviewButtonTapped(_ sender: UIButton) {
        guard let track = track else { return }
        
    }
    
    // MARK: - Functions
    private func updateView() {
        guard let track = track else { return }
        artistNameLabel.text  = track.displayArtistName
        trackNameLabel.text   = track.displayTrackName
        genreNameLabel.text   = track.displayPrimaryGenreName
        releaseDateLabel.text = track.displayReleaseDate
        trackPriceLabel.text  = track.displayTrackPrice
    }
    
    private func loadTrackCover(with urlString: String) {
        NetworkManager.shared.downloadTrackCover(fromURLString: urlString) { image in
            DispatchQueue.main.async {
                if let image = image {
                    self.trackImageView.image = image
                } else {
                    self.trackImageView.image = UIImage(named: "itunesSearch")
                }
                self.updateView()
            }
        }
    }

} // End of class
