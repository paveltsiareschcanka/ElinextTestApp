//
//  ImagesListVIew.swift
//  ImagesApp
//
//  Created by Pavel Tsiareschcanka on 19.02.21.
//

import UIKit

protocol ImagesListViewInput: AnyObject {
    func reloadImagesCollection()
    func reloadImageItemAt(_ indexPath: IndexPath)
    func scrollToLast()
}

protocol ImagesListViewOutput: AnyObject {
    func numberOfItems() -> Int
    func cellDataAt(_ indexPath: IndexPath) -> UIImage?
    func didTapAddImageBtn()
    func didTapReloadDataBtn()
}

class ImagesListView: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet private weak var imagesCollection: UICollectionView!
    
    //MARK: - Public properties
    
    var presenter: ImagesListViewOutput!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupCollectionView()
        setupCollectionViewLayout()
    }
    
    //MARK: - Setups
    
    private func setupNavBar() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        let reloadButton = UIBarButtonItem(title: "Reload All", style: .plain, target: self, action: #selector(reloadItems))
        
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = reloadButton
    }
    
    private func setupCollectionView() {
        
        imagesCollection.delegate = self
        imagesCollection.dataSource = self
        
        let imageCellNib = UINib(nibName: "ImageCell", bundle: nil)
        imagesCollection.register(imageCellNib, forCellWithReuseIdentifier: "ImageCell")
    }
    
    private func setupCollectionViewLayout() {
        
        // spacing beetween cells
        let widthSpacing = 16 // 8 * 2
        let heightSpacing = 18 // 9 * 2
        
        let screenSize = UIScreen.main.bounds
        
        let layout = UICollectionViewFlowLayout()
        
        let paddings = getSafeAreaBottomPading() + getSafeAreaTopPading() + getNavBarHeight()
        
        let cellWidth: CGFloat = CGFloat((screenSize.width - CGFloat(widthSpacing)) / 7)
        let cellHeight: CGFloat = CGFloat((screenSize.height - paddings - CGFloat(heightSpacing)) / 10)
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        layout.scrollDirection = .horizontal
        
        imagesCollection.collectionViewLayout = layout
    }
    
    //MARK: - Private functions
    
    @objc private func addItem() {
        presenter?.didTapAddImageBtn()
    }
    
    @objc private func reloadItems() {
        presenter?.didTapReloadDataBtn()
    }
}

//MARK: - Extension view input

extension ImagesListView: ImagesListViewInput {
    
    func reloadImagesCollection() {
        self.imagesCollection.reloadData()
    }
    
    func reloadImageItemAt(_ indexPath: IndexPath) {
        self.imagesCollection.reloadItems(at: [indexPath])
    }
    
    func scrollToLast() {
        
        let item = imagesCollection.numberOfItems(inSection: 0) - 1
        let lastItemIndex = IndexPath(item: item, section: 0)
        self.imagesCollection.scrollToItem(at: lastItemIndex, at: .left, animated: true)
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ImagesListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        imageCell.image = presenter.cellDataAt(indexPath)
        return imageCell
    }
}
