//
//  ArtistTrackTableViewCell.swift
//  iArtists
//
//  Created by Mike Conner on 7/7/21.
//

import UIKit

// MARK: - Protocol
protocol ShowAudioPreviewViewController: AnyObject {
    func previewTrack(urlString: String)
}

class ArtistTrackTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackPreviewButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    
    // MARK: - Properties
    var networkManager: NetworkManager?
    weak var delegate: ShowAudioPreviewViewController?
    var track: Track? {
        didSet {
            loadTrackCover(with: track?.displayTrackCover ?? "itunesSearch")
        }
    }
    
    // MARK: - IBActions
    @IBAction func trackPreviewButtonTapped(_ sender: UIButton) {
        guard let delegate = delegate, let track = track else { return }
        delegate.previewTrack(urlString: track.displayTrackPreview)
    }
    
    // MARK: - Functions
    private func updateView() {
        guard let track = track else { return }
        
        let borderColor = CGColor(gray: 0.5, alpha: 1)
        cellView.layer.borderColor       = borderColor
        trackImageView.layer.borderColor = borderColor
        
        cellView.layer.shadowPath       = UIBezierPath(rect: cellView.bounds).cgPath
        cellView.layer.shadowColor      = CGColor(gray: 0.5, alpha: 0.8)
        cellView.layer.shadowOpacity    = 1
        cellView.layer.shadowOffset     = .init()
        cellView.layer.shadowRadius     = 5
        
        artistNameLabel.text  = track.displayArtistName
        trackNameLabel.text   = track.displayTrackName
        genreNameLabel.text   = track.displayPrimaryGenreName
        releaseDateLabel.text = track.displayReleaseDate
        trackPriceLabel.text  = track.displayTrackPrice
    }
    
    private func loadTrackCover(with urlString: String) {
        guard let networkManager = networkManager else { return }
        networkManager.downloadTrackCover(fromURLString: urlString) { image in
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
