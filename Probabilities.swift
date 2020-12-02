//
// Probabilities extension for Integers
// Created by Vincent on 12/2/20.
//

import Foundation

fileprivate func testProbabilities() {
    // Probabilities Test Function
    print(10.commonFactor(with: 5))
    print(10.factorial)
    print(4.permute(with: 2))
    print(5.combine(with: 2))
}

extension Int {
    func commonFactor(with other: Int) -> Int {
        // Try to get a common factor
        var result: Int = 0
        if abs(self) > abs(other) {
            result = abs(other)
        } else {
            result = abs(self)
        }

        // Looping for correct factors
        while self % result != 0 || other % result != 0 {
            result -= 1
        }

        return result
    }

    var factorial: Int {
        if self <= 1 {
            return 1
        }
        return self * (self - 1).factorial
    }

    func permute(with num: Int) -> Double {
        Double(self.factorial) / Double((self - num).factorial)
    }

    func combine(with num: Int) -> Double {
        Double(self.factorial) / (Double((self - num).factorial) * Double((num).factorial))
    }
}