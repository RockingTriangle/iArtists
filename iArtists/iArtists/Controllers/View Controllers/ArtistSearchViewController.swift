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
    let spinner = SpinnerViewController()
    var urlString: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        modelController.delegate = self
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.leftView?.tintColor = .black
    }
    
    // MARK: - IBActions
    @IBAction func searchArtistButtonTapped(_ sender: Any) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        modelController.artistTracks = []
        searchBar.text = ""
        searchBar.becomeFirstResponder()
        tableView.reloadData()
    }
    
    // MARK: - Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? AudioPlayerViewController, let urlString = urlString else { return }
        destinationVC.urlString = urlString
    }
    
} // End of class

// MARK: - Extensions
extension ArtistSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelController.artistTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath)
                as? ArtistTrackTableViewCell else { return UITableViewCell() }
        cell.trackImageView.image = nil
        cell.delegate = self
        cell.track = modelController.artistTracks[indexPath.row]
        return cell
    }
    
} // End of UITableViewDelegate/DataSource functions
extension ArtistSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        self.searchBar.endEditing(true)
        self.view.showBlurLoader()
        
        modelController.artistName = text
        modelController.getArtistTracks()
    }
    
} // End of UISearchBarDelegate functions
extension ArtistSearchViewController: ReloadTableViewProtocol {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            if self.modelController.artistTracks.count > 0 {
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                UIView.animate(withDuration: 1.0) {
                    self.view.removeBlurLoader()
                }
            } else {
                let alert = UIAlertController(title: "Sorry", message: "There were no results, please try a new search term.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.view.removeBlurLoader()
                }
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
        }
    }
    
} // End of ReloadTableViewProtocol functions

extension ArtistSearchViewController: ShowAudioPreviewViewController {
    
    func previewTrack(urlString: String) {
        self.urlString = urlString
        self.performSegue(withIdentifier: "showPlayer", sender: self)
    }
    
}
