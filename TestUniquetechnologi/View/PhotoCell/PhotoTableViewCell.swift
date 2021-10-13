//
//  PhotoTableViewCell.swift
//  TestUniquetechnologi
//
//  Created by Максим Мирошниченко on 13.10.2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    
    static let identifier = "PhotoTableViewCell"
    
    var jSONPlaceholder: JSONPlaceholder?
    private var photo: Photo?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helpers
    
    func configure(photo: Photo, jSONPlaceholder: JSONPlaceholder) {
        self.jSONPlaceholder = jSONPlaceholder
        self.photo = photo
        configureTitleLabel()
        configurePhotoImageView()
    }
    
    private func configureTitleLabel() {
        titleLabel.text = photo?.title
    }
    
    private func configurePhotoImageView() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        jSONPlaceholder?.downloadPhoto(urlString: photo?.thumbnailUrl ?? "Error", completion: { [weak self] image in
            guard self != nil else { return }
            DispatchQueue.main.async {
                self?.photoImageView.image = image
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        })
    }
    
}
