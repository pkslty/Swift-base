//
//  GameViewController.swift
//  SnakeGame
//
//  Created by Denis Kuzmin on 16.03.2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UIScreen.main.bounds.size)
        if let view = self.view as! SKView? {
            
            print(view.bounds.size)
            let scene = GameScene(size: view.bounds.size)

            view.ignoresSiblingOrder = true
            scene.scaleMode = .resizeFill
            view.showsFPS = true
            view.showsNodeCount = true
            view.presentScene(scene)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    /*override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }*/

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
