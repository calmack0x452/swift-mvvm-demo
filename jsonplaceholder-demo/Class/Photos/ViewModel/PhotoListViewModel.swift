//
//  PhotoListViewModel.swift
//  jsonplaceholder-demo
//
//  Created by Mack Liu on 2020/4/5.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit
import Alamofire

class PhotoListViewModel: NSObject {
    
    var photoCellsViewModel: [PhotoCellViewModel]?
    
    var numberOfPhotos: Int {
        return photoCellsViewModel?.count ?? 0
    }
    
    var onFetchComplection: (() -> Void)?
    
    public func fetchPhotos() {
        
        AF.request("https://jsonplaceholder.typicode.com/photos").responseJSON { [weak self] response in
            switch response.result {
                case .success:
                    if response.data != nil {
                        let decoder = JSONDecoder()
                        
                        if let photosData = try? decoder.decode([PhotoModel].self, from: response.data!) {
                            self?.convertPhotosDataToViewModel(dataModels: photosData)
                            self?.onFetchComplection?()
                        }
                        else {
                            print("Decoded Error:")
                        }
                    }
                break
                
                case let .failure(error):
                    print("Fetch Error: \(error.localizedDescription)")
                break
            }
        }
    }
    
    func convertPhotosDataToViewModel(dataModels: [PhotoModel]) {
        photoCellsViewModel = [PhotoCellViewModel]()
        
        for data in dataModels {
            let viewModel = PhotoCellViewModel(dataModel: data)
            photoCellsViewModel?.append(viewModel)
        }
    }
 }
