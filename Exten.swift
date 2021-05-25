//
//  Exten.swift
//  My Wedding Day
//
//  Created by Ivana Fidanovska on 4/22/21.
//  Copyright © 2021 Fidanovska. All rights reserved.
//

import Foundation
import UIKit


let LOADING_VIEW_KEY = "LoadingView"
var HEADER_HEIGHT: CGFloat = 0

extension UIView{
    
    func showLoader(disableTouchEvents: Bool){
        let loader:LoadView = Bundle.main.loadNibNamed(LOADING_VIEW_KEY, owner: self, options: nil)?.first as! LoadView
        loader.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        loader.loadingViewCenterConstraint.constant = HEADER_HEIGHT
        loader.loadingView.color = #colorLiteral(red: 0.9843137255, green: 0.8196078431, blue: 0.8509803922, alpha: 0.9993043664)
        loader.loadingView.type = .lineSpinFadeLoader
        loader.loadingView.startAnimating()
        loader.isUserInteractionEnabled = false

        self.addSubview(loader)
    }
    
    func hideLoader(){
        let loader:LoadView = Bundle.main.loadNibNamed(LOADING_VIEW_KEY, owner: self, options: nil)?.first as! LoadView
            for subview in self.subviews {
                if let view = subview as? LoadView{
                    view.loadingView.stopAnimating()
                    subview.removeFromSuperview()
                }
            }
        loader.isUserInteractionEnabled = true
        }
}
