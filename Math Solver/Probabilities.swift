//
//  Probabilities.swift
//  Math Solver
//
//  Created by Vincent on 10/26/20.
//

import Foundation

extension Double {
    
    // factorial
    public var factorial: Double {
        if self <= 1 {
            return 1
        }
        return self * (self - 1).factorial
    }
    
    // Find fraction
    var fraction: String {
        let num: Int = Int(100 * self - 10 * self)
        let denom: Int = 90
        let fac = num.commonFactors(with: denom)
        return "\(num / fac) / \(denom / fac)"
    }
    
    // MARK: - Probabilities
    
    // Permute
    public func permute(with r: Double) -> Double {
        self.factorial / (self - r).factorial
    }
    
    // Combine
    public func combine(with r: Double) -> Double {
        self.factorial / ((self - r).factorial * r.factorial)
    }
    
}

extension Int {
    // Find common factor
    public func commonFactors(with p: Int) -> Int {
        let n = Int(self)
        var res = abs(n) > abs(p) ? abs(p) : abs(n)
        while n % res != 0 || p % res != 0 {
            res -= 1
        }
        return res
    }
}
