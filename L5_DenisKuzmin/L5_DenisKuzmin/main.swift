//
//  main.swift
//  L5_DenisKuzmin
//
//  Created by Denis Kuzmin on 03.03.2021.
//

import Foundation

enum EngineType: String {
    case disel = "Дизельный"
    case gaz = "Бензиновый"
    case electic = "Электрический"
}
enum windowState: String {
    case open = "Открыты"
    case close = "Закрыты"
}

enum engineState: String {
    case start = "Запущен"
    case stop = "Остановлен"
}

enum TireType: String {
    case slik = "Слик"
    case regular = "Обычная"
    case rain = "Дождевая"
    case winter = "Зимняя"
}

enum carActions {
    case startEngine
    case stopEngine
    case openWindows
    case closeWindows
    case loadCargo(cargo: Double)
    case unloadCargo(cargo: Double)
    case changeTires(type: TireType)
    case takePassangers(num: Int)
}
protocol Car {
    
    var name: String {get set}
    var engineType: EngineType {get}
    var manufacturer: String {get}
    var issueYear: Int {get}
    var color: String {get set}
    var engineVolume: Double? {get set}
    var power: Double? {get set}
    var engineState: engineState {get set}
    var windowsState: windowState {get set}
    
}

/*extension Car {
    mutating func carActions(actions: Array<carActions>) {
        for action in actions {
            switch action {
                case .startEngine:
                    self.engineState = .start
                case .stopEngine:
                    self.engineState = .stop
                case .openWindows:
                    windowsState = windowState.open
                case .closeWindows:
                    windowsState = windowState.close
                default:
                    break
            }
        }
    }
}*/

//По одному на действие сказано:

extension Car {
    mutating func startEngine() {
        engineState = .start
    }
}

extension Car {
    mutating func stopEngine() {
        engineState = .stop
    }
}

extension Car {
    mutating func openWindows() {
        windowsState = .open
    }
}

extension Car {
    mutating func closeWindows() {
        windowsState = .close
    }
}

class SportCar: Car {
    var name: String
    let engineType: EngineType
    let manufacturer: String
    let issueYear: Int
    var color: String
    var engineVolume: Double?
    var power: Double?
    var engineState: engineState
    var windowsState: windowState
    var tires = TireType.regular
    var maxSpeed: Int
    var secondsTo100KmPerHour: Int
    
    init(name: String, manufacturer: String, issueYear: Int, color: String, engineType: EngineType, maxSpeed: Int, secondsTo100KmPerHour: Int) {
        self.name = name
        self.manufacturer = manufacturer
        self.issueYear = issueYear
        self.color = color
        self.engineType = engineType
        self.engineState = .stop
        self.windowsState = .close
        self.maxSpeed = maxSpeed
        self.secondsTo100KmPerHour = secondsTo100KmPerHour
        
    }
}

class TunkCar: Car {
    var name: String
    let engineType: EngineType
    let manufacturer: String
    let issueYear: Int
    var color: String
    var engineVolume: Double?
    var power: Double?
    var engineState: engineState
    var windowsState: windowState
    var tunkVolume: Double //in litres
    var filledVolume = 0.0
    
    init(name: String, manufacturer: String, issueYear: Int, color: String, engineType: EngineType, tankVolume: Double) {
        self.name = name
        self.manufacturer = manufacturer
        self.issueYear = issueYear
        self.color = color
        self.engineType = engineType
        self.engineState = .stop
        self.windowsState = .close
        self.tunkVolume = tankVolume
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        var d = "Автомобиль: \(name)\nПроизведен компанией \(manufacturer) в \(issueYear) году\nТип двигателя: \(engineType.rawValue)\nМаксимальная скорость: \(maxSpeed)\nРазгон до 100 км/час за \(secondsTo100KmPerHour) секунд\n"
                
                if let p = power {
                    d += "Мощность двигателя: \(p)\n"
                }
                if let v = engineVolume {
                    d += "Объем двигателя: \(v)\n"
                }
                d += "Статус автомобиля:\nДвигатель: \(self.engineState.rawValue)\nОкна: \(self.windowsState.rawValue)\nУстановлена резина: \(self.tires.rawValue)\n"
        return d
    }
}

extension TunkCar: CustomStringConvertible {
    var description: String {
        var d = "Автомобиль: \(name)\nПроизведен компанией \(manufacturer) в \(issueYear) году\nТип двигателя: \(engineType.rawValue)\nОбъем цистерны: \(tunkVolume)\n"
                
                if let p = power {
                    d += "Мощность двигателя: \(p)\n"
                }
                if let v = engineVolume {
                    d += "Объем двигателя: \(v)\n"
                }
                d += "Статус автомобиля:\nДвигатель: \(self.engineState.rawValue)\nОкна: \(self.windowsState.rawValue)\nЦистерна заполнена на \(filledVolume/tunkVolume*100)%\n"
        return d
    }
}

var aCar = SportCar(name: "Sport", manufacturer: "Мазерати", issueYear: 2020, color: "Желтый", engineType: .gaz, maxSpeed: 220, secondsTo100KmPerHour: 4)
aCar.openWindows()

var tCar = TunkCar(name: "Tunk", manufacturer: "Камаз", issueYear: 2001, color: "Зеленый", engineType: .disel, tankVolume: 40000.0)
tCar.startEngine()
print(aCar)
print(tCar)

extension TunkCar: Comparable {
    static func < (lhs: TunkCar, rhs: TunkCar) -> Bool {
        return lhs.tunkVolume < rhs.tunkVolume
    }
    
    static func > (lhs: TunkCar, rhs: TunkCar) -> Bool {
        return lhs.tunkVolume > rhs.tunkVolume
    }
    
    static func <= (lhs: TunkCar, rhs: TunkCar) -> Bool {
        return lhs.tunkVolume <= rhs.tunkVolume
    }
    
    static func >= (lhs: TunkCar, rhs: TunkCar) -> Bool {
        return lhs.tunkVolume >= rhs.tunkVolume
    }
    
    static func == (lhs: TunkCar, rhs: TunkCar) -> Bool {
        return lhs.tunkVolume == rhs.tunkVolume
    }
}

let tCar2 = TunkCar(name: "Tunk2", manufacturer: "Маз", issueYear: 2002, color: "Красный", engineType: .disel, tankVolume: 35000)

if tCar > tCar2 {
    print("Первая цистерна больше второй")
} else if tCar < tCar2 {
    print("Первая цистерна меньше второй")
} else {
    print("Цистерны равны")
}

extension SportCar {
    func changeTires(tires: TireType) {
        self.tires = tires
    }
}
extension TunkCar {
    func fillTunk(volume: Double) {
        if filledVolume+volume <= tunkVolume {
            filledVolume += volume
        } else {
            filledVolume = tunkVolume
        }
    }
    func emptyTunk(volume: Double){
        if filledVolume-volume > 0.0 {
            filledVolume -= volume
        } else {
            filledVolume = 0.0
        }
    }
}

tCar.fillTunk(volume: 4000)
print(tCar)
