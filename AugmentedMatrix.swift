//
// Augmented Matrix and Echelon Steps
// Created by Vincent on 12/2/20.
//

import Foundation


fileprivate func testAugMatrix() {
    // TODO: Test Cases here
    let scenarios: [String: String] = [
        "\(AugmentedMatrix(auto: [[1, 2], [3, 4]], with: [5, 7]).echelon()!)": "1.0, 2.0 | 5.0\n0.0, -2.0 | -8.0\n",
    ]

    for (key, value) in scenarios {
        testWithString(of: key, expected: value)
    }
}

struct AugmentedMatrix: CustomStringConvertible {
    private(set) var matrix: [[Double]]
    private(set) var result: [Double]

    var description: String {
        var res = ""
        matrix.indices.forEach { i in
            res += matrix[i].map{ String($0) }.joined(separator: ", ") + " | \(result[i])\n"
        }
        return res
    }

    init?(_ core: [[Double]], _ res: [Double]) {
        // Validate the parameters
        if core.count == res.count {
            matrix = core
            result = res
        } else {
            return nil
        }
    }

    init(auto core: [[Double]], with res: [Double]) {
        matrix = core
        if res.count >= core.count {
            result = core.indices.map{ res[$0] }
        } else {
            result = res + Array((0..<(core.count - res.count))).map{ Double($0 * 0) }
        }
    }

    func echelon() -> AugmentedMatrix? {
        // Finding the best echelon steps
        var newGrid = self.matrix
        var newRes = self.result

        // Loop through each possible pivots and try to remove anything below the pivots
        for i in newGrid.indices {
            for j in (i + 1)..<newGrid.count {
                let coef = newGrid[j][i] / newGrid[i][i]
                // Do row elimination with the coeficient
                newGrid[j] = newGrid[j] - (coef * newGrid[i])
                newRes[j] = newRes[j] - (coef * newRes[i])
            }
        }

        return AugmentedMatrix(auto: newGrid, with: newRes)
    }

    func echelonSteps() -> Void {
        // Finding the best echelon steps
        var newGrid = self.matrix
        var newRes = self.result

        print("Steps begin here!")
        // Loop through each possible pivots and try to remove anything below the pivots
        for i in newGrid.indices {
            for j in (i + 1)..<newGrid.count {
                let coef: Double = newGrid[j][i] / newGrid[i][i]
                // Do row elimination with the coeficient
                newGrid[j] = newGrid[j] - (coef * newGrid[i])
                newRes[j] = newRes[j] - (coef * newRes[i])

                // Show current progress
                print("\(AugmentedMatrix(auto: newGrid, with: newRes))")
            }
        }
    }
}