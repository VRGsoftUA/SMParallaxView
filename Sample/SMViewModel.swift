//
//  SMViewModel.swift
//  SMParallaxView
//
//  Created by OLEKSANDR SEMENIUK on 6/12/18.
//  Copyright © 2018 OLEKSANDR SEMENIUK. All rights reserved.
//

import UIKit

class SMViewModel {
    
    let images: [UIImage]
    
    init(images: [UIImage]) {
        self.images = images
    }
    
    static func createDemoModels() -> [SMViewModel] {
        
        var models: [SMViewModel] = []
        
        for i in 1...4 {
            
            let backgroundImageName: String = "bg\(i)"
            let frontImageName: String = "front\(i)"
            
            if let backgroundImage: UIImage = UIImage(named: backgroundImageName),
                let frontImage: UIImage = UIImage(named: frontImageName) {
                
                let model: SMViewModel = SMViewModel(images: [backgroundImage, frontImage])
                models.append(model)
            }
        }
        
        return models
    }
}
