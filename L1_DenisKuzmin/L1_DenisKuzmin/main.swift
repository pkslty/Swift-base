//
//  main.swift
//  L1_DenisKuzmin
//
//  Created by Denis Kuzmin on 08.02.2021.
//

import Foundation

//Solve the quadratic equation
//a*x*x+b*x+c=d

class squareEquation {
    let a, b, c, d : Double
    var r1, r2 : Double? // Real roots
    var complexRoots : Bool? //Complex roots identifier
    var c1, c2 : Double? //Complex roots
    
    init  (a: Double, b: Double, c: Double, d: Double) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }
    
    func description() -> String {
        return "\(a)x\u{B2}\((b<0) ? "" : "+")\(b)x\((c<0) ? "" : "+")\(c)=\((d<=0) ? "" : "+")\(d)"
    }
    
    func solve() -> Bool {
        if (a == 0) {
            return false  //
        }
        let discriminant: Double = b * b - 4 * a * c
        if(discriminant < 0) {
            r1 = -b / (2 * a)
            r2 = r1
            c1 = sqrt(abs(discriminant)) / (2 * a)
            c2 = -c1!
            complexRoots = true
        }
        else {
            r1 = (-b + sqrt(discriminant)) / (2 * a)
            r2 = (-b - sqrt(discriminant)) / (2 * a)
            complexRoots = false
        }
        return true
    }
}

let equation = squareEquation(a: 9, b: 4, c: 5, d: 0)

print("Equation: \(equation.description())")
if (equation.solve()) {
    if (!equation.complexRoots!) {
        print("roots: x1 = \(equation.r1!), x2 = \(equation.r2!)")
    }
    else {
        print("roots: x1 = \(equation.r1!)+\(equation.c1!)i, x2 = \(equation.r2!)\(equation.c2!)i")    }
}

//Right Triangle
class rightTriangle {
    var a, b : Double //Sides
    var hypotenuse : Double //Hypotenuse
    
    //Init triangle by two sides
    init  (a: Double, b: Double) {
        self.a = a
        self.b = b
        self.hypotenuse = sqrt(a * a + b * b)
    }
    
    func perimeter() -> Double {
        return a + b + hypotenuse
    }
    
    func area() -> Double {
        return 0.5 * a * b
    }
}

let triangle = rightTriangle(a: 10, b: 20)
print("Triangle: SIde1 = \(triangle.a), Side2 = \(triangle.b), Hipotenuse = \(triangle.hypotenuse), perimeter = \(triangle.perimeter()), Area = \(triangle.area())")

//Deposit calculation
let depo : Double = 1234
var interest : Double = 0 //Without capitalization
var depoWithCapInterest : Double = depo //With capitalization
let rate : Double = 6.7
let period : Int = 5
interest = depo * rate / 100 * Double(period)
for _ in 1...period {
    depoWithCapInterest += depoWithCapInterest * rate / 100
}
print("Deposit \(depo) after \(period) years:\nWith capitalization of interest:", String(format: "%.2f", depoWithCapInterest)," \nWithout capitalization of interest ", String(format: "%.2f", depo + interest))
