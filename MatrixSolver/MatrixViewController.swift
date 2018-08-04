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
    @IBOutlet weak var matrixLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var matrixTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var matrixBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var matrixTrailingConstraint: NSLayoutConstraint!
    
    
    private var rows: Int = 3
    private var columns: Int = 3

    private var matrixTextViews: [[MatrixTextField]] = []
    
    let maxWidth: CGFloat = 100
    let minWidth: CGFloat = 60
    let maxHeight: CGFloat = 80
    let minHeight: CGFloat = 50

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rowsTextField.delegate = self
        columnsTextField.delegate = self
        rowsTextField.text = "\(rows)"
        columnsTextField.text = "\(columns)"
    }

    override func viewDidAppear(_ animated: Bool) {
        setUpMatrix()
    }
    
//    override func viewDidLayoutSubviews() {
//        setUpMatrix()
//    }
//
    // MARK: - IBActions
    
    @IBAction func determinant(_ sender: Any) {
        guard rows == columns else {
            //display alert saying matrix must be square
            let alert = UIAlertController(title: "Invalid Matrix Size", message: "Matrix must be square in order to calculate its determinant", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        if let matrix = getMatrixFromUI() {
            let det = MatrixCalculator.determinant(of: matrix)
            let alert = UIAlertController(title: "Determinant:", message: "\(det)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func inverse(_ sender: Any) {
    }
    
    @IBAction func transpose(_ sender: Any) {
    }
    
    // MARK: - Matrix methods
    private func setUpMatrix() {
        matrixStackView.removeAllArrangedSubviews()
        matrixTextViews.removeAll()
        for row in 0..<rows {
            var textFields: [MatrixTextField] = []
            for column in 0..<columns {
                let textField = MatrixTextField(row: row, column: column)
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
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
        centerMatrix()
    }
    
    private func getMatrixFromUI() -> [[Double]]? {
        var matrix: [[Double]] = Array(repeating: Array(repeating: 0.0, count: columns), count: rows)
        
        for textFieldArray in matrixTextViews {
            for textField in textFieldArray {
                guard let value = Double(textField.text ?? "") else {
                    let alert = UIAlertController(title: "Invalid Matrix", message: "Please enter valid matrix values", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(ok)
                    present(alert, animated: true, completion: nil)
                    return nil
                }
                matrix[textField.row][textField.column] = value
            }
        }
    
        return matrix
    }
    
    // MARK: - Helper Functions
    private func getConstraints(forTextView textView: UITextField) -> [NSLayoutConstraint] {
        let minHeightConstraint = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: minHeight)
        let maxHeightConstraint = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: maxHeight)
        let minWidthConstraint = NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: minWidth)
        let maxWidthConstraint = NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: maxWidth)
        return [minWidthConstraint, minHeightConstraint, maxWidthConstraint, maxHeightConstraint]
    }
    
    private func centerMatrix() {
        if matrixStackView.frame.size.width < scrollView.frame.size.width {
            matrixLeadingConstraint.constant = (scrollView.frame.size.width - matrixStackView.frame.size.width) / 2
        } else {
            matrixLeadingConstraint.constant = 4
        }
        
        if matrixStackView.frame.size.height < scrollView.frame.size.height {
            matrixTopConstraint.constant = (scrollView.frame.size.height - matrixStackView.frame.size.height) / 2
        } else {
            matrixTopConstraint.constant = 4
        }
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
    }
}

//MARK: - UITextFieldDelegate Methods
extension MatrixViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let _ = Double(textField.text ?? "") else {
            let alert = UIAlertController(title: "Invalid Number", message: "Please enter a valid matrix value", preferredStyle: .alert)
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










