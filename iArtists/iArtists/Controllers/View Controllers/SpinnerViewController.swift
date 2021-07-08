//
//  SpinnerViewController.swift
//  iArtists
//
//  Created by Mike Conner on 7/7/21.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
                
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

} // End of class
