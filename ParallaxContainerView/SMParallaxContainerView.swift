//
//  SMParallaxContainerView.swift
//  Parallax
//
//  Created by OLEKSANDR SEMENIUK on 5/29/18.
//  Copyright © 2018 ПАО «Ростелеком». All rights reserved.
//

import UIKit

public typealias SMParallaxContainerViewClosureType = ((_ size: CGSize) -> UIView)

open class SMParallaxContainerView: UIView {
    
    @IBInspectable open var isEnabledHorizontalParallax: Bool = true
    @IBInspectable open var isEnabledVerticaleParallax: Bool = true
    @IBInspectable open var isInvertedHorizontalParallax: Bool = false
    @IBInspectable open var isInvertedVerticaleParallax: Bool = false
    
    var isNeedScaleContainerView: Bool = true
    var parallaxScale: CGPoint = CGPoint(x: 1.5, y: 1.5) {
        didSet {
            updateImagesFrame()
        }
    }
    
    private let containerView = UIView()
    private var contentOffsetObservation: NSKeyValueObservation?

    open var createSubviewClosure: SMParallaxContainerViewClosureType? {
        didSet {
            if let view = createSubviewClosure?(containerView.frame.size) {
                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view.clipsToBounds = true
                containerView.addSubview(view)
            }
        }
    }
    
    // MARK: ScrollView
    
    private weak var _parentScrollView: UIScrollView? {
        didSet {
            contentOffsetObservation?.invalidate()
            contentOffsetObservation = _parentScrollView?.observe(\.contentOffset, options: [.new], changeHandler: { [weak self] _, _ in
                self?.updateImagesFrame()
            })
        }
    }
    
    open var parentScrollView: UIScrollView? {
        
        if _parentScrollView == nil {
            _parentScrollView = responderInHierarchy(of: UIScrollView.self)
        }
        
        return _parentScrollView
    }
    
    // MARK: deinit, init
    
    deinit {
        contentOffsetObservation?.invalidate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        
        clipsToBounds = true

        addSubview(containerView)
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        updateImagesFrame()
    }
    
    // MARK: Override
    
    override open func removeFromSuperview() {
        super.removeFromSuperview()
        
        _parentScrollView = nil
    }

    override open func didMoveToWindow() {
        super.didMoveToWindow()
        
        initializeScrollView()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.updateImagesFrame()
        }
    }
    
    // MARK: Logic
    
    open func initializeScrollView() {
        
        _ = parentScrollView
    }

    open func updateImagesFrame() {
        
        let isVisible = parentScrollView?.isVisible(view: self) ?? false
        
        if isVisible, let scrollView = parentScrollView {
            
            let rectViewInScroll: CGRect = convert(bounds, to: scrollView)

            let selfOffset = CGPoint(x: rectViewInScroll.origin.x - scrollView.contentOffset.x, y: rectViewInScroll.origin.y - scrollView.contentOffset.y)
            
            let percentX = (selfOffset.x + frame.size.width) / (scrollView.frame.size.width + frame.size.width)
            let percentY = (selfOffset.y + frame.size.height) / (scrollView.frame.size.height + frame.size.height)
            
            let paralaxSize = CGSize(width: (frame.size.width * (parallaxScale.x - 1)), height: (frame.size.height * (parallaxScale.y - 1)))

            var newPosition = containerView.center

            if isEnabledHorizontalParallax {
                newPosition.x = frame.size.width / 2 + paralaxSize.width * (percentX - 0.5) * (isInvertedHorizontalParallax ? -1 : 1)
            }

            if isEnabledVerticaleParallax {
                newPosition.y = frame.size.height / 2 + paralaxSize.height * (percentY - 0.5) * (isInvertedVerticaleParallax ? -1 : 1)
            }
            
            if isNeedScaleContainerView {
                containerView.frame = CGRect(x: 0, y: 0, width: bounds.size.width * parallaxScale.x, height: bounds.size.height * parallaxScale.y)
            } else {
                containerView.frame = bounds
            }
            
            containerView.center = newPosition
        }
    }
}

public extension UIScrollView {
    
    public func isVisible(view aView: UIView) -> Bool {
        
        let visibleFrame = CGRect(origin: CGPoint(x: contentOffset.x, y: contentOffset.y), size: frame.size)
        let rectViewInScroll: CGRect = aView.convert(aView.bounds, to: self)

        let result = visibleFrame.intersects(rectViewInScroll)
        return result
    }
}

public extension UIResponder {
    
    public func responderInHierarchy<T: UIResponder>(of type: T.Type) -> T? {
        
        if self is T {
            return self as? T
        }
        
        var responder = self.next
        while responder != nil {
            if let viewController = responder as? T {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
}
