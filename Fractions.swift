//
// Fraction Objects
// Created by Vincent on 12/2/20
//

import Foundation

// MARK: Fraction Structure
public struct Fraction: Equatable, CustomStringConvertible, AdditiveArithmetic {

    // Properties
    private(set) var num: Int
    private(set) var denom: Int

    // Others
    public static var zero: Fraction = Fraction(of: 0, by: 1)
    public  var description: String  {
        "\(num) / \(denom)"
    }

    public var rounded: Int {
        Int(round(Double(num) / Double(denom)))
    }

    init(of numerator: Int, by denominator: Int) {
        let commonfac = numerator.commonFactor(with: denominator)
        num = numerator / commonfac
        denom = denominator / commonfac
    }

    init(with decimal: Double) {
        // Conversion to fraction uses
        // 100n - 10n / 90, should remove excess repeated decimals
        let numerator = Int(round(100 * decimal - 10 * decimal))
        let denominator = 90

        // Create self using the newly built numerator and denominator
        self = Fraction(of: numerator, by: denominator)
    }

    // MARK: Addition Operation
    public static func +(lhs: Fraction, rhs: Fraction) -> Fraction {
        // Get common factor of denominators
        let comfac = lhs.denom.commonFactor(with: rhs.denom)
        let newDenom = comfac * (lhs.denom / comfac) * (rhs.denom / comfac)

        // Create a new fraction object
        let newNum = lhs.num * (rhs.denom / comfac) + rhs.num * (lhs.denom / comfac)
        return Fraction(of: newNum, by: newDenom)
    }

    public static func +(lhs: Fraction, rhs: Int) -> Fraction {
        // Add int * denom to the numerator
        Fraction(of: lhs.num + (rhs * lhs.denom), by: lhs.denom)
    }

    public static func +(lhs: Fraction, rhs: Double) -> Fraction {
        lhs + Fraction(with: rhs)
    }
    
    // MARK: Subtraction Operation
    public static func -(lhs: Fraction, rhs: Fraction) -> Fraction {
        // Get common factor of denominators
        let comfac = lhs.denom.commonFactor(with: rhs.denom)
        let newDenom = comfac * (lhs.denom / comfac) * (rhs.denom / comfac)

        // Create a new fraction object
        let newNum = lhs.num * (rhs.denom / comfac) - rhs.num * (lhs.denom / comfac)
        return Fraction(of: newNum, by: newDenom)
    }

    public static func -(lhs: Fraction, rhs: Int) -> Fraction {
        // Subtract int * denom to the numerator
        Fraction(of: lhs.num - (rhs * lhs.denom), by: lhs.denom)
    }

    public static func -(lhs: Fraction, rhs: Double) -> Fraction {
        lhs - Fraction(with: rhs)
    }
    
    // MARK: Multiplication Operation
    public static func *(lhs: Fraction, rhs: Fraction) -> Fraction {
        Fraction(of: lhs.num * rhs.num, by: lhs.denom * rhs.denom)
    }

    public static func *(lhs: Fraction, rhs: Int) -> Fraction {
        Fraction(of: lhs.num * rhs, by: lhs.denom)
    }

    public static func *(lhs: Fraction, rhs: Double) -> Fraction {
        lhs * Fraction(with: rhs)
    }

    // MARK: Division Operation
    public static func /(lhs: Fraction, rhs: Fraction) -> Fraction {
        Fraction(of: lhs.num * rhs.denom, by: lhs.denom * rhs.num)
    }

    public static func /(lhs: Fraction, rhs: Int) -> Fraction {
        Fraction(of: lhs.num, by: lhs.denom * rhs)
    }

    public static func /(lhs: Fraction, rhs: Double) -> Fraction {
        lhs * Fraction(with: rhs)
    }

    // MARK: Module Operation
    public static func %(lhs: Fraction, rhs: Fraction) -> Int {
        let newValue = lhs / rhs
        return newValue.num % newValue.denom
    }

    public static func %(lhs: Fraction, rhs: Double) -> Int {
        let newValue = lhs / rhs
        return newValue.num % newValue.denom
    }

    public static func %(lhs: Fraction, rhs: Int) -> Int {
        let newValue = lhs / rhs
        return newValue.num % newValue.denom
    }

    public static func ^(lhs: Fraction, rhs: Int) -> Fraction {
        Fraction(of: Int(pow(Double(lhs.num), Double(rhs))), by: Int(pow(Double(lhs.denom), Double(rhs))))
    }

}
