//
//  DetailViewController.swift
//  TestUniquetechnologi
//
//  Created by Максим Мирошниченко on 13.10.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    
    var jSONPlaceholder: JSONPlaceholder?
    var photo: Photo?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        configureTitleLabel()
        configurePhotoImageView()
    }
    
    private func configureTitleLabel() {
        titleLabel.text = photo?.title
    }
    
    private func configurePhotoImageView() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        jSONPlaceholder?.downloadPhoto(urlString: photo?.url ?? "Error", completion: { [weak self] image in
            guard self != nil else { return }
            DispatchQueue.main.async {
                self?.photoImageView.image = image
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        })
    }
    
}
