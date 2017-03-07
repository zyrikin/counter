//
//  UIView+Additions.swift
//  oupai
//
//  Created by zaria on 30.1.16.
//  Copyright © 2016 Oupai365. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

enum ShakeDirection {
    case horizontal, vertical
}

extension UIView {
    func animateViewTappedWithCompletion(_ closure: @escaping () -> Void) {
        
        self.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.2, delay: 0.1, options: UIViewAnimationOptions(), animations: { () -> Void in
            if (self.transform != CGAffineTransform(scaleX: 0.97, y: 0.97)) {
                self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            }
            }) { finished in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                    self.transform = CGAffineTransform.identity
                    }, completion: { finished in
                        self.isUserInteractionEnabled = true
                        closure()
                })
        }
    }
    
    func setRoundedView() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2.0
    }
    
    func shake(_ times: Int = 10, delta: CGFloat = 10, duration: TimeInterval = 0.03, shakeDirection: ShakeDirection = .horizontal) {
        shake(times, direction: 1, currentTimes: 0, delta: delta, duration: duration, shakeDirection: shakeDirection)
    }
}

private extension UIView {
    func shake(_ times: Int, direction: Int, currentTimes: Int, delta: CGFloat, duration: TimeInterval, shakeDirection: ShakeDirection) {
        
        UIView.animate(withDuration: duration, animations: { 
            self.transform = (shakeDirection == .horizontal) ? CGAffineTransform(translationX: delta * CGFloat(direction), y: 0) : CGAffineTransform(translationX: 0, y: delta * CGFloat(direction))
            }, completion: { finished in
            if currentTimes >= times {
                self.transform = CGAffineTransform.identity
                return;
            }
            
            self.shake(times-1, direction: direction * -1, currentTimes: currentTimes + 1, delta: delta, duration: duration, shakeDirection: shakeDirection)
        })
        
    }
}

extension UIView {
    class func hairline(_ isHorizontal: Bool = true) -> UIView {
        return {
            let hairline = UIView()
            hairline.backgroundColor = UIColor.hairline
            hairline.snp.makeConstraints({ make in
                let thickness = 1/UIScreen.main.scale
                if isHorizontal {
                    make.height.equalTo(thickness)
                }
                else {
                    make.width.equalTo(thickness)
                }
            })
            return hairline
            }()
    }
    
    class func style(container: UIView) {
        container.layer.borderColor = Constants.Layer.borderColor
        container.layer.borderWidth = Constants.Layer.borderWidth
        
        container.layer.cornerRadius =  Constants.Layer.cornerRadius
        container.layer.shadowColor = Constants.Layer.shadowColor
        container.layer.shadowRadius = Constants.Layer.shadowRadius
        container.layer.shadowOffset = Constants.Layer.shadowOffset
        container.layer.shadowOpacity = Constants.Layer.shadowOpacity
        container.layer.masksToBounds = false
    }
}
