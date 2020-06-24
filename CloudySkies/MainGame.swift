//
//  MainGame.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 6/23/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let Bunny: UInt32 = 0b1 << 1
    static let Clouds: UInt32 = 0b1 << 2
}

class MainGame: SKScene {
   
    private var score : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var Bunny = SKSpriteNode()
    var sky = SKSpriteNode()
    var cloudTriple = SKNode()
    var moveAndRemove = SKAction()
    var gameStarted = Bool()
    var firsttouch = false
    
    var Cloud1:SKSpriteNode? = SKSpriteNode()
    var Cloud2: SKSpriteNode? = SKSpriteNode()
    var Cloud3:SKSpriteNode? = SKSpriteNode()
    let xdistance: CGFloat = 5
    let ydistance:CGFloat = 30
    var startCloud: SKSpriteNode? = SKSpriteNode()

    
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        setUpUI()
        startCloud = SKSpriteNode(imageNamed: "Cloud")
        startCloud!.zPosition = 1
        startCloud!.setScale(0.12)
        startCloud!.position = CGPoint(x: 0, y: 0)
        Bunny.position.x = Cloud2!.position.x + xdistance
        Bunny.position.y = Cloud2!.position.y + ydistance
        self.addChild(startCloud!)
        self.addChild(Bunny)
        self.addChild(sky)
        
        print(type(of: Cloud1))
        //print(self.frame.width, self.frame.height, separator: "  ")
    }
    
    private func createClouds(){
        Cloud1 = SKSpriteNode(imageNamed: "Cloud")
        Cloud1!.zPosition = 1
        Cloud1!.setScale(0.12)
        Cloud2 = SKSpriteNode(imageNamed: "Cloud")
        Cloud2!.zPosition = 1
        Cloud2!.setScale(0.12)
        Cloud3 = SKSpriteNode(imageNamed: "Cloud")
        Cloud3!.zPosition = 1
        Cloud3!.setScale(0.12)
               
        Cloud1!.physicsBody = SKPhysicsBody(circleOfRadius: Cloud1!.frame.height/4)
        Cloud1!.physicsBody?.categoryBitMask = PhysicsCategory.Clouds
        Cloud1!.physicsBody?.contactTestBitMask = PhysicsCategory.Bunny
        Cloud1!.physicsBody?.affectedByGravity = false
        Cloud1!.physicsBody?.isDynamic = true
               
        Cloud2!.physicsBody = SKPhysicsBody(circleOfRadius: Cloud2!.frame.height/4)
        Cloud2!.physicsBody?.categoryBitMask = PhysicsCategory.Clouds
        Cloud2!.physicsBody?.contactTestBitMask = PhysicsCategory.Bunny
        Cloud2!.physicsBody?.affectedByGravity = false
        Cloud2!.physicsBody?.isDynamic = false
               
        Cloud3!.physicsBody = SKPhysicsBody(circleOfRadius: Cloud3!.frame.height/4)
        Cloud3!.physicsBody?.categoryBitMask = PhysicsCategory.Clouds
        Cloud3!.physicsBody?.contactTestBitMask = PhysicsCategory.Bunny
        Cloud3!.physicsBody?.affectedByGravity = false
        Cloud3!.physicsBody?.isDynamic = true
        
        let halfheight: CGFloat = self.frame.height / 2
        let fifthheight: CGFloat = self.frame.height/5
        let halffifth: CGFloat = fifthheight / 2
        
        print(self.frame.width, self.frame.width/3, separator: " ,  ")
        let thirdwidth = self.frame.width/3
        let halfwidth = CGFloat(self.frame.width/2)
        let halfthirdwidth = Double(self.frame.width/3) / 2
        print(halfwidth)
        let firstthird = thirdwidth - CGFloat(halfthirdwidth) - halfwidth
        let double1 = Double(firstthird)
        print(double1)
        let secondthird = 2 * thirdwidth - CGFloat(halfthirdwidth) - halfwidth
        let thirdthird = self.frame.width - CGFloat(halfthirdwidth) - halfwidth
        let cloudRowYPos = -halfheight + fifthheight - halffifth
        
        cloudTriple = SKNode()
        Cloud1!.position = CGPoint(x: firstthird, y: cloudRowYPos)
        Cloud2!.position = CGPoint(x: secondthird, y: cloudRowYPos)
        Cloud3!.position = CGPoint(x: thirdthird, y: cloudRowYPos)
        Bunny.position = CGPoint(x: secondthird + xdistance, y: cloudRowYPos + ydistance)
    
        cloudTriple.addChild(Cloud1!)
        cloudTriple.addChild(Cloud2!)
        cloudTriple.addChild(Cloud3!)
        
        self.addChild(cloudTriple)
    }
    
    
    private func samePos(bunny: SKSpriteNode, cloudpos1: SKSpriteNode?,  cloudpos2: SKSpriteNode?, cloudpos3: SKSpriteNode?) -> Bool{
        if let onCloud1 = cloudpos1{
            if bunny.position.x == onCloud1.position.x + xdistance && bunny.position.y == onCloud1.position.y + ydistance{
                return true}
            }
        else if let onCloud2 = cloudpos2{
            if bunny.position.x == onCloud2.position.x + xdistance && bunny.position.y == onCloud2.position.y + ydistance{
                return true}
            }
        else if let onCloud3 = cloudpos3{
            if bunny.position.x == onCloud3.position.x + xdistance && bunny.position.y == onCloud3.position.y + ydistance{
                return true
            }
        }
        return false
    }
    
  
    private func setUpUI(){
        sky = SKSpriteNode(imageNamed: "BlueSky")
        sky.setScale(1)
        sky.position = CGPoint(x: 701, y: -100)
        sky.zPosition = 0
        
        Bunny = SKSpriteNode(imageNamed: "Bunny1")
        Bunny.setScale(0.13)
        Bunny.zPosition = 2
        
        Bunny.physicsBody = SKPhysicsBody(rectangleOf: Bunny.size)
        Bunny.physicsBody?.categoryBitMask = PhysicsCategory.Bunny
        Bunny.physicsBody?.contactTestBitMask = PhysicsCategory.Clouds
        Bunny.physicsBody?.affectedByGravity = true
    
        if samePos(bunny: Bunny, cloudpos1: Cloud1, cloudpos2: Cloud2, cloudpos3: Cloud3) == true {
        Bunny.physicsBody?.affectedByGravity = false}
        else {Bunny.physicsBody?.affectedByGravity = true}
        Bunny.physicsBody?.isDynamic = false
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
        //Bunny.physicsBody?.applyImpulse(CGVector(mak))
        firsttouch = true
        if gameStarted == false{
            let spawn = SKAction.run({
                () in
                self.createClouds()
            })
            let delay = SKAction.wait(forDuration: 1)
            let spawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayForever)
            
            let distance = CGFloat(self.frame.height/5 + cloudTriple.frame.height)
            let moveClouds = SKAction.moveBy(x: 0, y: distance, duration: 0.02 * Double(distance))
            let removetriple = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([moveClouds, removetriple])
            //let moveAndRemoveForever = SKAction.repeatForever(moveAndRemove)
            //cloudTriple.run(moveAndRemoveForever)
            
            Bunny.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            Bunny.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        }
        else {Bunny.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            Bunny.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))}
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
        if firsttouch == true{
            print("came here")
            let remove = SKAction.removeFromParent()
            startCloud?.run(remove)
        }
        
    }
}



