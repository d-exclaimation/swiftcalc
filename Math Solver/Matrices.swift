//
//  Matrices.swift
//  Math Solver
//
//  Created by Vincent on 11/9/20.
//

import Foundation

extension Array where Element == [Double] {
    
    var size: [Int] {
        let y = self.count
        var x = 0
        for i in self.indices {
            x = self[i].count
        }
        return [y, x]
    }
    
    static public func +(lhs: [[Double]], rhs: [[Double]]) -> [[Double]]? {
        guard lhs.size[0] == rhs.size[0] && lhs.size[1] == rhs.size[1] else {
            return nil
        }
        var newValue = [[Double]]()
        for i in lhs.indices {
            var row = [Double]()
            for j in lhs[i].indices {
                row.append(lhs[i][j] + rhs[i][j])
            }
            newValue.append(row)
        }
        return newValue
    }
    
    static public func -(lhs: [[Double]], rhs: [[Double]]) -> [[Double]]? {
        guard lhs.size[0] == rhs.size[0] && lhs.size[1] == rhs.size[1] else {
            return nil
        }
        
        var newValue = [[Double]]()
        for i in lhs.indices {
            var row = [Double]()
            for j in lhs[i].indices {
                row.append(lhs[i][j] - rhs[i][j])
            }
            newValue.append(row)
        }
        return newValue
    }
    
    static public func *(lhs: [[Double]], rhs: [[Double]]) -> [[Double]]? {
        guard rhs.size[0] == lhs.size[1] else {
            return nil
        }
        
        var newValue = [[Double]]()
        for i in 0..<lhs.size[0] {
            var row = [Double]()
            for j in 0..<rhs.size[1] {
                var column = [Double]()
                for x in lhs[i].indices {
                    column.append(rhs[x][j])
                }
                //print("\(lhs[i]) and \(column)")
                row.append(lhs[i].dot(with: column) ?? 0)
            }
            newValue.append(row)
        }
        return newValue
    }
    
    var description: String {
        var newValue = ""
        for i in self.indices {
            newValue += "\(self[i])\n"
        }
        return newValue
    }
    
    static func identity(of size: Int) -> [[Double]] {
        var newValue = [[Double]]()
        for i in 0..<size {
            var row = [Double]()
            for j in 0..<size {
                if i == j {
                    row.append(1)
                } else {
                    row.append(0)
                }
            }
            newValue.append(row)
        }
        
        return newValue
    }
    
    var inverse: [[Double]] {
        findInverse() ?? [[Double]]()
    }
    
    private func findInverse() -> [[Double]]? {
        var id = [[Double]].identity(of: self.count)
        var copy = self.map{$0}
        
        // Echelon form
        for i in copy.indices {
            
            // For each pivots
            for j in i + 1..<copy.count {
                
                // Find the coefisien from the current row
                // to the pivot row
                let coef = copy[j][i] / copy[i][i]
                
                // Apply row operations to elimate anything in the same column as pivot
                copy[j] = copy[j] - (coef * copy[i])
                id[j] = id[j] - (coef * id[i]) // Applying to identify to find inverse
            }
        }
        
        // Create identify from the echelon form
        for x in copy.indices {
            
            let rev = copy.count - 1 - x
            for y in 0..<rev {
                let coef = copy[y][rev] / copy[rev][rev]
                copy[y] = copy[y] - (coef * copy[rev])
                id[y] = id[y] - (coef * id[rev])
            }
        }
        // Fixing minuses
        for p in copy.indices {
            if copy[p][p] < 0 {
                copy[p] = -1 * copy[p]
                id[p] = -1 * id[p]
            }
        }
        
        if copy == [[Double]].identity(of: copy.count) {
            return id
        }
        return nil
    }
    
    
    static public func ==(lhs: [[Double]], rhs: [[Double]]) -> Bool {
        guard lhs.size[0] == rhs.size[0] && lhs.size[1] == rhs.size[1] else {
            return false
        }
        for i in lhs.indices {
            for j in lhs[i].indices {
                if lhs[i][j] != rhs[i][j] {
                    return false
                }
            }
        }
        
        return true
    }
    
    static public func ^(lhs: [[Double]], rhs: Int) -> [[Double]] {
        
        // Make sure matrix is a grid of square
        guard lhs.size[0] == lhs.size[1] else {
            return [[Double]]()
        }
        
        var copy = lhs.map{$0}
        
        // For each power - 1 multiply result with itself
        for _ in 0..<rhs - 1 {
            copy = (copy * lhs)!
        }
        return copy
    }
    
    var tranpose: [[Double]] {
        guard self.size[0] == self.size[1] else {
            return [[Double]]()
        }
        var copy = self.map{$0}
        for i in self.indices {
            for j in self[i].indices {
                copy[j][i] = self[i][j]
            }
        }
        return copy
    }
}
