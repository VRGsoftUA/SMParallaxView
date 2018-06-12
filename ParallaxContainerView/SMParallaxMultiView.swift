//
//  SMParallaxMultiView.swift
//  Paralax
//
//  Created by OLEKSANDR SEMENIUK on 5/29/18.
//  Copyright © 2018 ПАО «Ростелеком». All rights reserved.
//

import UIKit

open class SMParallaxMultiView: UIView {

    let parallaxFrontView = SMParallaxContainerView()
    let parallaxBackView = SMParallaxContainerView()
    
    let titleImageView = UIImageView()
    let frontImageView = UIImageView()
    let backImageView = UIImageView()
    
    @IBInspectable open var backgroundTopCropValue: CGFloat = 0 {
        didSet {
            parallaxBackView.frame.origin.y = backgroundTopCropValue
            parallaxBackView.frame.size.height = bounds.size.height - backgroundTopCropValue
        }
    }
    
    @IBInspectable open var imagesCornerRadius: CGFloat = 0.0 {
        didSet {
            titleImageView.layer.cornerRadius = imagesCornerRadius
            parallaxFrontView.layer.cornerRadius = imagesCornerRadius
            parallaxBackView.layer.cornerRadius = imagesCornerRadius
            
            titleImageView.layer.masksToBounds = true
            parallaxFrontView.layer.masksToBounds = true
            parallaxBackView.layer.masksToBounds = true
        }
    }
    
    open var images: [UIImage]? {
        didSet {
            clearImages()
            if let images = images {
                
                let imageViews = [backImageView, frontImageView, titleImageView]
                
                for (imageView, image) in zip(imageViews, images) {
                    imageView.image = image
                }
            }
        }
    }
    
    // MARK: init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    open func setup() {
        
        clipsToBounds = true
        
        addView(parallaxBackView)
        addView(parallaxFrontView)
        addView(titleImageView)

        titleImageView.clipsToBounds = true
        titleImageView.contentMode = .scaleAspectFill

        let createFrontViewColosure: SMParallaxContainerViewClosureType = { [unowned self] size in
            
            self.frontImageView.frame = CGRect(origin: CGPoint.zero, size: size)
            self.frontImageView.contentMode = .scaleAspectFit

            return self.frontImageView
        }
        
        parallaxFrontView.createSubviewClosure = createFrontViewColosure
        parallaxFrontView.isEnabledVerticaleParallax = true
        parallaxFrontView.parallaxScale = CGPoint(x: 1.5, y: 1.5)
        parallaxFrontView.isNeedScaleContainerView = false

        let createBackViewColosure: SMParallaxContainerViewClosureType = { [unowned self] size in
            
            self.backImageView.frame = CGRect(origin: CGPoint.zero, size: size)
            self.backImageView.contentMode = .scaleAspectFill
            
            return self.backImageView
        }

        parallaxBackView.createSubviewClosure = createBackViewColosure
        parallaxBackView.isEnabledVerticaleParallax = true
        parallaxBackView.parallaxScale = CGPoint(x: 1.1, y: 1.1)
        parallaxBackView.isInvertedHorizontalParallax = true
    }
    
    open func addView(_ aView: UIView) {
        
        addSubview(aView)
        aView.frame = bounds
        aView.backgroundColor = .clear
        aView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        aView.clipsToBounds = true
    }
    
    // MARK: ClearImages
    
    open func clearImages() {
        
        titleImageView.image = nil
        frontImageView.image = nil
        backImageView.image = nil
    }
}
