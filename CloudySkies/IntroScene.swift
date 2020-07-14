//
//  GameScene.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 6/15/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import SpriteKit
import GameplayKit



class IntroScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var image = SKSpriteNode()

    
    override func didMove(to view: SKView) {
        
    // Get label node from scene and store it for use later
        self.backgroundColor = UIColor(red: 128, green: 75, blue: 71)
        image = SKSpriteNode(imageNamed: "AirDares")
        image.position = CGPoint(x: 100, y: 0)
        image.setScale(0.45)
        self.addChild(image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let gamescene = GameScene(fileNamed: "GameScene")
            let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
            self.scene?.view?.presentScene(gamescene!, transition: fadeAway)
        })
       
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    

    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
}
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
