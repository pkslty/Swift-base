//
//  main.swift
//  L2_DenisKuzmin
//
//  Created by Denis Kuzmin on 12.02.2021.
//

/*Написать функцию, которая определяет, четное число или нет.
Написать функцию, которая определяет, делится ли число без остатка на 3.
Создать возрастающий массив из 100 чисел.
Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
* Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
* Заполнить массив элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n (пусть будет 100), следуя методу Эратосфена, нужно выполнить следующие шаги:*/

import Foundation

//Рекурсивная функция, вычисляющая одно n-ное значение последовательности Фибоначчи
//Красиво, но безумно много раз вызывает сама себя, не годится
func fibonacci(num: Int) -> Int {
    let sign: Int = num >= 0 ? 1 : -1
    if (num == 0) {
        return 0
    } else if (abs(num) == 1) || (abs(num) == 2) {
        return sign
    }
    return fibonacci(num: num - sign) + fibonacci(num: num - sign * 2)
}
//Проверка
print("30-е число последовательности: ", fibonacci(num: 30))

//Функция возвращает массив с последовательностью Фибоначчи:
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
//Проверка
print("Массив из 50 чисел последовательности Фибоначчи:")
print(fibonacciArray(num: -49))

//Если строго следовать тексту домашнего задания, которое, наверное на передачу параметров по ссылке:
//Функция, добавляющая в массив число фибоначчи:
func addFibonacciToArray(arr: inout [Int]) {
    //Предполагаем, что массив содержит последовательность Фибоначчи и не проверяем это
    if arr.isEmpty {
        arr.append(0)
    } else if arr.count == 1 {
        arr.append(1)
    } else {
        arr.append(arr[arr.count - 1] + arr[arr.count - 2])
    }
}
//Проверка
var fibarr = [Int]()
for _ in (0...49) {
    addFibonacciToArray(arr: &fibarr)
}
print(fibarr)



//Функция для определения чётное ли число
func isOdd(_ num: Int) -> Bool {
    if (num % 2 == 0) {
        return true
    }
    return false
}

//Функция для определения делится ли число на другое число (например 3) без остатка
func isDiv(_ num: Int, _ by: Int) -> Bool {
    if (num % by == 0) {
        return true
    }
    return false
}

//Возрастающий массив из 100 чисел:
var arr = [Int]()
for i in (0...99) {
    arr.append(i)
}
print("Возрастающий массив из 100 чисел:")
print(arr)
var i: Int = 0
//Удаляем четные числа и те, которые не делятся на 3
repeat {
    if isDiv(arr[i], 2) || !isDiv(arr[i], 3) {
        arr.remove(at: i)
    } else {
        i += 1
    }
} while i != arr.count

print("Удаляем четные числа и те, которые не делятся на 3:")
print(arr)

//Метод Эратосфена
let n: Int = 100000
var nPrimeNumbers = [Int?]()
for i in (0...n) {
    nPrimeNumbers.append(i)
}
var p: Int = 2
repeat {
    for i in stride(from: 2*p, through: n, by: p) {
        nPrimeNumbers[i] = nil
    }
    for i in (p+1...n) {
        p = n
        if nPrimeNumbers[i] != nil {
            p = i
            break
        }
    }
} while p != n

var primeNumbers = [Int]()
nPrimeNumbers.remove(at: 0)

for i in nPrimeNumbers {
    if let ii = i {
        primeNumbers.append(ii)
    }
}
print("Простые числа не больше \(n):")
print(primeNumbers)
