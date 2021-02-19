//
//  UIViewController.swift
//  ImagesApp
//
//  Created by Pavel Tsiareschcanka on 19.02.21.
//

import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    func getSafeAreaTopPading() -> CGFloat {
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let topPadding = window?.safeAreaInsets.top ?? 0.0
        
        return topPadding
    }
    
    func getSafeAreaBottomPading() -> CGFloat {
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
        
        return bottomPadding
    }
    
    func getNavBarHeight() -> CGFloat {
        
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0.0
        
        return navBarHeight
    }
}
