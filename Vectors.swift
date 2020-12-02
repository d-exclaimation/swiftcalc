//
// Vectors Objects
// Created by Vincent on 12/2/20.
//

import Foundation

fileprivate func testVectors() {
    // Test function for Vectors
    print("Vector3 Test:")
    testWithString(of: "\(Vector3(1, 2, 3) + Vector3(3, 6, 1))", expected: "Vector3 (\(4.0), \(8.0), \(4.0))")
    testWithString(of: "\(Vector3(1, 2, 3) - Vector3(3, 6, 1))", expected: "Vector3 (\(-2.0), \(-4.0), \(2.0))")
    testWithString(of: "\(Vector3(1, 2, 3).dot(Vector3(3, 6, 1)))", expected: "\(18.0)")
    testWithString(of: "\(10.0 * Vector3(1, 2, 3))", expected: "Vector3 (\(10.0), \(20.0), \(30.0))")
    testWithString(of: "\(Vector3(1, 2, 3) * Vector3(3, 6, 1))", expected: "Vector3 (\(2.0 - 18.0), \(1.0 - 9.0), \(0.0))")
    testWithString(of: "\(Vector3(1, 2, 3).isOrthogonal(to: Vector3(3, 6, 1)))", expected: "false")
    testWithString(of: "\(pow(Vector3(3, 6, 1).magnitude, 2))", expected: "46.0")
    testWithString(of: "\(Vector3(3, 6, 1) == Vector3(3, 6, 1))", expected: "true")
    testWithString(of: "\(Vector3.zero + Vector3.one + Vector3.right + Vector3.left)", expected: "Vector3 (\(1.0), \(1.0), \(1.0))")

    print("Vector2 Test:")
    var scenarios: [String: String] = [
        "\(Vector2.left + Vector2.right)": "Vector2 (\(0.0), \(0.0))",
        "\(Vector2.one - Vector2.right)": "Vector2 (\(0.0), \(1.0))",
    ]
    for key in scenarios.keys {
        testWithString(of: key, expected: scenarios[key] ?? "")
    }

}

// MARK: Vector3 Structure
struct Vector3: Equatable, CustomStringConvertible, AdditiveArithmetic {
    private var axis: [Double]

    // Computed properties
    var x: Double { axis[0] }
    var y: Double { axis[1] }
    var z: Double { axis[2] }

    // Static properties
    static var zero: Vector3 = Vector3(0, 0, 0)
    static var one: Vector3 = Vector3(1, 1, 1)

    // Static direction properties
    static var right: Vector3 = Vector3(1, 0, 0)
    static var left: Vector3 = Vector3(-1, 0, 0)
    static var up: Vector3 = Vector3(0, 1, 0)
    static var down: Vector3 = Vector3(0, -1, 0)
    static var forward: Vector3 = Vector3(0, 0, 1)
    static var back: Vector3 = Vector3(0, 0, -1)

    init(_ x: Double, _ y: Double, _ z: Double) {
        axis = [x, y, z]
    }

    init?(_ axis: [Double]) {
        if axis.count == 3 {
            self.axis = axis
        } else {
            return nil
        }
    }

    var description: String {
        "Vector3 (\(self.x), \(self.y), \(self.z))"
    }

    // Simple Arithmetic
    public static func +(lhs: Vector3, rhs: Vector3) -> Vector3 {
        Vector3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
    }

    public static func -(lhs: Vector3, rhs: Vector3) -> Vector3 {
        Vector3(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
    }

    // Complex Arithmetic
    public static func *(lhs: Vector3, rhs: Vector3) -> Vector3 {
        // Create the arrays representing the axises of both
        var newValue = [0.0, 0.0, 0.0]
        let lhsAxis = [lhs.x, lhs.y, lhs.z]
        let rhsAxis = [rhs.x, rhs.y, rhs.z]

        for i in newValue.indices {

            // Get all axis beside at i
            let newLhs = lhsAxis.indices.filter{ $0 != i }.map{ lhsAxis[$0] }
            let newRhs = rhsAxis.indices.filter{ $0 != i }.map{ rhsAxis[$0] }

            // Find the determinant
            let deter = (newLhs[0] * newRhs[1]) - (newLhs[1] * newRhs[0])
            newValue[i] = deter
        }

        return Vector3(newValue[0], newValue[1], newValue[2])
    }

    public static func *(lhs: Double, rhs: Vector3) -> Vector3 {
        Vector3(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z)
    }

    func dot(_ rhs: Vector3) -> Double {
        [self.x * rhs.x, self.y * rhs.y, self.z * rhs.z].summed
    }

    public static func /(lhs: Vector3, rhs: Double) -> Vector3 {
        Vector3(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
    }

    // Others
    var magnitude: Double { sqrt([self.x, self.y, self.z].map{pow($0, 2)}.summed) }

    public static func ==(lhs: Vector3, rhs: Vector3) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }

    func isOrthogonal(to other: Vector3) -> Bool {
        self.dot(other) == 0
    }

}

// MARK: Vector2 Structure
struct Vector2: AdditiveArithmetic, Equatable, CustomStringConvertible {
    private var axis: [Double]

    // Computed properties
    var x: Double {
        axis[0]
    }

    var y: Double {
        axis[1]
    }

    // Static properties
    static var zero: Vector2 = Vector2(0, 0)
    static var one: Vector2 = Vector2(1, 1)
    static var up: Vector2 = Vector2(0, 1)
    static var down: Vector2 = Vector2(0, -1)
    static var right: Vector2 = Vector2(1, 0)
    static var left: Vector2 = Vector2(-1, 0)


    init(_ x: Double, _ y: Double) {
        axis = [x, y]
    }

    init?(_ axis: [Double]) {
        if axis.count == 2 {
            self.axis = axis
        } else {
            return nil
        }
    }

    var description: String {
        "Vector2 (\(self.x), \(self.y))"
    }

    // Simple Arithmetic
    public static func +(lhs: Vector2, rhs: Vector2) -> Vector2 {
        Vector2(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    public static func -(lhs: Vector2, rhs: Vector2) -> Vector2 {
        Vector2(lhs.x - rhs.x, lhs.y - rhs.y)
    }

    // Complex Arithmetic
    func dot(_ other: Vector2) -> Double {
        [self.x * other.x, self.y * other.y].summed
    }

    var magnitude: Double { sqrt([self.x, self.y].map{pow($0, 2)}.summed) }

    public static func ==(lhs: Vector2, rhs: Vector2) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }

    func isOrthogonal(to other: Vector2) -> Bool {
        self.dot(other) == 0
    }
}

// VectorAny Structure
struct VectorAny: Equatable, CustomStringConvertible {
    private var axis: [Double]

    // Computed properties
    var dimensions: Int {
        axis.count
    }

    // Static properties
    static func zero(of n: Int) -> VectorAny {
        // Create a VectorAny with size of n filled with 0s
        var axis = [Double]()
        for _ in 0..<n {
            axis.append(0)
        }
        return VectorAny(axis)
    }
    static func one(of n: Int) -> VectorAny {
        // Create a VectorAny with size of n filled with 1s
        var axis = [Double]()
        for _ in 0..<n {
            axis.append(1)
        }
        return VectorAny(axis)
    }

    init(_ axis: [Double]) {
        self.axis = axis
    }

    var description: String {
        " VectorAny (\(self.axis.map{String($0)}.joined(separator: ",")))"
    }

    // Simple Arithmetic
    public static func +(lhs: VectorAny, rhs: VectorAny) -> VectorAny? {
        // Check for the same dimension size
        guard lhs.dimensions == rhs.dimensions else {
            return nil
        }
        return VectorAny(lhs.axis.indices.map{ lhs.axis[$0] + rhs.axis[$0] })
    }

    public static func -(lhs: VectorAny, rhs: VectorAny) -> VectorAny? {
        // Check for the same dimension size
        guard lhs.dimensions == rhs.dimensions else {
            return nil
        }
        return VectorAny(lhs.axis.indices.map{ lhs.axis[$0] - rhs.axis[$0] })
    }

    // Complex Arithmetic
    func dot(_ other: VectorAny) -> Double? {
        // Check for the same dimension size
        guard self.dimensions == other.dimensions else {
            return nil
        }
        return self.axis.indices.map{ self.axis[$0] * other.axis[$0] }.summed
    }

    // Others
    var magnitude: Double { sqrt(self.axis.map{pow($0, 2)}.summed) }

    public static func ==(lhs: VectorAny, rhs: VectorAny) -> Bool {
        // Check for the same dimension size
        guard lhs.dimensions == rhs.dimensions else {
            return false
        }

        // Check for each element is it is the same
        for i in lhs.axis.indices  {
            if lhs.axis[i] != rhs.axis[i] {
                return false
            }
        }
        return true
    }

    func isOrthogonal(to other: VectorAny) -> Bool {
        // Check for the same dimension size
        guard let dot = self.dot(other) else {
            return false
        }
        return dot == 0
    }
}

func parallelogram(with lhs: Vector2, and rhs: Vector2) -> Double {
    sqrt(pow(lhs.magnitude, 2) * pow(rhs.magnitude, 2) - pow(lhs.dot(rhs), 2))
}

func parallelogram(with lhs: Vector3, and rhs: Vector3) -> Double {
    guard let cross = lhs * rhs else {
        return 0.0
    }
    return cross.magnitude
}

func triangle(with lhs: Vector2, and rhs: Vector2) -> Double {
    parallelogram(with: lhs, and: rhs) / 2
}

func triangle(with lhs: Vector3, and rhs: Vector3) -> Double {
    parallelogram(with: lhs, and: rhs) / 2
}

