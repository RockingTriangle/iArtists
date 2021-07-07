//
//  ArtistSearchViewController.swift
//  iArtists
//
//  Created by Mike Conner on 7/7/21.
//

import UIKit

class ArtistSearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var modelController = ArtistSearchModelController()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func searchArtistButtonTapped(_ sender: Any) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    // MARK: - Functions

}

extension ArtistSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelController.artistTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as? ArtistTrackTableViewCell else { return UITableViewCell() }
        cell.track = modelController.artistTracks[indexPath.row]
        return cell
    }
}

extension ArtistSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        modelController.artistName = text
        modelController.getArtistTracks()
    }
}
