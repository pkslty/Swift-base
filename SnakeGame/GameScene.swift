//
//  GameScene.swift
//  SnakeGame
//
//  Created by Denis Kuzmin on 16.03.2021.
//

import UIKit
import SpriteKit
import GameplayKit

struct CollisionCategories {
    static let snakeHead: UInt32 = 0x1
    static let food: UInt32 = 0x1 << 1
    static let snakeBody: UInt32 = 0x1 << 2
    static let frame: UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    
    var buttons = [RoundButton]()
    var snake: Snake?
    var food: Food?
    var gameFrame: SKShapeNode?
    var game = false
    
    override func didMove(to view: SKView) {
        
        print(UIScreen.main.bounds)
        print(UIScreen.main.nativeBounds)
        
        
        backgroundColor = .gray
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        
        gameFrame = SKShapeNode()
        print(view.scene!.frame.maxX)
        print(view.scene!.frame.maxY)
        
        gameFrame?.path = UIBezierPath(rect: CGRect(x: 70, y: -5, width: view.scene!.frame.maxX-170, height: view.scene!.frame.maxY+10)).cgPath
        gameFrame?.strokeColor = UIColor.black
        gameFrame?.fillColor = .lightGray
        gameFrame?.lineWidth = 1
        gameFrame?.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 70, y: -5, width: view.scene!.frame.maxX-170, height: view.scene!.frame.maxY+10))
        gameFrame?.physicsBody?.categoryBitMask = CollisionCategories.frame
        gameFrame?.physicsBody?.contactTestBitMask = CollisionCategories.snakeHead
        addChild(gameFrame!)
        
        
        buttons.append(RoundButton(x: view.scene!.frame.maxX-90, y: view.scene!.frame.maxY/5*2-50, diameter: 50.0, name: "rightButton", symbol: .right))

        buttons.append(RoundButton(x: view.scene!.frame.minX+10, y: view.scene!.frame.maxY/5*2-50, diameter: 50.0, name: "leftButton", symbol: .left))

        buttons.append( RoundButton(x: view.scene!.frame.minX+10, y: view.scene!.frame.maxY/5-50, diameter: 50.0, name: "downButton", symbol: .down))
        
        buttons.append( RoundButton(x: view.scene!.frame.maxX-90, y: view.scene!.frame.maxY/5-50, diameter: 50.0, name: "downButton", symbol: .down))

        buttons.append(RoundButton(x: view.scene!.frame.minX+10, y: view.scene!.frame.maxY/5*3-50, diameter: 50.0, name: "upButton", symbol: .up))
        
        buttons.append(RoundButton(x: view.scene!.frame.maxX-90, y: view.scene!.frame.maxY/5*3-50, diameter: 50.0, name: "upButton", symbol: .up))

        buttons.append(RoundButton(x: view.scene!.frame.maxX-90, y: view.scene!.frame.maxY/5*4-50, diameter: 50.0, name: "rotclockButton", symbol: .rotateClockwise))

        buttons.append(RoundButton(x: view.scene!.frame.minX+10, y: view.scene!.frame.maxY/5*4-50, diameter: 50.0, name: "rotcountclockButton", symbol: .rotateCounterClockwise))
        
        for button in buttons {
            addChild(button)
        }
        
        gameMenu(gameOver: game)
        //newGame()
        
        self.physicsWorld.contactDelegate = self
        
    }
    
    func gameMenu(gameOver: Bool) {
        
        if gameOver {
            let gameOver = SKLabelNode(text: "GAME OVER!")
            gameOver.position = CGPoint(x: (view?.scene!.frame.maxX)!/2, y: (view?.scene!.frame.maxY)!/3*2)
            gameOver.fontColor = .red
            gameOver.fontSize = 80
            gameOver.name = "gameover"
            addChild(gameOver)
        }
        let newGame = SKLabelNode(text: "Start new game")
        newGame.position = CGPoint(x: (view?.scene!.frame.maxX)!/2, y: (view?.scene!.frame.maxY)!/3)
        newGame.fontColor = .green
        newGame.fontSize = 80
        newGame.name = "newgame"
        addChild(newGame)
    }
    
    func newGame() {
        
        var nodes = [SKNode]()
        for child in self.children {
            if child.name == "gameover" || child.name == "newgame" {
                nodes.append(child)
            }
        }
        self.removeChildren(in: nodes)
        game = true
        food = Food(in: CGRect(x: 70, y: -5, width: (view?.scene!.frame.maxX)!-170, height: (view?.scene!.frame.maxY)!+10))
        addChild(food!)
        
        snake = Snake(at: CGPoint(x: (view?.scene!.frame.maxX)!/2, y: (view?.scene!.frame.maxY)!/2))
        addChild(snake!)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if !game {
                newGame()
            } else {
                for button in buttons {
                    if button.belonging(touch: touch, in: self)  {
                        button.touching()
                        snake?.changeDirection(direction: button.symbol)
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            for button in buttons {
                if button.belonging(touch: touch, in: self)  {
                    button.notTouching()
                }
            }
        }
            
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        snake?.move()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
       
        let contactedBodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        //print(contactedBodies)
        let collisionBody = contactedBodies - CollisionCategories.snakeHead
        //print(collisionBody)
        
        switch collisionBody {
        case CollisionCategories.food:
            snake?.eat(food!)
            food?.removeFromParent()
            food = Food(in: CGRect(x: 75, y: 5, width: (view?.scene!.frame.maxX)!-175, height: (view?.scene!.frame.maxY)!-10))
            addChild(food!)
        case CollisionCategories.frame, CollisionCategories.snakeBody:
            snake?.removeFromParent()
            food?.removeFromParent()
            //self.removeAllChildren()
            game = false
            snake = nil
            gameMenu(gameOver: !game)
            
        default:
            break
        }
        
    }
    
}
