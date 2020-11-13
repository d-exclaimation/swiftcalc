//
//  Matrix-Elimination.swift
//  Math Solver
//
//  Created by Vincent on 11/2/20.
//

import Foundation


extension Array where Element == Array<Double> {
    var echelon: [[Double]] {
        var copy = self.map{$0}
        for x in copy.indices {
            if x < copy.count - 1 {
                for i in x + 1..<copy.count {
                    let coef = copy[i][x] / copy[x][x]
                    copy[i] = copy[i] - (coef * copy[x])
                }
            }
        }
        return copy
    }
    
    func showEchelonSteps() {
        var copy = self.map{$0}
        print("Step begin here \n")
        for x in copy.indices {
            if x < copy.count - 1 {
                for i in x + 1..<copy.count {
                    let coef = copy[i][x] / copy[x][x]
                    copy[i] = copy[i] - (coef * copy[x])
                }
                print(copy.compressed)
            }
        }
    }
    
}

extension Array where Element == Double {
    
    static public func * (lhs: Double, rhs: [Double]) -> [Double] {
        return rhs.map{ lhs * $0 }
    }
}
