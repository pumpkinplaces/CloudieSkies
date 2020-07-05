//Best Version
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



class MainGame: SKScene {
   
    private var spinnyNode : SKShapeNode?
    
    var Bunny = SKSpriteNode()
    var sky = SKSpriteNode()
    var cloudTriple:SKNode = SKNode()
    var nextTriple:SKNode! = SKNode()
    var moveAndRemove = SKAction()
    var touchToStart = SKLabelNode()
    var firsttouch = false
    var isOnCloud:SKSpriteNode? = SKSpriteNode()
    var countfirst = 0
    var savepos = 0
    var onACloud = Bool()
    var distance = CGFloat()
    
    var tapScreen = UITapGestureRecognizer()
    var leftSwipe = UISwipeGestureRecognizer()
    var rightSwipe = UISwipeGestureRecognizer()
    var downSwipe = UISwipeGestureRecognizer()
    var upSwipe = UISwipeGestureRecognizer()
    
    var Cloud1:SKSpriteNode? = SKSpriteNode()
    var Cloud2: SKSpriteNode? = SKSpriteNode()
    var Cloud3:SKSpriteNode? = SKSpriteNode()
    let xdistance: CGFloat = 5
    let ydistance:CGFloat = 40
    var cloudheight = CGFloat()
    var countTheTriples:[Int: SKNode?] = [Int(): SKNode()]
    var listOfChildren: [Int:[SKSpriteNode?]] = [Int():[SKSpriteNode()]]
    var triplesChildren: [SKSpriteNode?] = [SKSpriteNode()]

    private var score : SKLabelNode!
    var score1: SKLabelNode!
    var bunnysdone = Bool()
    var restart: SKSpriteNode!
    var scorenum:Int = 0
    
    var cloudCreatorDelayTime:CGFloat = 0.75
    var bunnyHopTime = 0.4
    var cloudMoveTime: CGFloat = 0.005

    
 
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        createOurScene()
        print("calling did move to")
    }
    
    private func createClouds() -> Void{
        //print("makes it to create clouds")
        
       // Cloud1 = SKSpriteNode(imageNamed: "Cloud")
        randomizeTheClouds()
        Cloud1!.zPosition = 1
        Cloud1!.setScale(0.12)
        Cloud1!.name = String(countfirst) + " One"
        //Cloud2 = SKSpriteNode(imageNamed: "Cloud")
        Cloud2!.zPosition = 1
        Cloud2!.name = String(countfirst) + "Two"
        Cloud2!.setScale(0.12)
       // Cloud3 = SKSpriteNode(imageNamed: "Cloud")
        Cloud3!.zPosition = 1
        Cloud3!.name = String(countfirst) + "Three"
        Cloud3!.setScale(0.12)
        
        let thirdwidth = self.frame.width/3
        let halfwidth = CGFloat(self.frame.width/2)
        let halfthirdwidth = Double(self.frame.width/3) / 2
          
        let firstthird = thirdwidth - CGFloat(halfthirdwidth) - halfwidth
        let secondthird = 2 * thirdwidth - CGFloat(halfthirdwidth) - halfwidth
        let thirdthird = self.frame.width - CGFloat(halfthirdwidth) - halfwidth
        let cloudRowYPos = self.frame.height / 2 + (self.frame.height / 10)

        cloudTriple = SKNode()
        cloudTriple.name = String(countfirst)
        
        Cloud1!.position = CGPoint(x: firstthird, y: cloudRowYPos)
        Cloud2!.position = CGPoint(x: secondthird, y: cloudRowYPos)
        Cloud3!.position = CGPoint(x: thirdthird, y: cloudRowYPos)
        
        if countfirst > 0{
            nilOrNot(cloud1: &Cloud1, cloud2: &Cloud2, cloud3: &Cloud3)
        }
        
        addTheKiddos(cloud1: Cloud1, cloud2: Cloud2, cloud3: Cloud3)
        self.addChild(cloudTriple)
        
        countTheTriples[countfirst] = cloudTriple
        listOfChildren[countfirst] = [Cloud1, Cloud2, Cloud3]

        if countfirst == 0{
        cloudheight = Cloud1!.frame.height
        Bunny.position = CGPoint(x: secondthird + xdistance, y: cloudRowYPos + ydistance)
        onACloud = true
        cloudTriple.addChild(Bunny)
        triplesChildren = listOfChildren[0]!
        distance = cloudRowYPos * 3
        }
        
        let moveClouds = SKAction.moveBy(x: 0, y: -distance, duration: Double(cloudMoveTime * distance))
        let cloudWait = SKAction.wait(forDuration: 3)
        let removetriple = SKAction.removeFromParent()
        moveAndRemove = SKAction.sequence([moveClouds, cloudWait, removetriple])
        cloudTriple.run(moveAndRemove)
        countfirst += 1
    }
    
    
    private func setUpUI(){
        sky = SKSpriteNode(imageNamed: "BlueSky")
        sky.setScale(1)
        sky.position = CGPoint(x: 701, y: -100)
        sky.zPosition = 0
        
        Bunny = SKSpriteNode(imageNamed: "Bunny1")
        Bunny.setScale(50)
        Bunny.zPosition = 2
        Bunny.size = CGSize(width: 100, height: 100)
        
        touchToStart = SKLabelNode(text: "Touch To Start")
        touchToStart.setScale(0.5)
        touchToStart.position = CGPoint(x: 0, y: 0)
        touchToStart.fontSize = 100
        touchToStart.fontColor = UIColor.cyan
        touchToStart.fontName = "Noteworthy-Bold"
        touchToStart.alpha = 100
        touchToStart.zPosition = 2
        
        tapScreen = UITapGestureRecognizer(target: self, action: #selector(tapPiece(_:)))
        leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        leftSwipe.direction = .left
        rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        rightSwipe.direction = .right
        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        upSwipe.direction = .up
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        downSwipe.direction = .down

        self.view!.addGestureRecognizer(tapScreen)
        self.view!.addGestureRecognizer(leftSwipe)
        self.view!.addGestureRecognizer(rightSwipe)
        self.view!.addGestureRecognizer(upSwipe)
        self.view!.addGestureRecognizer(downSwipe)
    }
    
    private func setUpScore(){
        score1 = SKLabelNode(text: "Score: " + String(scorenum))
        score1.setScale(0.75)
        score1.position = CGPoint(x: -self.frame.width/2 + 80, y: -self.frame.height/2 + 25)
        score1.fontSize = 38
        score1.fontColor = UIColor.darkGray


        score1.fontName = "AmericanTypewriter-Bold"
        score1.alpha = 100
        score1.zPosition = 4
        let scorefadein = SKAction.fadeIn(withDuration: 0.5)
        self.addChild(score1)
        score1.run(scorefadein)
    }
    
    private func restartButton(){
        restart = SKSpriteNode(imageNamed: "TryAgainButton")
        restart.setScale(0.14)
        restart.position = CGPoint(x: 0, y: 0)
        restart.zPosition = 5
        self.addChild(restart)
    }
    
    
    private func randomizeTheClouds(){
        let cloudlist = [Cloud1, Cloud2, Cloud3]
        for each in cloudlist{
            if each == Cloud1{
                let oneToFour = Int.random(in: 0...3)
                let oneToFour2 = Int.random(in: 0...3)
                let oneToFour3 = Int.random(in: 0...3)
                let list = [oneToFour, oneToFour2, oneToFour3]
                for each in list{
                    if each == 0 {Cloud1 = SKSpriteNode(imageNamed: "Cloud")}
                    else if each == 1 {Cloud1 = SKSpriteNode(imageNamed: "Cloud2")}
                    else if each == 2 {Cloud1 = SKSpriteNode(imageNamed: "Cloud3")}
                    else {Cloud1 = SKSpriteNode(imageNamed: "Cloud4")}
                    }
                }
            else if each == Cloud2{
                let oneToFour = Int.random(in: 0...3)
                let oneToFour2 = Int.random(in: 0...3)
                let oneToFour3 = Int.random(in: 0...3)
                let list = [oneToFour, oneToFour2, oneToFour3]
                for each in list{
                    if each == 0 {Cloud2 = SKSpriteNode(imageNamed: "Cloud")}
                    else if each == 1 {Cloud2 = SKSpriteNode(imageNamed: "Cloud2")}
                    else if each == 2 {Cloud2 = SKSpriteNode(imageNamed: "Cloud3")}
                    else {Cloud2 = SKSpriteNode(imageNamed: "Cloud4")}
                    }
                }
            else if each == Cloud3{
                let oneToFour = Int.random(in: 0...3)
                let oneToFour2 = Int.random(in: 0...3)
                let oneToFour3 = Int.random(in: 0...3)
                let list = [oneToFour, oneToFour2, oneToFour3]
                for each in list{
                    if each == 0 {Cloud3 = SKSpriteNode(imageNamed: "Cloud")}
                    else if each == 1 {Cloud3 = SKSpriteNode(imageNamed: "Cloud2")}
                    else if each == 2 {Cloud3 = SKSpriteNode(imageNamed: "Cloud3")}
                    else {Cloud3 = SKSpriteNode(imageNamed: "Cloud4")}
                }
            }
        }
    }
    
    
    private func addTheKiddos(cloud1: SKSpriteNode?, cloud2: SKSpriteNode?, cloud3: SKSpriteNode?){
        if let _ = cloud1{
            cloudTriple.addChild(cloud1!)
        }
        if let _ = cloud2{
            cloudTriple.addChild(cloud2!)
        }
        if let _ = cloud3{
            cloudTriple.addChild(cloud3!)
        }
    }
    

    private func nilOrNot(cloud1: inout SKSpriteNode?, cloud2: inout SKSpriteNode?, cloud3: inout SKSpriteNode?){
        let randomNum = Int.random(in: 0...2)
    
        if randomNum == 0{
            var lineOfClouds:[SKSpriteNode?] = [cloud1, cloud2, cloud3]//first if
            lineOfClouds.remove(at: 0)
            let randomNum2 = Int.random(in: 1...100)
            let randomNum1or2 = Int.random(in: 1...2)
            if randomNum1or2 == 1 {
                if randomNum2 > 20{
                cloud2 = nil
                lineOfClouds.remove(at: 0)
                let finalRan = Int.random(in: 1...100)
                if finalRan > 5{
                    cloud3 = nil
                }
            }
                else if randomNum2 < 20{
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 5{
                        cloud3 = nil}
                }
            }
            else if randomNum1or2 == 2{
                if randomNum2 > 20{
                    cloud3 = nil
                    lineOfClouds.remove(at: 1)
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 5{
                        cloud2 = nil
                    }
                }
                else if randomNum2 < 20{
                let finalRan = Int.random(in: 1...100)
                if finalRan > 5{
                    cloud3 = nil}
            }
        }
    } //end of first if
            
        else if randomNum == 1{
            var lineOfClouds:[SKSpriteNode?] = [cloud1, cloud2, cloud3]
            lineOfClouds.remove(at: 1)
            let randomNum2 = Int.random(in: 1...100)
            let randomNum1or2 = Int.random(in: 1...2)
            if randomNum1or2 == 1 {
                if randomNum2 > 20{
                    cloud1 = nil
                    lineOfClouds.remove(at: 0)
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 5{
                        cloud3 = nil
                    }
                }
                else if randomNum2 < 20{
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 5{
                        cloud3 = nil}
                }
            }
                
            else if randomNum1or2 == 2{
                if randomNum2 > 20{
                    cloud3 = nil
                    lineOfClouds.remove(at: 1)
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 5{
                        cloud1 = nil
                    }
                }
                else if randomNum2 < 20{
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 5{
                    cloud1 = nil}
                }
            }
        } // end of second if
                        
        else{ //start of else where cloud 3 cant equal nil
            var lineOfClouds:[SKSpriteNode?] = [cloud1, cloud2, cloud3]
            lineOfClouds.remove(at: 2)
            let randomNum2 = Int.random(in: 1...100)
            let randomNum1or2 = Int.random(in: 1...2)
            if randomNum1or2 == 1 {
                if randomNum2 > 27{
                    cloud1 = nil
                    lineOfClouds.remove(at: 0)
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 5{
                        cloud2 = nil
                    }
                }
                else if randomNum2 < 27{
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 5{
                        cloud2 = nil}
                }
            }
                else if randomNum1or2 == 2{
                    if randomNum2 > 27{
                        cloud2 = nil
                        lineOfClouds.remove(at: 1)
                        let finalRan = Int.random(in: 1...100)
                        if finalRan > 5{
                            cloud1 = nil
                        }
                    }
                else if randomNum2 < 27{
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 5{
                        cloud1 = nil}
                    }
                }
            }
        }
    
    
        private func samePos(bunny: SKSpriteNode, cloudpos1: SKSpriteNode?,  cloudpos2: SKSpriteNode?, cloudpos3: SKSpriteNode?) -> Bool{
            if let onCloud1 = cloudpos1{
            if bunny.position.x > onCloud1.position.x - 50 + (xdistance) && bunny.position.x < onCloud1.position.x + 50 + (xdistance) && bunny.position.y > onCloud1.position.y - 40 + ydistance && bunny.position.y < onCloud1.position.y + 40 + ydistance {
                isOnCloud = cloudpos1
                return true}
            else{
                if samePos(bunny: bunny, cloudpos1: nil, cloudpos2: cloudpos2, cloudpos3: cloudpos3) == true{
                    return true
                }
            }
        }
            else if let onCloud2 = cloudpos2{
              if bunny.position.x > onCloud2.position.x - 50 + (xdistance) && bunny.position.x < onCloud2.position.x + 50 + (xdistance) && bunny.position.y > onCloud2.position.y - 40 + ydistance && bunny.position.y < onCloud2.position.y + 40 + ydistance {
                isOnCloud = cloudpos2
                   return true}
                else{
                    if samePos(bunny: bunny, cloudpos1: nil, cloudpos2: nil, cloudpos3: cloudpos3) == true{
                        return true
                    }
                }
            }
            else if let onCloud3 = cloudpos3{
               if bunny.position.x > onCloud3.position.x - 50 + (xdistance) && bunny.position.x < onCloud3.position.x + 50 + (xdistance) && bunny.position.y > onCloud3.position.y - 40 + ydistance && bunny.position.y < onCloud3.position.y + 40 + ydistance {
                isOnCloud = cloudpos3
                   return true
               }
           }
           return false
       }
    

    private func inRange(_ node: SKNode) -> Bool{
        let cloudRowYPos = self.frame.height / 2 + (self.frame.height / 10)
        if node.position.y + cloudRowYPos > -self.frame.height/2 + node.frame.height && node.position.y + cloudRowYPos < self.frame.height/2 - (cloudheight / 2) {
            return true
            }
        return false
    }
    
    
    private func bunnyInRangeLeft(_ bunny: SKSpriteNode) -> Bool{
        //Right now, I can move it left and not right, which means that the positive self.frame is off
        let thirdWidth = self.frame.width / 3
        if bunny.position.x - thirdWidth + xdistance > -self.frame.width / 2{
            return true
        }
        return false
    }
    
    
    private func bunnyInRangeRight(_ bunny: SKSpriteNode) -> Bool{
        let thirdWidth = self.frame.width / 3
        if bunny.position.x + thirdWidth + xdistance < self.frame.width / 2{
            return true
        }
        return false
    }
    
    
    private func bunnyInRangeFarLeft(_ bunny: SKSpriteNode) -> Bool{
        let thirdwidth = self.frame.width / 3
        if bunny.position.x + 2 * thirdwidth + xdistance < self.frame.width/2{
            return true
        }
        return false
    }
    
    
    private func bunnyInRangeFarRight(_ bunny: SKSpriteNode) -> Bool{
        let thirdwidth = self.frame.width / 3
        if bunny.position.x - 2 * thirdwidth + xdistance > -self.frame.width/2{
            return true
        }
        return false
    }
    
    private func doTheBunnyHop() {
        savepos += 1
        nextTriple = countTheTriples[savepos]!
        triplesChildren = listOfChildren[savepos]!
        countTheTriples.removeValue(forKey: savepos-1)
        listOfChildren.removeValue(forKey: savepos-1)
        Bunny.move(toParent: nextTriple)
        scorenum += 1
    }
    

    private func createOurScene(){
        setUpUI()
        self.addChild(sky)
        self.addChild(touchToStart)
    }
    
    
    private func restartGame(){
        self.removeAllActions()
        self.removeAllChildren()
        bunnysdone = false; firsttouch = false; savepos = 0; countfirst = 0; onACloud = false; scorenum = 0; cloudCreatorDelayTime = 0.75; bunnyHopTime = 0.4; cloudMoveTime = 0.005;
        createOurScene()
    }
    

     //I need to check that the bunny actually changed its information on the position AFTER it did the bunny math!
    // I should also check that the bunny ended up in the right position after doing the bunny math to move to the next cloud.
    
    
    
    private func makeTheChange(){
        switch scorenum{
        case 0...150:
            cloudCreatorDelayTime = 0.45
            cloudMoveTime = 0.003
            bunnyHopTime = 0.12
            /*
        case 21...25:
            cloudCreatorDelayTime = 0.53
            cloudMoveTime = 0.0037
            bunnyHopTime = 0.265
        case 26...30:
            cloudCreatorDelayTime = 0.54
            cloudMoveTime = 0.00367
            bunnyHopTime = 0.264
        case 31...40:
            cloudCreatorDelayTime = 0.5
            cloudMoveTime =
            bunnyHopTime =
        case 41...45:
            cloudCreatorDelayTime = */
        default:
                cloudCreatorDelayTime = 0.6
                cloudMoveTime = 0.004
                bunnyHopTime = 0.3
            }
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
        if firsttouch == false{
            firsttouch = true
            let spawn = SKAction.run({ // it's running a closure
                () in // specifying the function's parameters as well as the function that it takes in which in turn returns void
                self.createClouds()
            })
            
            let delay = SKAction.wait(forDuration: Double(cloudCreatorDelayTime))
        let spawnDelay = SKAction.sequence([spawn, delay])
        let spawnDelayForever = SKAction.repeatForever(spawnDelay)
        self.run(spawnDelayForever)
        setUpScore()
        }
        for touch in touches{
            let local = touch.location(in: self)
            if bunnysdone == true{
                if restart.contains(local){
                    restartGame()
            }
        }
    }
}
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self))}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    

    /*
    @IBAction func tapPiece(_ gestureRecognizer : UITapGestureRecognizer ) {
    guard gestureRecognizer.view != nil else { return }
         
    if gestureRecognizer.state == .ended {      // Move the view down and to the right when tapped.
       let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
          gestureRecognizer.view!.center.x += 100
          gestureRecognizer.view!.center.y += 100
       })
       animator.startAnimation()
    }} */
    

    @IBAction func tapPiece(_ gestureRecognizer : UITapGestureRecognizer ) {
    guard gestureRecognizer.view != nil else { return }
        if firsttouch == true && gestureRecognizer.state == .ended{
            if onACloud == true && Bunny.hasActions() == false{
                if inRange(Bunny.parent!){
                    let distBetween = (countTheTriples[savepos+1]!?.position.y)! - (countTheTriples[savepos]!?.position.y)!
                    Bunny.run(SKAction.moveBy(x: 0, y: distBetween, duration: bunnyHopTime))
                    doTheBunnyHop()
                }
            }
        }
    }
       

    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) { //1
        gestureRecognizer.isEnabled = true
        let firstThirdWidth = self.frame.width / 3
        if firsttouch == true{ //2
            if gestureRecognizer.state == .ended { //3
                if onACloud == true && Bunny.hasActions() == false{ //5
                    switch gestureRecognizer.direction {
                    case .left:
                        if inRange(Bunny.parent!) && bunnyInRangeLeft(Bunny){ //6
                            let distBetween = (countTheTriples[savepos+1]!?.position.y)! - (countTheTriples[savepos]!?.position.y)!
                            Bunny.run(SKAction.moveBy(x: -firstThirdWidth, y: distBetween, duration: bunnyHopTime))
                            doTheBunnyHop()
                        }
                    case .right:
                            if inRange(Bunny.parent!) && bunnyInRangeRight(Bunny){ //9
                                let distBetween = (countTheTriples[savepos+1]!?.position.y)! - (countTheTriples[savepos]!?.position.y)!
                                Bunny.run(SKAction.moveBy(x: firstThirdWidth, y: distBetween, duration: bunnyHopTime))
                                doTheBunnyHop()
                        }
                    case .up:
                        if inRange(Bunny.parent!) && bunnyInRangeFarLeft(Bunny){ //9
                            let distBetween = (countTheTriples[savepos+1]!?.position.y)! - (countTheTriples[savepos]!?.position.y)!
                            Bunny.run(SKAction.moveBy(x: 2 * firstThirdWidth , y: distBetween, duration: bunnyHopTime))
                            doTheBunnyHop()
                        }
                    case .down:
                        if inRange(Bunny.parent!) && bunnyInRangeFarRight(Bunny){ //9
                            let distBetween = (countTheTriples[savepos+1]!?.position.y)! - (countTheTriples[savepos]!?.position.y)!
                            Bunny.run(SKAction.moveBy(x: 2 * -firstThirdWidth, y: distBetween, duration: bunnyHopTime))
                            doTheBunnyHop()
                            }
                    default: break
                }
            }
        }
    }
}
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    
        if firsttouch == true{
          //  print("came to update")
            touchToStart.run(SKAction.fadeOut(withDuration: 0.2))}
        if countfirst > 0{
            if samePos(bunny: Bunny, cloudpos1: triplesChildren[0], cloudpos2: triplesChildren[1], cloudpos3: triplesChildren[2]){
                onACloud = true}
        else {onACloud = false}
            let convertedBunnyPos = self.convert(Bunny.position, from: Bunny.parent!)
            if convertedBunnyPos.y < -self.frame.height / 2 + Bunny.frame.height / 2{
                bunnysdone = true}
        
        if !Bunny.hasActions(){
            if samePos(bunny: Bunny, cloudpos1: triplesChildren[0], cloudpos2: triplesChildren[1], cloudpos3: triplesChildren[2]) {
                score1.text = "Score: " + String(scorenum)
            }
             else{bunnysdone = true}
            }
        }
        //if scorenum == 15 || scorenum == 16{
           // print("scorenum: \(scorenum)", "clouddelaytime: \(cloudCreatorDelayTime)", "cloudmovetime: \(cloudmovetime)")
       // }

        if bunnysdone == true{
            self.removeAllActions()
             //firsttouch = false
            Bunny.run(SKAction.fadeOut(withDuration: 0.5))
            restartButton()
        }
        makeTheChange()
    }
}

