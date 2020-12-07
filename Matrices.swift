//
// Matrices Objects
// Created by Vincent on 12/2/20.
//

import Foundation

// MARK: Matrix Object
public struct Matrix: CustomStringConvertible, Equatable {
    private(set) var grid: [[Double]]
    
    // Computer properties
    var width: Int { grid[0].count }
    var height: Int { grid.count }
    var isSquare: Bool { width == height }

    public var description: String {
        var newValue = ""
        grid.forEach { row in
            newValue += "\(row)\n"
        }
        newValue.removeLast()
        return newValue
    }
    
    static func identity(of size: Int) -> Matrix {
        var result = [[Double]]()
        for i in 0..<size {
            var row = [Double]()
            for j in 0..<size {
                if i == j {
                    row.append(1)
                } else {
                    row.append(0)
                }
            }
            result.append(row)
        }
        return Matrix(auto: result)
    }

    init?(_ grid: [[Double]]) {
        var isValid: Bool = true
        // Validate size
        for row in grid {
            if row.count != grid[0].count {
                isValid = false
            }
        }

        // Optional constructor
        if isValid {
            self.grid = grid
        } else {
            return nil
        }
    }

    init(auto grid: [[Double]]) {

        // Create a new grid for the matrix
        var newGrid = [[Double]]()

        // Loop through all rows
        for i in grid.indices {

            // Create a row that is always equal in size, either by cropping or adding 0s
            if grid[i].count >= grid[0].count {
                newGrid.append(grid[0].indices.map{ grid[i][$0] })
            } else {
                var row = grid[i]
                for _ in 0..<(grid[0].count - grid[i].count) {
                    row.append(0.0)
                }
                newGrid.append(row)
            }
        }

        // Construction
        self.grid = newGrid
    }

    // MARK: Simple Arithmetics
    public static func +(lhs: Matrix, rhs: Matrix) -> Matrix? {
        // Make sure size is the same otherwise exit with a nil
        guard lhs.width == rhs.width || lhs.height == rhs.height else {
            return nil
        }

        // Create a new grid to be the next Matrix
        var newValue = [[Double]]()

        // Loop through each indices and add all that element and put in the right order
        for i in lhs.grid.indices {
            var row = [Double]()
            for j in lhs.grid[i].indices {
                row.append(lhs.grid[i][j] + rhs.grid[i][j])
            }
            newValue.append(row)
        }
        return Matrix(auto: newValue)
    }
    
    public static func -(lhs: Matrix, rhs: Matrix) -> Matrix? {
        // Make sure size is the same otherwise exit with a nil
        guard lhs.width == rhs.width || lhs.height == rhs.height else {
            return nil
        }

        // Create a new grid to be the next Matrix
        var newValue = [[Double]]()

        // Loop through each indices and add all that element and put in the right order
        for i in lhs.grid.indices {
            var row = [Double]()
            for j in lhs.grid[i].indices {
                row.append(lhs.grid[i][j] - rhs.grid[i][j])
            }
            newValue.append(row)
        }
        return Matrix(auto: newValue)
    }

    // MARK: Complex Arithmetics
    public static func *(lhs: Int, rhs: Matrix) -> Matrix {
        var newValue = [[Double]]()

        // Multiply each element by the constant
        for i in rhs.grid.indices {
            var row = [Double]()
            for j in rhs.grid[i].indices {
                row.append(rhs.grid[i][j] * Double(lhs))
            }
            newValue.append(row)
        }
        return Matrix(auto: newValue)
    }

    public static func *(lhs: Matrix, rhs: Matrix) -> Matrix? {
        guard lhs.width == rhs.height else {
            return nil
        }

        // Set up a new grid for the new Matrix
        var newGrid = [[Double]]()

        // Loop through each row for the lhs, each column in the rhs
        for i in lhs.grid.indices {
            var row = [Double]()
            for j in rhs.grid[0].indices {

                // Create a column array for j from rhs
                var column = [Double]()
                for k in lhs.grid[i].indices {
                    column.append(rhs.grid[k][j])
                }

                // For the i and j, the element should be the dot product of row i from lhs with the column above
                row.append(lhs.grid[i].dot(column) ?? 0.0)
            }
            newGrid.append(row)
        }

        return Matrix(auto: newGrid)
    }

    public static func ^(lhs: Matrix, rhs: Int) -> Matrix? {
        // Only square matrix can be exponential
        guard lhs.isSquare else {
            return nil
        }

        // Multiply it by itself, rhs times
        var newValue = Matrix(auto: lhs.grid)
        for _ in 1..<rhs {
            newValue = (newValue * lhs) ?? newValue
        }
        return newValue
    }

    var determinant: Double {
        guard isSquare && width == 2 else {
            return 0
        }
        return grid[0][0] * grid[1][1] - grid[1][0] * grid[0][1]
    }

    // MARK:  Inverse matrix
    func inversed() -> Matrix? {
        guard isSquare else {
            return nil
        }

        if width == 2 {
            guard determinant != 0 else {
                return nil
            }
            return Int(determinant) * self
        }

        // Use echelon steps by having an augmented matrix with an identity as result block
        var ide: [[Double]] = Matrix.identity(of: height).grid
        var newGrid: [[Double]] = grid
        for i in newGrid.indices {
            for j in i + 1..<newGrid.count {
                let coef = newGrid[j][i] / newGrid[i][i]

                // Apply row operation to both the grid and the identity
                newGrid[j] = newGrid[j] - (coef * newGrid[i])
                ide[j] = ide[j] - (coef * ide[i])

                print("\(Matrix(auto: newGrid))\n")
            }
        }

        // Reduce every pivot to 1
        for k in newGrid.indices {
            newGrid[k] = (1 / newGrid[k][k]) * newGrid[k]
            ide[k] = (1 / newGrid[k][k]) * ide[k]
            print("\(Matrix(auto: newGrid))\n")
        }

        // Use echelon steps backwards to remove all that is not a pivot
        for i in newGrid.indices {
            let rev = newGrid.count - 1 - i
            for j in 0..<rev {
                let coef = newGrid[j][rev] / newGrid[rev][rev]

                // Apply row operations to both the grid and the identity
                newGrid[j] = newGrid[j] - (coef * newGrid[rev])
                ide[j] = ide[j] - (coef * ide[rev])
                print("\(Matrix(auto: newGrid))\n")
            }
        }

        // Eliminate all negatives
        for k in newGrid.indices {
            if newGrid[k][k] < 0 {
                newGrid[k] = -1.0 * newGrid[k]
                ide[k] = -1.0 * ide[k]
                print("\(Matrix(auto: newGrid))\n")
            }
        }

        return Matrix(auto: ide) // Hopefully by here the Matrix does not spewing its guts
    }

    // MARK: Equatable Operator
    public static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
        // Check for the same size
        guard lhs.width == rhs.width || lhs.height == rhs.height else {
            return false
        }

        // Check for each element in the grid
        for i in lhs.grid.indices {
            for j in lhs.grid[i].indices {
                if lhs.grid[i][j] != rhs.grid[i][j] {
                    return false
                }
            }
        }
        return true
    }

    func transposed() -> Matrix? {
        guard isSquare else {
            return nil
        }
        let newGrid = grid.indices.map { i in
            grid[i].indices.map { j in
                grid[j][i]
            }
        }
        return Matrix(auto: newGrid)
    }

}

