//
//  main.swift
//  L2_DenisKuzmin
//
//  Created by Denis Kuzmin on 12.02.2021.
//

import Foundation

print("Hello, World!")

func fibonacci(num: Int) -> Int {
    let sign: Int = num >= 0 ? 1 : -1
    if (num == 0) {
        return 0
    } else if (abs(num) == 1) || (abs(num) == 2) {
        return sign
    }
    return fibonacci(num: num - sign) + fibonacci(num: num - sign * 2)
}

print(fibonacci(num: 50))
