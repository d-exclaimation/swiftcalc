# swiftcalc
 
Math Module for Matrices, Vectors, Probabilities

Authored by Vincent

## Quick Start Guide:

If you are using an Xcode importing is as easy as dropping files in the folder

If you are not, I still recommend using Xcode project. 

## Importing with Swift Package Manager

Using it with Swift Package is now a simple drap and drop in your current package folder. (Hopefully lol)

All the structs, functions, extensions, variables are now adjusted for the Swift Package Manager.

You can also make a new package source directory. 

# Setup

> 1. Download all the files
> 2. Drop in the project folder
> 3. Re-compile is necessary
> 4. Start using it without namespaces

e.g:
```swift

import Foundation

print(Vector3.up)
// Should print -> Vector3 (0, 1, 0)
```

# Descriptions:

### Structures / Objects

```swift
struct Fraction {...}
```
> The representation of a Fraction with all its properties and methods (e.g Fraction(242, 363) // Output: 2 / 3 )

```swift
struct Vector2 {...}
```
> The representation of a Vector 2 with axis of x and y, with all its properties and methods (e.g Vector2.up, Vector2(4, 2))

```swift
struct Vector3 {...}
```
> The representation of a Vector 3 with axis of x, y and z, with all its properties and methods (e.g Vector3.forward, Vector3(4, 2, 10))

```swift
struct VectorAny {...}
```
> The representation of a Vector 3 with n amount of axis with all its properties and methods

```swift
struct Matrix {...}
```
> The representation of a Matrix of size n (height) x m (width) with all its properties and methods (e.g Matrix.identity(of: 2))

```swift
struct AugmentedMatrix {...}
```
> The representation of a AugmentedMatrix of size n (height) x m (width) with extra 1 x m sized Matrix with all its properties and methods

### Functions

```swift
func parallelogram(lhs: Vector2 / Vector3, rhs: Vector2 / Vector3) -> Double
```
> Calculate the area of a parallelogram using two vectors

```swift
func triangle(lhs: Vector2 / Vector3, rhs: Vector2 / Vector3) -> Double
```
> Calculate the are of a triangle using two vectors

### Extensions

[Double] / Array<Double>

```swift
func dot(with other: [Double]) -> Double?
```
> Calculate the dot product of two Double array, return nil if the arrays don't have the same size

```swift
* Double
* [Double]
- [Double]
```
> Added multiplication with a Double and Array, as well as reducing with another array

```swift
var summed: Double
```
> Sum all it's content

Int

```swift
func commonFactor(with other: Int) -> Int
```
> Get the common factor of two Integers

```swift
func permute(with num: Int) -> Double 
```
> Get the permutation of self with num, which num is the number of object selected

```swift
func combine(with num: Int) -> Double 
```
> Get the combination of self with num, which num is the number of object selected

