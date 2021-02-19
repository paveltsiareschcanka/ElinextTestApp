//
//  ImageCell.swift
//  ImagesApp
//
//  Created by Pavel Tsiareschcanka on 19.02.21.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Public properties
    
    var image: UIImage? {
        didSet {
            updateUI()
        }
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: - Setups
    
    private func setupUI() {
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 7
        containerView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        imageView.contentMode = .scaleAspectFill
        
        activityIndicator.hidesWhenStopped = true
    }
    
    //MARK: - Private functions
    
    private func updateUI() {
        
        if let image = self.image {
            
            imageView.image = image
            activityIndicator.stopAnimating()
        } else {
            
            imageView.image = nil
            activityIndicator.startAnimating()
        }
    }
}
