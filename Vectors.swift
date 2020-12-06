//
// Vectors Objects
// Created by Vincent on 12/2/20.
//
import Foundation

// MARK: Vector3 Structure
public struct Vector3: Equatable, CustomStringConvertible, AdditiveArithmetic {
    private var axis: [Double]

    // Computed properties
    var x: Double { axis[0] }
    var y: Double { axis[1] }
    var z: Double { axis[2] }

    // Static properties
    public static var zero: Vector3 = Vector3(0, 0, 0)
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

    public var description: String {
        "Vector3 (\(x), \(y), \(z))"
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
        [x * rhs.x, y * rhs.y, z * rhs.z].summed
    }

    public static func /(lhs: Vector3, rhs: Double) -> Vector3 {
        Vector3(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
    }

    // Others
    var magnitude: Double { sqrt([x, y, z].map{pow($0, 2)}.summed) }

    public static func ==(lhs: Vector3, rhs: Vector3) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }

    func isOrthogonal(to other: Vector3) -> Bool {
        dot(other) == 0
    }

    func projection(to other: Vector3) -> Vector3 {
        let multiplier = dot(other) / pow(other.magnitude, 2)
        return multiplier * other
    }

}

// MARK: Vector2 Structure
public struct Vector2: AdditiveArithmetic, Equatable, CustomStringConvertible {
    private var axis: [Double]

    // Computed properties
    var x: Double {
        axis[0]
    }

    var y: Double {
        axis[1]
    }

    // Static properties
    public static var zero: Vector2 = Vector2(0, 0)
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

    public var description: String {
        "Vector2 (\(x), \(y))"
    }

    // Simple Arithmetic
    public static func +(lhs: Vector2, rhs: Vector2) -> Vector2 {
        Vector2(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    public static func -(lhs: Vector2, rhs: Vector2) -> Vector2 {
        Vector2(lhs.x - rhs.x, lhs.y - rhs.y)
    }

    // Complex Arithmetic
    public static func *(lhs: Double, rhs: Vector2) -> Vector2 {
        Vector2(lhs * rhs.x, lhs * rhs.y)
    }

    func dot(_ other: Vector2) -> Double {
        [x * other.x, y * other.y].summed
    }

    var magnitude: Double { sqrt([x, y].map{pow($0, 2)}.summed) }

    public static func ==(lhs: Vector2, rhs: Vector2) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }

    func isOrthogonal(to other: Vector2) -> Bool {
        dot(other) == 0
    }

    func projection(to other: Vector2) -> Vector2 {
        let multiplier = dot(other) / pow(other.magnitude, 2)
        return multiplier * other
    }

}

// VectorAny Structure
public struct VectorAny: Equatable, CustomStringConvertible {
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

    public var description: String {
        " VectorAny (\(axis.map{String($0)}.joined(separator: ",")))"
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
        guard dimensions == other.dimensions else {
            return nil
        }
        return self.axis.indices.map{ axis[$0] * other.axis[$0] }.summed
    }

    // Others
    var magnitude: Double { sqrt(axis.map{pow($0, 2)}.summed) }

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
        guard let dot = dot(other) else {
            return false
        }
        return dot == 0
    }
}

public func parallelogram(with lhs: Vector2, and rhs: Vector2) -> Double {
    sqrt(pow(lhs.magnitude, 2) * pow(rhs.magnitude, 2) - pow(lhs.dot(rhs), 2))
}

public func parallelogram(with lhs: Vector3, and rhs: Vector3) -> Double {
    (lhs * rhs).magnitude
}

public func triangle(with lhs: Vector2, and rhs: Vector2) -> Double {
    parallelogram(with: lhs, and: rhs) / 2
}

public func triangle(with lhs: Vector3, and rhs: Vector3) -> Double {
    parallelogram(with: lhs, and: rhs) / 2
}


