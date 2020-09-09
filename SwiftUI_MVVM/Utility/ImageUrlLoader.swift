//
//  ImageUrlLoader.swift
//  SwiftUI_MVVM
//
//  Created by Gaurav Gandhale on 02/06/20.
//  Copyright © 2020 Gaurav Gandhale. All rights reserved.
//

import SwiftUI

class ImageUrlLoader: ObservableObject {
    
    @Published var imageData = Data()
    let service: NetworkServiceProtocol? = ServiceLocator.instance.get(service: NetworkServiceProtocol.self)
    
    init(url: String) {
        fetchUrl(url: url)
    }
    
    func fetchUrl(url: String) {
        service?.fetchImage(url) { (data) in
            DispatchQueue.main.async { [weak self] in
                guard let data = data else { return }
                self?.imageData = data
            }
        }
    }
}
