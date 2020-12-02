//
// Arithmetic extension for Array<Double>
// Created by Vincent on 12/2/20.
//

import Foundation

fileprivate func testDoubleArithmetic() {
    // Arithmetic Test Function
    print(2 * [0.0, 1.0, 2.0])
    print([0.0, 1.0, 2.0] + [0.0, 1.0, 2.0])
    print([0.0, 1.0, 2.0] - [0.0, 1.0, 2.0])
    print([0.0, 1.0, 2.0].dot([0.0, 1.0, 2.0]))
    print([0.0, 1.0, 2.0].summed)
}

extension Array where Element == Double {
    public static func *(lhs: Double, rhs: Self) -> Self {
        rhs.map{ $0 * lhs } // Multiply each element
    }

    public static func +(lhs: Self, rhs: Self) -> Self {
        // Create a new array with the size of the minimum and the elements of the addition product
        if lhs.count <= rhs.count {
            return lhs.indices.map{ lhs[$0] + rhs[$0] }
        }
        return rhs.indices.map{ lhs[$0] + rhs[$0] }
    }

    public static func -(lhs: Self, rhs: Self) -> Self {
        // Create a new array with the size of the minimum and the elements of the subtraction product
        if lhs.count <= rhs.count {
            return lhs.indices.map{ lhs[$0] - rhs[$0] }
        }
        return rhs.indices.map{ lhs[$0] - rhs[$0] }
    }

    public func dot(_ rhs: Self) -> Double? {
        // Check for the right size
        guard self.count == rhs.count else {
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

extension Array where Element == Double {
    var summed: Double {
        var newValue = 0.0
        self.forEach { newValue += $0 }
        return newValue
    }
}