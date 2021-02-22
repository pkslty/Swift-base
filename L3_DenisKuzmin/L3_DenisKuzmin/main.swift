//
//  main.swift
//  L3_DenisKuzmin
//
//  Created by Denis Kuzmin on 15.02.2021.
//

import Foundation


//Сторона двери
enum side: String {
    case driver = "Водительская"
    case passenger = "Пассажирская"
    case front = "Передний"
    case rear = "Задний"
}

//Расположение двери
enum doorPosition: String {
    case front = "передняя"
    case rear = "задняя"
    case trunc = "багажник"
}

//Действия с автомобилем
enum carOperation {
    case startEngine
    case stopEngine
    case openDoor(side: side, position: doorPosition)
    case openWindow(side: side, position: doorPosition)
    case fill(passangers: Int)
}

//Дверь
struct carDoor {
    var side: side
    let position: doorPosition
    var opened: Bool = false
    var windowOpened: Bool = false
    
}

//Автомобиль
struct sportCar {
    let name: String
    let manufacturer: String
    let model: String
    let issueYear: Int
    let maxPassangers: Int //Включая водителя
    var passangers: Int = 0
    var color: String
    var isEngineOn: Bool = false
    var doors: Array<carDoor> = []
    
    var engineVolume: Double?
    var power: Double?
    let wasInSpace: Bool
    var engineOperates: Bool
    
    
    init(_ name: String, _ manufacturer: String, _ model: String, _ issueYear: Int, _ maxPassangers: Int, _ color: String, _ doorsNum: Int) {
        self.name = name
        self.manufacturer = manufacturer
        self.model = model
        if (manufacturer == "Tesla" && model == "Roadster") {
            self.wasInSpace = true
        }
        else {
            self.wasInSpace = false
        }
        self.issueYear = issueYear
        self.maxPassangers = maxPassangers
        self.color = color
        self.engineOperates = false
        switch doorsNum {
        case 1:
            self.doors.append(carDoor.init(side: .driver, position: .front))
        case 2:
            self.doors.append(carDoor.init(side: .driver, position: .front))
            self.doors.append(carDoor.init(side: .passenger, position: .front))
        case 3:
            self.doors.append(carDoor.init(side: .driver, position: .front))
            self.doors.append(carDoor.init(side: .passenger, position: .front))
            self.doors.append(carDoor.init(side: .front, position: .trunc))
        case 4:
            self.doors.append(carDoor.init(side: .driver, position: .front))
            self.doors.append(carDoor.init(side: .passenger, position: .front))
            self.doors.append(carDoor.init(side: .driver, position: .rear))
            self.doors.append(carDoor.init(side: .passenger, position: .rear))
        case 5:
            self.doors.append(carDoor.init(side: .driver, position: .front))
            self.doors.append(carDoor.init(side: .passenger, position: .front))
            self.doors.append(carDoor.init(side: .driver, position: .rear))
            self.doors.append(carDoor.init(side: .passenger, position: .rear))
            self.doors.append(carDoor.init(side: .front, position: .trunc))
        default: //No doors
            break
        }
    }
    
    func printSummary() {
        print("Спорткар по имени \(name)")
        print("Произведен компанией \(manufacturer) в \(issueYear) году")
        if wasInSpace {
            print("Такой же автомобиль отправлен в космос 6 февраля 2018 года!")
        }
        print("В машину помещается \(maxPassangers) человек, включая водителя")
        if let p = power {
            print("Мощность двигателя: \(p)")
        }
        if let v = engineVolume {
            print("Объем двигателя: \(v)")
        }
    }
    
    mutating func fillCharacteristics(engineVolume: Double? = nil, power: Double? = nil, color: String? = nil, truncSide: side? = nil) {
        if let v = engineVolume {
            self.engineVolume = v
        }
        if let p = power {
            self.power = p
        }
        if let c = color {
            self.color = c
        }
        if let tp = truncSide {
            for (i, door) in doors.enumerated() {
                if door.position == .trunc {
                    doors[i].side = tp
                }
            }
        }
    }
    
    func printCarStatus() {
        print("Состояние автомобиля:")
        let isDoor = {(p: doorPosition, s) in p != .trunc ? s : ""}
        for door in doors {
            print("\(door.side.rawValue) \(door.position.rawValue) \(isDoor(door.position, "дверь")) \(door.opened ? "открыт" : "закрыт")\(isDoor(door.position, "а")), окно \(door.windowOpened ? "открыто" : "закрыто")")
        }
        print("Двигатель \(engineOperates ? "заведён" : "выключен")")
        print("В машине \(passangers) человек включая водителя")
    }
    
    mutating func carOperate(operation: carOperation) {
        switch operation {
        case .openDoor(let s, let p):
            for (i, door) in doors.enumerated() {
                if door.side == s && door.position == p {
                    doors[i].opened = true
                }
            }
        case .openWindow(let s, let p):
            for (i, door) in doors.enumerated() {
                if door.side == s && door.position == p {
                    doors[i].windowOpened = true
                }
            }
        case .startEngine:
            engineOperates = true
        case .stopEngine:
            engineOperates = false
        case .fill(let p):
            if (passangers + p) <= maxPassangers {
                passangers += p
            } else {
                print("Удалось посадить только \(maxPassangers - passangers) человек, ещё \(p - maxPassangers) человек не поместились")
                passangers = maxPassangers
            }
        }
    }
}

var car1 = sportCar("Firstcar", "Tesla", "Roadster", 2020, 2, "Красный", 5)

car1.printSummary()
car1.printCarStatus()
car1.carOperate(operation: .openDoor(side: .driver, position: .rear))
car1.carOperate(operation: .fill(passangers: 4))
car1.printCarStatus()

var car2 = sportCar("Не совсем спорт", "ВАЗ", "2101", 1970, 5, "Мокрый асфальт", 5)
car2.fillCharacteristics(engineVolume: 1.2, color: "зелёный", truncSide: side.rear)
car2.printSummary()
car2.carOperate(operation: .openWindow(side: .passenger, position: .front))
car2.carOperate(operation: .startEngine)
car2.carOperate(operation: .fill(passangers: 4))
car2.printCarStatus()

