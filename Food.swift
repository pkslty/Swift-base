//
//  Food.swift
//  SnakeGame
//
//  Created by Denis Kuzmin on 18.03.2021.
//

import Foundation
import SpriteKit

enum FoodKind: CaseIterable {
    case longer
    case faster10percent
    case slower10percent
    case shorter
    case faster5percent //icrease chances to increase speed
}

extension FoodKind: RawRepresentable {
    typealias RawValue = UIColor

    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.red: self = .longer
        case UIColor.green: self = .faster10percent
        case UIColor.blue: self = .slower10percent
        case UIColor.cyan: self = .shorter
        case UIColor.purple: self = .faster5percent
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .longer: return UIColor.red
        case .faster10percent: return UIColor.green
        case .slower10percent: return UIColor.blue
        case .shorter: return UIColor.cyan
        case .faster5percent: return UIColor.purple
        }
    }
}
class Food: SKShapeNode {
    
    let kind: FoodKind
    
    init(at point: CGPoint) {
        
        self.kind = FoodKind.allCases.randomElement()!
        super.init()
        position = point
        path = UIBezierPath(ovalIn: CGRect(x: 0,y: 0,width: 10,height: 10)).cgPath
        strokeColor = kind.rawValue
        fillColor = strokeColor
        lineWidth = 5
        physicsBody = SKPhysicsBody(circleOfRadius: 10)
        physicsBody?.categoryBitMask = CollisionCategories.food
        physicsBody?.contactTestBitMask = CollisionCategories.snakeHead
    }
    
    convenience init(in rect: CGRect) {
        
        let randX = rect.minX + CGFloat(arc4random_uniform(UInt32(rect.width)))
        let randY = rect.minY + CGFloat(arc4random_uniform(UInt32(rect.height)))
        self.init(at: CGPoint(x: randX, y: randY))
    }
    
    func runAction(at point: CGPoint, text: String) {
        let shockWaveAction: SKAction = {
            let growAndFadeAction = SKAction.group([SKAction.scale(to: 5, duration: 3),
                                                    SKAction.fadeOut(withDuration: 3)])
            
            let sequence = SKAction.sequence([growAndFadeAction,
                                              SKAction.removeFromParent()])
            
            return sequence
        }()

        let message = SKLabelNode(text: text)

        message.position = point
        parent?.addChild(message)
                
        message.run(shockWaveAction)
            
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


