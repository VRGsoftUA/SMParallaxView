//
//  SMMoreViewController.swift
//  SMParallaxView
//
//  Created by OLEKSANDR SEMENIUK on 6/12/18.
//  Copyright © 2018 OLEKSANDR SEMENIUK. All rights reserved.
//

import UIKit

class SMMoreViewController: UIViewController {
    
    @IBOutlet weak var paralaxView: SMParallaxMultiView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        paralaxView.backImageView.image = UIImage(named: "bg")
        paralaxView.frontImageView.contentMode = .center
        paralaxView.frontImageView.image = UIImage(named: "front")
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
}
