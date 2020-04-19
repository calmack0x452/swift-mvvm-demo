//
//  PhotoCellViewModel.swift
//  jsonplaceholder-demo
//
//  Created by Mack Liu on 2020/4/5.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit
import Alamofire

class PhotoCellViewModel: NSObject {

    let photoID: String
    let title: String
    let thumbnailUrl: String
    
    var onFetchPhotoCompletion: ((String, UIImage) -> Void)?
    
    private let photoCache = NSCache<NSURL, UIImage>()
    
    init(dataModel: PhotoModel) {
        self.photoID = String(dataModel.id)
        self.title = dataModel.title
        self.thumbnailUrl = dataModel.thumbnailUrl
    }
    
    func fetchPhoto() {
        let photoUrl = NSURL(string: thumbnailUrl)!
        
        if let image = photoCache.object(forKey: photoUrl) {
            self.onFetchPhotoCompletion?(self.photoID, image)
            return
        }
        
        AF.download(self.thumbnailUrl).responseData { [weak self] response in
            switch response.result {
                case .success:
                    if let imageData = response.value,
                        let image = UIImage(data: imageData) {
                        
                        self?.photoCache.setObject(image, forKey: photoUrl)
                        self?.onFetchPhotoCompletion?(self?.photoID ?? "", image)
                    }
                break
                
                case let .failure(error):
                    print("Fetch Error: \(error.localizedDescription)")
                break
            }
        }
    }
}
