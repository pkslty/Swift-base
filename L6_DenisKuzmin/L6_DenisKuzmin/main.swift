//
//  main.swift
//  L6_DenisKuzmin
//
//  Created by Denis Kuzmin on 04.03.2021.
//

import Foundation

struct Queue<T: Comparable> {
    
    private var queue = [T]()
    
    var count: Int {queue.count}
    
    //Подсмотреть в начало очереди, не вынимая значения:
    var peek: T? {queue.first}
    
    //Добавить в очередь
    mutating func add(_ element: T) {
        queue.append(element)
    }
    
    //Достать из очереди
    //Не проверяем на возможность вернуть, можно было б возвращать опциональное значение
    //но тогда при использовании придется его разворачивать каждый раз
    //свойство count в помощь
    mutating func poll() -> T {
        queue.removeFirst()
    }
    
    //Сабскрипты
    //Будем возвращать значения, но не вынимать их, это всё-таки очередь
    subscript(indicies: Int...) -> [T]? {
        
        var queuePart = [T]()
        
        for i in indicies where i < queue.count {
            queuePart.append(queue[i])
        }
        
        return queuePart.count > 0 ? queuePart : nil
    }
    //Можно бы проверять на повторяемость сабскриптов, но оставим это на совести пользователя
    
    subscript(range: ClosedRange<Int>...) -> [T]? {
        
        var queuePart = [T]()
        
        for j in range {
            for i in j where i < queue.count {
                queuePart.append(queue[i])
            }
        }
        return queuePart.count > 0 ? queuePart : nil
    }
    
    //Сортировка
    mutating func sort(by: (T, T) -> Bool) {
        for i in (0 ..< queue.count) {
            for j in i+1 ..< queue.count {
                if by(queue[i], queue[j]) {
                    let v = queue[i]
                    queue[i] = queue[j]
                    queue[j] = v
                }
            }
        }
    }
    
    //Фильтрация
    mutating func filter(only: (T) -> Bool) {
        var i = 0
        while i < queue.count {
            if !only(queue[i]) {
                queue.remove(at: i)
            } else {
                i += 1
            }
        }
    }
}

//Расширим очередь до двухсторонней:
extension Queue {
    mutating func pop() -> T {
        queue.removeLast()
    }
}

//Проверки
var q = Queue<Int>()
q.add(1)
q.add(10)
q.add(12)
q.add(5)

print(q)
q.sort(by: {$0 > $1})
print(q)
q.sort(by: <)
print(q)
print(q.poll())
q.add(34)
q.add(43)
q.add(1)
q.add(8)
q.add(83)
q.add(66)
q.add(333)
print(q.count)
print(q)
print("Subscripting:")
let qq = q[6,6,6,6,4,0,23,16]
//let qq = q[1...10, 0...6]
print(qq as Any)

q.filter(only: {$0 % 3 == 0})
print(q)
print(q.pop())
if let i = q.peek {
    print(i)
}
print(q)
print(q.pop())
if let i = q.peek {
    print(i)
}
