//
//  RequestManager.swift
//  ImagesApp
//
//  Created by Pavel Tsiareschcanka on 19.02.21.
//

import UIKit

class RequestManager {
    
    static let shared = RequestManager()
    
    private init() {}
    
    func getImage(sucsess: @escaping ((UIImage?) -> ()), failure: @escaping (() -> ())) {
        
        let url = URL(string: "http://loremflickr.com/200/200/")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                if let data = data, error == nil {
                    let image = UIImage(data: data)
                    sucsess(image)
                } else {
                    
                    failure()
                }
            } else {
                
                failure()
            }
        }
        
        task.resume()
    }
}
