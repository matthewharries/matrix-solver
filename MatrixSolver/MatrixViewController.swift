//
//  MatrixViewController.swift
//  MatrixSolver
//
//  Created by Matthew Harries on 7/3/18.
//  Copyright © 2018 Matthew Harries. All rights reserved.
//

import UIKit



class MatrixViewController: UIViewController {

    @IBOutlet weak var matrixStackView: UIStackView!
    @IBOutlet weak var rowsTextField: UITextField!
    @IBOutlet weak var columnsTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    private var rows: Int = 3
    private var columns: Int = 3

    private var matrixTextViews: [[UITextField]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rowsTextField.delegate = self
        columnsTextField.delegate = self
        rowsTextField.text = "\(rows)"
        columnsTextField.text = "\(columns)"
        setUpMatrix()
    }
    
    private func setUpMatrix() {
        matrixStackView.removeAllArrangedSubviews()
        matrixTextViews.removeAll()
        for _ in 0..<rows {
            var textFields: [UITextField] = []
            for _ in 0..<columns {
                let textField = UITextField()
                textField.addConstraints(getConstraints(forTextView: textField))
                textField.backgroundColor = .groupTableViewBackground
                textField.textAlignment = .center
                textField.contentVerticalAlignment = .center
                textField.font = UIFont.systemFont(ofSize: 20)
                textField.keyboardType = .decimalPad
                textFields.append(textField)
            }
            let rowStackView = UIStackView(arrangedSubviews: textFields)
            rowStackView.alignment = .center
            rowStackView.distribution = .fill
            rowStackView.spacing = 8
            rowStackView.contentMode = .scaleToFill
            matrixStackView.addArrangedSubview(rowStackView)
            matrixTextViews.append(textFields)
        }
    }
    
    private func getConstraints(forTextView textView: UITextField) -> [NSLayoutConstraint] {
        let minHeightConstraint = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
        let maxHeightConstraint = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
        let minWidthConstraint = NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60)
        let maxWidthConstraint = NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        return [minWidthConstraint, minHeightConstraint, maxWidthConstraint, maxHeightConstraint]
    }
}

extension MatrixViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let _ = Int(textField.text ?? "") else {
            let alert = UIAlertController(title: "Invalid Number", message: "Please enter a valid integer", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return false
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        rows = Int(rowsTextField.text ?? "") ?? 3
        columns = Int(columnsTextField.text ?? "") ?? 3
        setUpMatrix()
    }
}










