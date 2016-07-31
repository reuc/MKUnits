//
//  Quantity.swift
//  Pods
//
//  Created by Michal Konturek on 29/07/2016.
//
//

import Foundation

public struct Quantity {
    public let amount: NSDecimalNumber
    public let unit: Unit
    
    public init(amount: NSNumber, unit: Unit) {
        self.amount = NSDecimalNumber(decimal: amount.decimalValue)
        self.unit = unit
    }
    
    public func converted(to: Unit) -> Quantity {
        assert(self.unit.isConvertible(to))
        let amount = self.unit.convert(self.amount, to: to)
        return Quantity(amount: amount, unit: to)
    }
    
    public func negative() -> Quantity {
        return self * -1;
    }
}

// MARK: - Arithmetic Operators

func +(lhs: Quantity, rhs: Quantity) -> Quantity {
    assert(lhs.unit.isConvertible(rhs.unit))
    let converted = rhs.converted(lhs.unit).amount
    let amount = lhs.amount.decimalNumberByAdding(converted)
    return Quantity(amount: amount, unit: lhs.unit)
}

func -(lhs: Quantity, rhs: Quantity) -> Quantity {
    assert(lhs.unit.isConvertible(rhs.unit))
    let converted = rhs.converted(lhs.unit).amount
    let amount = lhs.amount.decimalNumberBySubtracting(converted)
    return Quantity(amount: amount, unit: lhs.unit)
}

func *(lhs: Quantity, rhs: Int) -> Quantity {
    let amount = lhs.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(integer: rhs))
    return Quantity(amount: amount, unit: lhs.unit)
}

func *(lhs: Quantity, rhs: Double) -> Quantity {
    let amount = lhs.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(double: rhs))
    return Quantity(amount: amount, unit: lhs.unit)
}

func *(lhs: Quantity, rhs: Float) -> Quantity {
    let amount = lhs.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(float: rhs))
    return Quantity(amount: amount, unit: lhs.unit)
}

func *(lhs: Quantity, rhs: NSNumber) -> Quantity {
    let amount = lhs.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(decimal: rhs.decimalValue))
    return Quantity(amount: amount, unit: lhs.unit)
}

func *(lhs: Int, rhs: Quantity) -> Quantity {
    let amount = rhs.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(integer: lhs))
    return Quantity(amount: amount, unit: rhs.unit)
}

func *(lhs: Double, rhs: Quantity) -> Quantity {
    let amount = rhs.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(double: lhs))
    return Quantity(amount: amount, unit: rhs.unit)
}

func *(lhs: Float, rhs: Quantity) -> Quantity {
    let amount = rhs.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(float: lhs))
    return Quantity(amount: amount, unit: rhs.unit)
}

func *(lhs: NSNumber, rhs: Quantity) -> Quantity {
    let amount = rhs.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(decimal: lhs.decimalValue))
    return Quantity(amount: amount, unit: rhs.unit)
}

// MARK: - CustomStringConvertible

extension Quantity: CustomStringConvertible {
    public var description: String {
        return "\(self.amount) \(self.unit)"
    }
}

// MARK: - Equatable

extension Quantity: Equatable {
    public func equals(other: Quantity) -> Bool {
        if self.unit != other.unit {
            return false
        }
        return self.amount == other.amount
    }
}
public func ==(lhs: Quantity, rhs: Quantity) -> Bool {
    return lhs.equals(rhs)
}

// MARK: - Comparable

extension Quantity: Comparable {}
public func <(lhs: Quantity, rhs: Quantity) -> Bool {
    assert(lhs.unit.isConvertible(rhs.unit))
    let converted = lhs.converted(rhs.unit)
    return converted.amount.compare(rhs.amount) == .OrderedAscending
}

public func <=(lhs: Quantity, rhs: Quantity) -> Bool {
    assert(lhs.unit.isConvertible(rhs.unit))
    let converted = lhs.converted(rhs.unit)
    return converted.amount.compare(rhs.amount) != .OrderedDescending
}

public func >(lhs: Quantity, rhs: Quantity) -> Bool {
    assert(lhs.unit.isConvertible(rhs.unit))
    let converted = lhs.converted(rhs.unit)
    return converted.amount.compare(rhs.amount) == .OrderedDescending
}

public func >=(lhs: Quantity, rhs: Quantity) -> Bool {
    assert(lhs.unit.isConvertible(rhs.unit))
    let converted = lhs.converted(rhs.unit)
    return converted.amount.compare(rhs.amount) != .OrderedAscending
}
