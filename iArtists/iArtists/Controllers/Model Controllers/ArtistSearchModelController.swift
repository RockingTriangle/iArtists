//
//  ArtistSearchModelController.swift
//  iArtists
//
//  Created by Mike Conner on 7/7/21.
//

import Foundation

// MARK: - Protocol for reloading tableview
protocol ReloadTableViewProtocol {
    func reloadTableView()
}

class ArtistSearchModelController {
    
    // MARK: - Properties
    var delegate: ReloadTableViewProtocol?
    var artistName: String = ""
    var artistTracks: [Track] = [] {
        didSet {
            artistTracks.removeAll { !$0.displayArtistName.lowercased().contains(artistName.lowercased()) }
        }
    }
    
    // MARK: - Functions
    func getArtistTracks() {
        NetworkManager.shared.searchParameter = artistName
        NetworkManager.shared.searchArtistTracks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tracks):
                self.artistTracks = tracks
            case .failure(let error):
                switch error {
                case .noData:
                    self.artistTracks = []
                default:
                    print(error.errorDescription ?? "Failure to complete request: \(error)")
                }
            }
            self.delegate?.reloadTableView()
        }
    } // End of getArtistTracks function
    
} // End of struct
