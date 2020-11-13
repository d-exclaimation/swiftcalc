//
//  Vectors.swift
//  VectorGeometry
//
//  Created by Vincent on 10/26/20.
//

import Foundation

extension Array where Element == Double {
    
    // Adding Vectors for all dimension size
    static public func + (lhs: Array<Double>, rhs: Array<Double>) -> Array<Double> {
        
        // Add all elements
        var result = [Double]()
        if lhs.count != rhs.count {
            return result
        }
        
        result = lhs.indices.map { lhs[$0] + rhs[$0] }
        return result
    }
    
    // Substracting vectors for all dimensions
    static public func - (lhs: Array<Double>, rhs: Array<Double>) -> Array<Double> {
        
        // Substract all elements
        var result = [Double]()
        if lhs.count != rhs.count {
            return result
        }
        result = lhs.indices.map { lhs[$0] - rhs[$0] }
        return result
    }
    
    // Magnitude unsquared
    var magnitudeUnSquared: Double {
        var res = 0.0
        for i in self {
            res += pow(i, 2)
        }
        return res
    }
    
    // Magnitude Squared Properly
    var magnitude: Double {
        self.magnitudeUnSquared.squareRoot()
    }
    
    // Dot product with other vectors
    public func dot (with b: [Double]) -> Double? {
        if self.count != b.count {
            return nil
        }
        var result = 0.0
        for i in self.indices {
            result += self[i] * b[i]
            //print("\(self[i]) * \(b[i])")
        }
        return result
    }
    
    // Check for perpendicular / orthogonal
    public func isOrthogonal(with b: [Double]) -> Bool {
        guard let dotProduct = self.dot(with: b) else {
            return false
        }
        return dotProduct == 0
    }
    
    // MARK: - Planes

    // Cross product on works at with R^3
    static public func * (lhs: Array<Double>, rhs: Array<Double>) -> Array<Double> {
        
        // Create a new result array
        var newValue = [Double]()
        
        // Cross mostly only works with R^3 vectors
        if lhs.count != 3 || rhs.count != 3 { return newValue }
        
        // Loop 3 times to find determinant
        for i in 0...2 {
            let newLhs = lhs.indices.filter { $0 != i }.map { lhs[$0] } // New Array beside the index
            let newRhs = rhs.indices.filter { $0 != i }.map { rhs[$0] } // New Array beside the index
            // print("(\(newLhs.first!) * \(newRhs.last!) - \(newLhs.last!) * \(newRhs.first!))" + ["i", "j", "k"][i])
            // Determinant is going to be this formula
            let deter = (newLhs.first! * newRhs.last!) - (newLhs.last! * newRhs.first!)
            
            // Append it
            newValue.append( i == 1 ? -1 * deter : deter)
        }
        //print("(\(newValue[0]))i + (\(newValue[1]))j + (\(newValue[2]))k")
        return newValue
    }
    
    static public func scaleFrom(ro: [Double], d: [Double], e: [Double]) -> String {
        let n = d * e
        return "\(Int(n[0]))x+\(Int(n[1]))y+\(Int(n[2]))z = \(Int(ro.dot(with: n)!))"
    }
    
    static public func vectorPointNormal(ro: [Double], d: [Double], e: [Double]) -> String {
        let n = d * e
        print("(r - \(ro) . \(n) = 0")
        return "(r - \(ro.map{Int($0)})) . \(n.map{Int($0)}) = 0"
    }
    
    static public func vectorParametric(d: Double, x: Double, y: Double, z: Double) -> String {
        let ro = [d, 0.0, 0.0]
        let newD = [-y, 1, 0]
        let e = [-z, 0, 1]
        return "\(ro.map{Int($0)}) + s\(newD.map{Int($0)}) + t\(e.map{Int($0)})"
    }
    
    static public func vectorParametric(ro: [Double], n: [Double]) -> String {
        let d = n * [Double].i
        print(d)
        let e = n * [Double].j
        print(e)
        return "\(ro.map{Int($0)}) + s\(d.map{Int($0)}) + t\(e.map{Int($0)})"
    }
    
    static var i: [Double] = [1,0,0]
    static var j: [Double] = [0,1,0]
    static var k: [Double] = [0,0,1]
    
}

public func parallelogram(of n: [Double], and p: [Double]) -> Double {
    (n * p).magnitude
}

public func triangle(of n: [Double], and p: [Double]) -> Double {
    (n * p).magnitude * 0.5
}
