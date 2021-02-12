//
//  main.swift
//  L2_DenisKuzmin
//
//  Created by Denis Kuzmin on 12.02.2021.
//

import Foundation

func fibonacci(num: Int) -> Int {
    let sign: Int = num >= 0 ? 1 : -1
    if (num == 0) {
        return 0
    } else if (abs(num) == 1) || (abs(num) == 2) {
        return sign
    }
    return fibonacci(num: num - sign) + fibonacci(num: num - sign * 2)
}

func fibonacciArray(num: Int) -> [Int] {
    var arr = [Int]()
    let sign: Int = num >= 0 ? 1 : -1
    arr.append(0)
    if (num == 0) {
        return arr
    }
    arr.append(sign)
    if (abs(num) == 1)  {
        return arr
    }
    for i in (2...abs(num)) {
        arr.append(arr[i-1] + arr[i-2])
    }
    
    return arr
}

print(fibonacci(num: 30))
print(fibonacciArray(num: -50))

func isOdd(_ num: Int) -> Bool {
    if (num % 2 == 0) {
        return true
    }
    return false
}
print(isOdd(0), isOdd(1), isOdd(2), isOdd(47), isOdd(-1), isOdd(-9), isOdd(5))

