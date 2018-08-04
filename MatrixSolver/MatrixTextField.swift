//
//  MatrixTextField.swift
//  MatrixSolver
//
//  Created by Matthew Harries on 8/4/18.
//  Copyright © 2018 Matthew Harries. All rights reserved.
//

import UIKit

class MatrixTextField: UITextField {
    var row: Int
    var column: Int
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        row = 0
        column = 0
        super.init(coder: aDecoder)
    }
}
