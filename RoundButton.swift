//
//  RoundButton.swift
//  SnakeGame
//
//  Created by Denis Kuzmin on 17.03.2021.
//

import Foundation
import SpriteKit

enum Direction {
    case left
    case right
    case up
    case down
    case rotateClockwise
    case rotateCounterClockwise
    case noSymbol
}

class RoundButton: SKShapeNode {
    
    
    var diameter: CGFloat
    var touchedColor = SKColor.gray
    var unTouchedColor = SKColor.green
    //var symbolColor = SKColor.red
    var symbol: Direction
    var nodes = [SKShapeNode]()
    /*var touching: Bool {
        get {}
        set {}
    }*/
    
    init(x: CGFloat, y: CGFloat, diameter: CGFloat, name: String, symbol: Direction = .noSymbol) {
        
        self.diameter = diameter
        self.symbol = symbol
        super.init()
        self.name = name
        strokeColor = .black
        lineWidth = 5
        zPosition = 1
        
        let mainNode = SKShapeNode()
        mainNode.name = name
        mainNode.fillColor = unTouchedColor
        mainNode.lineWidth = lineWidth
        mainNode.strokeColor = strokeColor
        mainNode.position = CGPoint(x: x, y: y)
        mainNode.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: diameter, height: diameter)).cgPath
        nodes.append(mainNode)

        let line = SKShapeNode()
        line.name = name
        line.fillColor = unTouchedColor
        line.lineWidth = lineWidth
        line.strokeColor = strokeColor
        line.position = CGPoint(x: x, y: y)
        let path = UIBezierPath()
        
        if symbol == .rotateCounterClockwise {
            path.append(UIBezierPath(arcCenter: CGPoint(x: diameter/2, y: diameter/2), radius: diameter/5, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi*3/2), clockwise: true))
            path.move(to: CGPoint(x:diameter/2, y: diameter*3/10))
            path.addLine(to: CGPoint(x:diameter/2-1, y:diameter*3/10+10))
            path.move(to: CGPoint(x:diameter/2, y: diameter*3/10))
            path.addLine(to: CGPoint(x:diameter/2-10, y:diameter*3/10-5))
        } else if symbol == .rotateClockwise {
            path.append(UIBezierPath(arcCenter: CGPoint(x: diameter/2, y: diameter/2), radius: diameter/5, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: true))
            path.move(to: CGPoint(x:diameter/2, y: diameter*3/10))
            path.addLine(to: CGPoint(x:diameter/2+1, y:diameter*3/10+10))
            path.move(to: CGPoint(x:diameter/2, y: diameter*3/10))
            path.addLine(to: CGPoint(x:diameter/2+10, y:diameter*3/10-5))
        } else if symbol == .up {
            path.move(to: CGPoint(x: diameter/2, y: diameter/4))
            path.addLine(to: CGPoint(x: diameter/2, y: diameter/4*3))
            path.addLine(to: CGPoint(x: diameter/2-10, y: diameter/4*3-10))
            path.move(to: CGPoint(x: diameter/2, y: diameter/4*3))
            path.addLine(to: CGPoint(x: diameter/2+10, y: diameter/4*3-10))
        } else if symbol == .down {
            path.move(to: CGPoint(x: diameter/2, y: diameter/4*3))
            path.addLine(to: CGPoint(x: diameter/2, y: diameter/4))
            path.addLine(to: CGPoint(x: diameter/2-10, y: diameter/4+10))
            path.move(to: CGPoint(x: diameter/2, y: diameter/4))
            path.addLine(to: CGPoint(x: diameter/2+10, y: diameter/4+10))
        } else if symbol == .left {
            path.move(to: CGPoint(x: diameter/4*3, y: diameter/2))
            path.addLine(to: CGPoint(x: diameter/4, y: diameter/2))
            path.addLine(to: CGPoint(x: diameter/4+10, y: diameter/2+10))
            path.move(to: CGPoint(x: diameter/4, y: diameter/2))
            path.addLine(to: CGPoint(x: diameter/4+10, y: diameter/2-10))
        } else if symbol == .right {
            path.move(to: CGPoint(x: diameter/4, y: diameter/2))
            path.addLine(to: CGPoint(x: diameter/4*3, y: diameter/2))
            path.addLine(to: CGPoint(x: diameter/4*3-10, y: diameter/2+10))
            path.move(to: CGPoint(x: diameter/4*3, y: diameter/2))
            path.addLine(to: CGPoint(x: diameter/4*3-10, y: diameter/2-10))
        }
        line.path = path.cgPath
        nodes.append(line)
    
        for node in nodes {
            addChild(node)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func belonging(touch: UITouch, in node: SKNode) -> Bool {
        
        let touchLocation = touch.location(in: node)
        guard let touchesNode = node.atPoint(touchLocation) as? SKShapeNode, touchesNode.name == name
        else {
            return false
        }
        
        return true
    }
    
    func touching() {
        for node in nodes {
            node.fillColor = touchedColor
        }
        //print("Start!!!!!!!!!!!!!: \(touch.timestamp)")
    }
    
    func notTouching() {
        for node in nodes {
            node.fillColor = unTouchedColor
        }
    }
    
}
