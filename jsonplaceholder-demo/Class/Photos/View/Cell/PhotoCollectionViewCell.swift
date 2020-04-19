//
//  PhotoCollectionViewCell.swift
//  jsonplaceholder-demo
//
//  Created by Mack Liu on 2020/4/6.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoIdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(viewModel: PhotoCellViewModel) {
        self.photoIdLabel.text = viewModel.photoID
        self.titleLabel.text = viewModel.title
        self.photoImageView.image =  nil
        
        viewModel.onFetchPhotoCompletion = { [weak self] (id, image) in
            if (self?.photoIdLabel.text == id) {
                DispatchQueue.main.async {
                    self?.photoImageView.image = image
                }
            }
        }
        
        viewModel.fetchPhoto()
    }
}
