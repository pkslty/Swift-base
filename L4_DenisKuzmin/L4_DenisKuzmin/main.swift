//
//  main.swift
//  L4_DenisKuzmin
//
//  Created by Denis Kuzmin on 28.02.2021.
//

import Foundation

class Car {
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
    
    enum tireType: String {
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
        case changeTires(type: tireType)
        case takePassangers(num: Int)
    }
    
    var name: String
    let engineType: EngineType
    let manufacturer: String
    let issueYear: Int
    var color: String
    var engineVolume: Double?
    var power: Double?
    var engineState: engineState
    var windowsState: windowState
    
    init(name: String, manufacturer: String, issueYear: Int, color: String, engineType: EngineType) {
        self.name = name
        self.manufacturer = manufacturer
        self.issueYear = issueYear
        self.color = color
        self.engineType = engineType
        self.engineState = .stop
        self.windowsState = .close
    }
    
    func printSummary() {
        print("Автомобиль: \(name)")
        print("Произведен компанией \(manufacturer) в \(issueYear) году")
        print("Тип двигателя: \(engineType.rawValue)")
        
        if let p = power {
            print("Мощность двигателя: \(p)")
        }
        if let v = engineVolume {
            print("Объем двигателя: \(v)")
        }
        print("Статус автомобиля:")
        print("Двигатель: \(self.engineState.rawValue)")
        print("Окна: \(self.windowsState.rawValue)")
    }
    
    func carAction(actions: Array<carActions>) {
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
}

class Sportcar: Car {
    var maxSpeed: Int
    var secondsTo100KmPerHour: Int
    var tires = tireType.regular
    var maxPassangers: Int?
    var passangers: Int?
    
    init(name: String, manufacturer: String, issueYear: Int, color: String, engineType: EngineType, maxSpeed: Int, secondsTo100KmPerHour: Int) {
        self.maxSpeed = maxSpeed
        self.secondsTo100KmPerHour = secondsTo100KmPerHour
        super.init(name: name, manufacturer: manufacturer, issueYear: issueYear, color: color, engineType: engineType)
        
    }
    override func carAction(actions: Array<carActions>) {
        super.carAction(actions: actions)
        for action in actions {
            switch action {
            case .changeTires(let tire):
                tires = tire
            case .takePassangers(let p):
                if let mp = maxPassangers {
                    if p < mp {
                        passangers = p
                    }
                    else {
                        passangers = mp
                    }
                }
            default:
                break
            }
        }
    }
    
    override func printSummary() {
        super.printSummary()
        print("Установлена резина: \(self.tires.rawValue)")
        print("Максимальная скорость: \(maxSpeed) км/час")
        print("Разгон до 100 км/час за \(secondsTo100KmPerHour) сек.")
        if let mp = maxPassangers {
            print("Вместимость: \(mp) человек")
        }
        if let p = passangers {
            print("Пассажиров в машине: \(p)")
        }
        
    }
}

class TruncCar: Car {
    var maxCargo: Double
    var load = 0.0
    
    init(name: String, manufacturer: String, issueYear: Int, color: String, engineType: EngineType, maxCargo: Double) {
        self.maxCargo = maxCargo
        super.init(name: name, manufacturer: manufacturer, issueYear: issueYear, color: color, engineType: engineType)
        
    }
    override func carAction(actions: Array<carActions>) {
        super.carAction(actions: actions)
        for action in actions {
            switch action {
            case .loadCargo(let cargo):
                if load+cargo <= maxCargo {
                    load += cargo
                } else {
                    load = maxCargo
                }
                
            case .unloadCargo(let cargo):
                if load-cargo > 0 {
                    load -= cargo
                } else {
                    load = 0
                }
            default:
                break
            }
        }
    }
    
    override func printSummary() {
        super.printSummary()
        print("Грузоподъемность: \(maxCargo) кг")
        print("Загружено: \(load) кг")
    }
}



let aCar = Sportcar(name: "Sport", manufacturer: "Мазерати", issueYear: 2020, color: "Желтый", engineType: .gaz, maxSpeed: 220, secondsTo100KmPerHour: 4)

aCar.maxPassangers = 4
aCar.printSummary()
aCar.carAction(actions: [.startEngine, .changeTires(type: .rain), .takePassangers(num: 3)])
aCar.printSummary()

let anotherCar = TruncCar(name: "Грузовик", manufacturer: "Камаз", issueYear: 2010, color: "Оранжевый", engineType: .disel, maxCargo: 20000)

anotherCar.carAction(actions: [.startEngine, .openWindows, .loadCargo(cargo: 15435)])
anotherCar.printSummary()
