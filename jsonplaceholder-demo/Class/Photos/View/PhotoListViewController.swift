//
//  PhotoListViewController.swift
//  jsonplaceholder-demo
//
//  Created by Mack Liu on 2020/4/6.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var photoCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    let viewModel = PhotoListViewModel()
    
    // MARK: UIView Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        customCollectionViewFlowLayout()
    }
    
    // MARK: Initialization
    
    func initView() {
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        
    }
    
    func bindViewModel() {
        
        viewModel.onFetchComplection = { [weak self] in
            self?.photoCollectionView.reloadData()
        }
        
        viewModel.fetchPhotos()
    }
    
    func customCollectionViewFlowLayout() {
        
        let itemSpace: CGFloat = 3.0
        let numberOfItemsInColumn:CGFloat = 4
        let eachItemWidth = floor((self.photoCollectionView.bounds.width - (itemSpace * (numberOfItemsInColumn - 1))) / numberOfItemsInColumn)

        photoCollectionViewFlowLayout.itemSize = CGSize(width: eachItemWidth, height: eachItemWidth)
        photoCollectionViewFlowLayout.estimatedItemSize = .zero
        photoCollectionViewFlowLayout.minimumInteritemSpacing = itemSpace
        photoCollectionViewFlowLayout.minimumLineSpacing = itemSpace
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellViewModel = viewModel.photoCellsViewModel![indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath)
        
        if let cell = cell as? PhotoCollectionViewCell {
            cell.setup(viewModel: cellViewModel)
        }
        
        return cell
    }
}
