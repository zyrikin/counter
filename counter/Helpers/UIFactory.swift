//
//  UIFactory.swift
//  oupai
//
//  Created by Nik Zakirin on 10/03/16.
//  Copyright © 2016 Oupai365. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

final class UIFactory {
    class func activityIndicator(_ size: CGFloat = 60, color: UIColor = UIColor.primary) -> NVActivityIndicatorView {
        let spinner = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: size, height: size), type: .ballPulse /*BallScaleMultiple*/, color: color)
        return spinner
    }
}
