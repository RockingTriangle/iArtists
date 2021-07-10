//
//  BlurLoader.swift
//  iArtists
//
//  Created by Mike Conner on 7/7/21.
//

import UIKit

class BlurLoader: UIView {
    
    // MARK: - Properties
    var blurEffectView: UIVisualEffectView?
    
    // MARK: - Init
    override init(frame: CGRect) {
        let blurEffect                  = UIBlurEffect(style: .dark)
        let blurEffectView              = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame            = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView             = blurEffectView
        
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func addLoader() {
        guard let blurEffectView    = blurEffectView else { return }
        let activityIndicator       = UIActivityIndicatorView(style: .large)
        activityIndicator.color     = .white
        activityIndicator.frame     = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center    = blurEffectView.contentView.center
        
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
} // End of class

// MARK: - Extension
/// UIView extension for use with BlurLoader Class
extension UIView {
    
    func showBlurLoader() {
        let blurLoader = BlurLoader(frame: frame)
        self.addSubview(blurLoader)
    }

    func removeBlurLoader() {
        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
            blurLoader.removeFromSuperview()
        }
    }
    
} // End of extension

