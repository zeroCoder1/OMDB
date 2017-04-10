//
//  SSCollapsibleView.swift
//  testOmdb
//
//  Created by shrutesh sharma on 19/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation
import UIKit

class SSCollapsibleView: UIView {
    
    var minHeight: CGFloat = 0
    var maxHeight: CGFloat = 0
    var minOffset: CGFloat = 0
    
    var heightConstraint: NSLayoutConstraint?
    
    var compensateBottomScrollingArea: Bool = false
    var resizingEnabled: Bool = true
    
    var attachedScrollview = UIScrollView() {
        didSet {
            
            var contentInset = self.attachedScrollview.contentInset
            contentInset.top = self.maxHeight
            self.attachedScrollview.contentInset = contentInset
            self.attachedScrollview.scrollIndicatorInsets = contentInset
            self.attachedScrollview.contentOffset = CGPoint(x: self.attachedScrollview.contentOffset.x, y: -self.frame.height)
            
            self.scrollViewSizeChanged(self.attachedScrollview, change: self.attachedScrollview.contentSize)
            self.minOffset = 0.0
        }
    }
    
    // MARK: - Private Properties
    
    internal var inset: CGFloat = 0
    
    // MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Setup
    
    internal func setup() {
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.minHeight = 0.0
        self.maxHeight = self.frame.height
    }
    
    /// Adds the `Stretchable View` on top of any `UIScrollView`
    ///
    /// - parameter scrollView: `UITableView` or an `UIScrollView`
    /// - parameter inset:      Y position of the parent view
    func attachToScrollView(_ scrollView: UIScrollView, inset:CGFloat) {
        if let s = scrollView.superview{
            self.attachToScrollView(scrollView, parentView: s, inset: inset)
        }
    }
    
    internal func attachToScrollView(_ scrollView: UIScrollView, parentView:UIView, inset:CGFloat) {
        self.inset = inset
        
        var frame = self.frame
        frame.origin.x = parentView.frame.origin.x
        frame.origin.y = parentView.frame.origin.y + inset
        frame.size.width = parentView.frame.width
        self.frame = frame
        parentView.addSubview(self)
        self.attachedScrollview = scrollView
    }
    
    /// Changes the offser of the scrollview
    ///
    /// - parameter scrollView: The parent scrollview
    /// - parameter change:     scrollView.contentOffset
    internal func scrollViewOffsetChanged(_ scrollView:UIScrollView, change:CGPoint?) {
        if !self.resizingEnabled {
            return
        }
        
        let newYOffset = change?.y
        
        guard let newY = newYOffset else {return}
        
        var frame = self.frame
        frame.origin.y = newY + self.inset
        
        let relativePosition = newY + self.maxHeight - self.minOffset
        let heightCheck = self.maxHeight - relativePosition
        
        if relativePosition >= 0 {
            if heightCheck < self.minHeight{
                self.heightConstraint?.constant = self.minHeight
            } else {
                self.heightConstraint?.constant = self.maxHeight - relativePosition
            }
        } else {
            self.heightConstraint?.constant = self.maxHeight
        }
    }
    
    /// Changes the size of the scrollview
    ///
    /// - parameter scrollView: The parent scrollview
    /// - parameter change:     scrollView.contentSize
    internal func scrollViewSizeChanged(_ scrollView:UIScrollView, change:CGSize?) {
        
        if !self.resizingEnabled {
            return
        }
        
        if let newValue = change {
            
            var contentInset = scrollView.contentInset
            
            if scrollView.contentSize.height < scrollView.frame.size.height {
                contentInset.bottom = (scrollView.frame.size.height - newValue.height)
            } else {
                contentInset.bottom = (self.compensateBottomScrollingArea ? self.maxHeight : 0.0)
            }
            
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
        }
    }
}

// MARK: - UIScrollViewDelegate

extension SSCollapsibleView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollViewSizeChanged(scrollView, change: scrollView.contentSize)
        self.scrollViewOffsetChanged(scrollView, change: scrollView.contentOffset)
    }
}
