//
//  MatrixCalculator.swift
//  MatrixSolver
//
//  Created by Matthew Harries on 8/4/18.
//  Copyright © 2018 Matthew Harries. All rights reserved.
//

import Foundation

class MatrixCalculator {
    
    /**
        Recursive function to calculate the determinant of a matrix.
     
        - returns:
            a `double` representing the determinant of the given matrix
     
        - parameters:
            - matrix: The matrix whose determinant is to be calculated.
                Must be an square (n x n) matrix.
    */
    static func determinant(of matrix: [[Double]]) -> Double {
        guard matrix.count == matrix.first?.count else {
            return 0.0
        }
        
        var determinant = 0.0
        let dimension = matrix.count
        
        // base case
        if dimension == 1 {
            return matrix[0][0]
        }
        // used to alternate sign depending upon position in matrix
        var sign: Double = 1.0
        
        // iterate through top row, getting cofactor of each element.
        for col in 0..<dimension {
            let cofactor = getCofactor(forRow: 0, andColumn: col, of: matrix)
            determinant += sign * matrix[0][col] * MatrixCalculator.determinant(of: cofactor)
            sign = -sign
        }
        
        return determinant
    }
    
    private static func getCofactor(forRow row: Int, andColumn column: Int, of matrix: [[Double]]) -> [[Double]] {
        let dimension = matrix.count
        var cofactor = [[Double]]()
        
        for currentRow in 0..<dimension {
            guard currentRow != row else { continue }
                cofactor.append([Double]())
            for currentColumn in 0..<dimension {
                //ignore row and column of cofactor
                guard currentRow != row && currentColumn != column else {
                    continue
                }
                cofactor[cofactor.count - 1].append(matrix[currentRow][currentColumn])
            }
        }
        return cofactor
    }
}
