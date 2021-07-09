//
//  AudioPlayerViewController.swift
//  iArtists
//
//  Created by Mike Conner on 7/8/21.
//

import WebKit

class AudioPlayerViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var webViewPlayer: WKWebView!
    @IBOutlet weak var dismissButton: UIButton!
    
    // MARK: - Properties
    var urlString: String?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadSoundPreview()
    }
    
    // MARK: - IBActions
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: - Functions
    func setupViews() {
        webViewPlayer.navigationDelegate = self
        webViewPlayer.alpha = 0
        dismissButton.alpha = 0
        
        self.view.showBlurLoader()
        
        webViewPlayer.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
    }
    
    func loadSoundPreview() {
        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }
        
        self.webViewPlayer.load(URLRequest(url: url))
    }
    
    // MARK: - Overrides
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            if !webViewPlayer.isLoading {
                self.view.removeBlurLoader()
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 1.0) {
                        self.webViewPlayer.alpha = 1
                        self.dismissButton.alpha = 1
                    }
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
} // End of class
