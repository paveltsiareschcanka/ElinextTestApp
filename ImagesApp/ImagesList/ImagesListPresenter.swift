//
//  ImagesListPresenter.swift
//  ImagesApp
//
//  Created by Pavel Tsiareschcanka on 19.02.21.
//

import UIKit

class ImageModel {
    var image: UIImage? = nil
    var dataIsLoading = false
}

class ImagesListPresenter {
    
    //MARK: - Private properties
    
    private var imagesList: [ImageModel] = []
    
    private weak var view: ImagesListViewInput!
    
    //MARK: - Init
    
    init(withView view: ImagesListView) {
        self.view = view
    }
}

//MARK: - Extension view output

extension ImagesListPresenter: ImagesListViewOutput {
    
    func numberOfItems() -> Int {
        imagesList.count
    }
    
    func cellDataAt(_ indexPath: IndexPath) -> UIImage? {
        
        let imageData = self.imagesList[indexPath.row]
        
        if imageData.image == nil && imageData.dataIsLoading == false {
            
            imagesList[indexPath.row].dataIsLoading = true
            
            RequestManager.shared.getImage { image in
                DispatchQueue.main.async { [weak self] in
                    
                    guard let self = self else { return }
                    self.imagesList[indexPath.row].image = image
                    self.view.reloadImageItemAt(indexPath)
                }
            } failure: {
                DispatchQueue.main.async { [weak self] in
                    
                    guard let self = self else { return }
                    self.imagesList[indexPath.row].dataIsLoading = false
                    self.view.reloadImageItemAt(indexPath)
                }
            }
            
        }
        
        return imageData.image
    }
    
    func didTapAddImageBtn() {
        
        self.imagesList.append(ImageModel())
        view.reloadImagesCollection()
        view.scrollToLast()
    }
    
    func didTapReloadDataBtn() {
        
        imagesList.removeAll()
        
        var index = 0
        
        repeat {
            
            self.imagesList.append(ImageModel())
            index += 1
        } while index < 140
        
        view.reloadImagesCollection()
    }
}
