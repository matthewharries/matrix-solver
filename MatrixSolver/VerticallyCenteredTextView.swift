//
//  VerticallyCenteredTextView.swift
//  MatrixSolver
//
//  Created by Matthew Harries on 7/17/18.
//  Copyright © 2018 Matthew Harries. All rights reserved.
//

import UIKit

class VerticallyCenteredTextView: UITextView {
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        }
    }
}
