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
    let networkManager = NetworkManager()
    var delegate: ReloadTableViewProtocol?
    var artistName: String = ""
    var sortingMethod: SortingMethod = .newestFirst
    var artistTracks: [Track] = [] {
        didSet {
            artistTracks.removeAll { !$0.displayArtistName.lowercased().contains(artistName.lowercased()) }
            switch sortingMethod {
            case .aToZ:
                artistTracks.sort { $0.displayTrackName < $1.displayTrackName }
            case .zToA:
                artistTracks.sort { $0.displayTrackName > $1.displayTrackName }
            case .newestFirst:
                artistTracks.sort { $0.sortingDate > $1.sortingDate }
            case .oldestFirst:
                artistTracks.sort { $0.sortingDate < $1.sortingDate }
            }
        }
    }
    
    // MARK: - Functions
    func getArtistTracks() {
        networkManager.searchParameter = artistName
        networkManager.searchArtistTracks { [weak self] result in
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
