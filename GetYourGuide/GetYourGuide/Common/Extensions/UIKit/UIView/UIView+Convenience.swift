//
// Created by Nickolay Sheika on 2019-08-10.
// Copyright (c) 2019 Nickolay Sheika. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Nib
extension UIView {
    static var nib: UINib {
        let bundle = Bundle(for: self as AnyClass)
        let nib = UINib(nibName: String(describing: self), bundle: bundle)
        return nib
    }
}

// MARK: - Layout

extension UIView {
    func pinViewToEdgesOfSuperview(leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraints([
                                      superview!.leftAnchor.constraint(equalTo: leftAnchor, constant: leftOffset),
                                      superview!.rightAnchor.constraint(equalTo: rightAnchor, constant: rightOffset),
                                      superview!.topAnchor.constraint(equalTo: topAnchor, constant: topOffset),
                                      superview!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomOffset)
                                  ])
    }

    func pinViewToCenterOfSuperview(offsetX: CGFloat = 0.0, offsetY: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraints([
                                      centerXAnchor.constraint(equalTo: superview!.centerXAnchor, constant: offsetX),
                                      centerYAnchor.constraint(equalTo: superview!.centerYAnchor, constant: offsetY)
                                  ])
    }

    func pinViewWidthAndHeight(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraints([
                                      widthAnchor.constraint(equalToConstant: width),
                                      heightAnchor.constraint(equalToConstant: height)
                                  ])
    }

    func pinViewToBottomOfSuperview(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraints([
                                      heightAnchor.constraint(equalToConstant: height),
                                      superview!.leftAnchor.constraint(equalTo: leftAnchor),
                                      superview!.rightAnchor.constraint(equalTo: rightAnchor),
                                      superview!.bottomAnchor.constraint(equalTo: bottomAnchor)
                                  ])
    }
}
