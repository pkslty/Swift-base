//
//  Snake.swift
//  SnakeGame
//
//  Created by Denis Kuzmin on 18.03.2021.
//

import Foundation
import SpriteKit
import UIKit

class Snake: SKShapeNode {
    
    var head: SnakeHead
    var body = [SnakePart]()
    var color: UIColor {
        set {
            head.fillColor = newValue
            head.strokeColor = newValue
            for part in body {
                part.fillColor = newValue
                part.strokeColor = newValue
            }
        }
        get {
            return head.fillColor
        }
    }
    var moveStep = 100.0
    var pace = 1.0
    var moveAngle = 0.0
    
    init(at point: CGPoint) {
        
        self.head = SnakeHead(at: point)
        super.init()
        self.color = .green
        addChild(head)
    }
    
    func move() {
        let hposition = head.position
        moveHead()
        guard !body.isEmpty else {return}
        movePart(part: body[0], to: hposition)
        for i in 0 ..< body.count where i > 0 {
            movePart(part: body[i], to: body[i-1].position)
        }
    }
    
    func addPart(at point: CGPoint) {
        let part = SnakePart(at: point)
        part.strokeColor = color
        part.fillColor = color
        body.insert(part, at: 0)
        if body.count > 1 {
            body[1].physicsBody?.categoryBitMask = CollisionCategories.snakeBody
            body[1].physicsBody?.contactTestBitMask = CollisionCategories.snakeHead
        }
        addChild(body[0])
    }
    
    func changeDirection(direction: Direction) {
        
        switch direction {
        case .down:
            if sin(moveAngle) != 1 {
                moveAngle = Double.pi*3/2
            }
        case .up:
            if sin(moveAngle) != -1 {
                moveAngle = Double.pi/2
            }
        case .left:
            if cos(moveAngle) != 1 {
                moveAngle = Double.pi
            }
        case .right:
            if cos(moveAngle) != -1 {
                moveAngle = 0
            }
        case .rotateClockwise:
            moveAngle -= Double.pi/2

        case .rotateCounterClockwise:
            moveAngle += Double.pi/2
            
        default:
            break
        }
    }
    
    func moveHead() {
        
        let dx = CGFloat(moveStep * cos(moveAngle))
        let dy = CGFloat(moveStep * sin(moveAngle))
        let newPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        let action = SKAction.move(to: newPosition, duration: pace)
        head.run(action)
    }
    
    func movePart(part: SKShapeNode, to newpoint: CGPoint) {
        let action = SKAction.move(to: newpoint, duration: pace/6)
        part.run(action)
    }
    
    func eat(_ food: Food) {
        let point = head.position
        color = food.kind.rawValue
        
        switch food.kind {
        case .longer:
            addPart(at: point)
        case .faster10percent:
            food.runAction(at: point)
            pace *= 0.9
            addPart(at: point)
        case .faster5percent:
            food.runAction(at: point)
            pace *= 0.95
            addPart(at: point)
        case .slower10percent:
            food.runAction(at: point)
            pace /= 0.9
            addPart(at: point)
        case .shorter:
            if body.count > 4 {
                food.runAction(at: point)
                body.removeLast().removeFromParent()
            }
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SnakeHead: SnakePart {
    
    override init(at point: CGPoint) {
        super.init(at: point)
        physicsBody = SKPhysicsBody(circleOfRadius: 8)
        physicsBody?.categoryBitMask = CollisionCategories.snakeHead
        physicsBody?.contactTestBitMask = CollisionCategories.food | CollisionCategories.frame | CollisionCategories.snakeBody
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SnakePart: SKShapeNode {
    
    init(at point: CGPoint) {
        
        super.init()
        position = point
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        lineWidth = 5
        physicsBody = SKPhysicsBody(circleOfRadius: 1)
        physicsBody?.categoryBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
