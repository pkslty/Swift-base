//
//  main.swift
//  L2_DenisKuzmin
//
//  Created by Denis Kuzmin on 12.02.2021.
//

import Foundation

print("Hello, World!")

func fibonacci(num: Int) -> Int {
    if (num == 0) {
        return 0
    } else if (num == 1) || (num == 2) {
        return 1
    }
    
    return fibonacci(num: num - 1) + fibonacci(num: num - 2)
}

print(fibonacci(num: 22))
