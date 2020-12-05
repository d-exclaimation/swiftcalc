//
// Arithmetic extension for Array<Double>
// Created by Vincent on 12/2/20.
//

import Foundation

public extension Array where Element == Double {
    static func *(lhs: Double, rhs: Self) -> Self {
        rhs.map{ $0 * lhs } // Multiply each element
    }

    static func +(lhs: Self, rhs: Self) -> Self {
        // Create a new array with the size of the minimum and the elements of the addition product
        if lhs.count <= rhs.count {
            return lhs.indices.map{ lhs[$0] + rhs[$0] }
        }
        return rhs.indices.map{ lhs[$0] + rhs[$0] }
    }

    static func -(lhs: Self, rhs: Self) -> Self {
        // Create a new array with the size of the minimum and the elements of the subtraction product
        if lhs.count <= rhs.count {
            return lhs.indices.map{ lhs[$0] - rhs[$0] }
        }
        return rhs.indices.map{ lhs[$0] - rhs[$0] }
    }

    func dot(_ rhs: Self) -> Double? {
        // Check for the right size
        guard count == rhs.count else {
            return nil
        }

        // Simple array dot product
        var newValue = 0.0
        self.indices.forEach {
            newValue += self[$0] * rhs[$0]
        }
        return newValue
    }
}

public extension Array where Element == Double {
    var summed: Double {
        var newValue = 0.0
        self.forEach { newValue += $0 }
        return newValue
    }
}