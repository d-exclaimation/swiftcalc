# swiftcalc
 
Math Module for Matrices, Vectors, Probabilities

Authored by Vincent

## Quick Start Guide:

If you are using an Xcode importing is as easy as dropping files in the folder

If you are not, I still recommend using Xcode project. Importing without Xcode will be added once I have time

# Setup

> 1. Download all the files
> 2. Drop in the project folder
> 3. Start using it without namespaces

e.g:
```swift

import Foundation

print(Vector3.up)
// Should print -> Vector3 (0, 1, 0)
```

# Descriptions:

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
