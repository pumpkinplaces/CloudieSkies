//
//  StoreScene.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 7/22/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class StoreScene1: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?

    var BlueRabbita = SKSpriteNode()
    var PinkRabbita = SKSpriteNode()
    var GreenRabbita = SKSpriteNode()
    var GrayRabbita = SKSpriteNode()
    var PurpleRabbita = SKSpriteNode()
    var OrangeRabbita = SKSpriteNode()
    var RedRabbita = SKSpriteNode()
    
    var useSquare = SKSpriteNode()
    var use = SKLabelNode()
    var exit = SKLabelNode()
    var exitBorder = SKShapeNode()
    
    var select = SKSpriteNode()
    var storeBackground = SKSpriteNode()
    var rabbitaColor = UserDefaults().string(forKey: "RabbitaColor")
    
    var priceTag = SKSpriteNode()
    var Carrot = SKSpriteNode()
    var price = SKLabelNode()
    var bunnyList:[String] = []
    var bunnyPriceList:[String:Int] = [:]
    var bunnyDictionary: [String: SKSpriteNode] = [:]
    var yourCarrots = SKLabelNode()
    var yourCarrotsBorder = SKShapeNode()

    var arrow = SKSpriteNode()
    var selectedBunny: SKSpriteNode?
    var useOrPriceList:[SKSpriteNode] = []
    var useOrPriceDict:[SKSpriteNode:SKSpriteNode] = [:]
    
    var usingTab = SKSpriteNode()
    var using = SKLabelNode()
    var bunnyBeingUsed:SKSpriteNode?
    var blackLine = SKSpriteNode()
    var inMovedToView = Bool()
    var sorryTabClosed = true
    
    var sorryTab = SKSpriteNode()
    var sorryLabel = SKLabelNode()
    var sorryNum = SKLabelNode()
    var sorryEnd = SKLabelNode()
    var close = SKLabelNode()
    
    override func didMove(to view: SKView) {
    // Get label node from scene and store it for use later
        //self.backgroundColor = UIColor(red: 41, green: 54, blue: 43)
        inMovedToView = true
        storeBackground = SKSpriteNode(imageNamed: "StoreBackground2")
        storeBackground.setScale(3.5)
        storeBackground.position = CGPoint.zero
        storeBackground.zPosition = 0
        self.addChild(storeBackground)
        resetRabbita()
        setUpStore()
        select = SKSpriteNode(color: UIColor.white, size: CGSize(width: 130, height: 120))
        select.alpha = 0.35
        select.zPosition = 1
        if bunnyList.contains(UserDefaults().string(forKey: "bunnyType")!){
            selectPosition(animationType: UserDefaults().string(forKey: "bunnyType")!)
        }
        else{select.position = CGPoint(x: 2 * self.frame.width, y: 0)}
        self.addChild(select)
        setPrices(list: bunnyList)
        makeYourCarrots()
        inMovedToView = false
    }
        
    private func setUpStore(){
        exit = SKLabelNode(text: "Exit")
        exit.fontName = "Noteworthy-Bold"
        exit.fontSize = 30
        exit.fontColor = UIColor.black
        exit.zPosition = 3
        exit.position = CGPoint(x: self.frame.width/2 - 50, y: self.frame.height/2 - 55)
        setUpAnimals()
         self.addChild(exit)
        makeTheBorder(exit, color: UIColor.white, posit: CGPoint(x: self.frame.width/2 - 75, y: self.frame.height/2 - 55), scaleTo: 1, theborder: &exitBorder)
        exitBorder.zPosition = 2
        
        arrow = SKSpriteNode(imageNamed: "Arrow")
        arrow.setScale(0.17)
        arrow.xScale = arrow.xScale * -1
        arrow.position = CGPoint(x: 0, y: 5 * self.frame.height/10 - self.frame.height/20 - 11)
        arrow.zPosition = 3
        self.addChild(arrow)
    }
    
    private func makeYourCarrots(){
           let carrotInt:String! = String(UserDefaults().integer(forKey: "CarrotCount"))
           yourCarrots = SKLabelNode(text: "Your Carrots: " + carrotInt)
           yourCarrots.fontName = "Noteworthy-Bold"
           yourCarrots.fontSize = 35
           yourCarrots.zPosition = 4
           yourCarrots.fontColor = UIColor.white
           yourCarrots.position = CGPoint(x: 0, y: -4 * self.frame.height/10 - self.frame.height/20)
           self.addChild(yourCarrots)
           
           blackLine = SKSpriteNode(imageNamed: "BlackLine")
           blackLine.size = CGSize(width: self.frame.width, height: 57)
           blackLine.position.x = yourCarrots.position.x
           blackLine.position.y = yourCarrots.position.y + 15
           blackLine.zPosition = 3
           self.addChild(blackLine)
       }
    
    private func setUpAnimals(){
        let tenthHeight = self.frame.height/10; let tenthHeightMid = self.frame.height/20
        let halfiwdthMid = self.frame.width/2 - self.frame.width/4
        
        RedRabbita = SKSpriteNode(imageNamed: "Rabbita1")
        RedRabbita.run(SKAction.colorize(with: UIColor.systemRed, colorBlendFactor: 0.3, duration: 0))
        RedRabbita.name = "RedRabbita"
        RedRabbita.zPosition = 3
        RedRabbita.position = CGPoint(x: -halfiwdthMid, y: 4 * tenthHeight - tenthHeightMid)
        RedRabbita.size = CGSize(width: 120, height: 120)
        self.addChild(RedRabbita)
        bunnyList.append("RedRabbita")
        bunnyDictionary["RedRabbita"] = RedRabbita
        bunnyPriceList["RedRabbita"] = 1000
        
        OrangeRabbita = SKSpriteNode(imageNamed: "Rabbita1")
        OrangeRabbita.name = "OrangeRabbita"
        OrangeRabbita.run(SKAction.colorize(with: UIColor(red: 235, green: 149, blue: 152), colorBlendFactor: 0.4, duration: 0))
        OrangeRabbita.zPosition = 3
        OrangeRabbita.position = CGPoint(x: -halfiwdthMid, y: 2 * tenthHeight - tenthHeightMid)
        OrangeRabbita.size = CGSize(width: 120, height: 120)
        self.addChild(OrangeRabbita)
        bunnyList.append("OrangeRabbita")
        bunnyDictionary["OrangeRabbita"] = OrangeRabbita
        bunnyPriceList["OrangeRabbita"] = 1000
        
        BlueRabbita = SKSpriteNode(imageNamed: "Rabbita1")
        BlueRabbita.run(SKAction.colorize(with: UIColor.blue, colorBlendFactor: 0.4, duration: 0))
        BlueRabbita.name = "BlueRabbita"
        BlueRabbita.zPosition = 3
        BlueRabbita.position = CGPoint(x: -halfiwdthMid, y: -tenthHeightMid)
        BlueRabbita.size = CGSize(width: 120, height: 120)
        self.addChild(BlueRabbita)
        bunnyList.append("BlueRabbita")
        bunnyDictionary["BlueRabbita"] = BlueRabbita
        bunnyPriceList["BlueRabbita"] = 1000
        
        PinkRabbita = SKSpriteNode(imageNamed: "Rabbita1")
        PinkRabbita.run(SKAction.colorize(with: UIColor.systemPink, colorBlendFactor: 0.4, duration: 0))
        PinkRabbita.name = "PinkRabbita"
        PinkRabbita.zPosition = 3
        PinkRabbita.position = CGPoint(x: -halfiwdthMid, y: -2 * tenthHeight - tenthHeightMid)
        PinkRabbita.size = CGSize(width: 120, height: 120)
        self.addChild(PinkRabbita)
        bunnyList.append("PinkRabbita")
        bunnyDictionary["PinkRabbita"] = PinkRabbita
        bunnyPriceList["PinkRabbita"] = 2
        
        GreenRabbita = SKSpriteNode(imageNamed: "Rabbita1")
        GreenRabbita.run(SKAction.colorize(with: UIColor(red: 82, green: 171, blue: 75), colorBlendFactor: 0.4, duration: 0))
        GreenRabbita.name = "GreenRabbita"
        GreenRabbita.zPosition = 3
        GreenRabbita.position = CGPoint(x: halfiwdthMid, y: -tenthHeightMid)
        GreenRabbita.size = CGSize(width: 120, height: 120)
        self.addChild(GreenRabbita)
        bunnyList.append("GreenRabbita")
        bunnyDictionary["GreenRabbita"] = GreenRabbita
        bunnyPriceList["GreenRabbita"] = 1000
        
        GrayRabbita = SKSpriteNode(imageNamed: "Rabbita1")
        GrayRabbita.run(SKAction.colorize(with: UIColor.gray, colorBlendFactor: 0.4, duration: 0))
        GrayRabbita.name = "GrayRabbita"
        GrayRabbita.zPosition = 3
        GrayRabbita.position = CGPoint(x: halfiwdthMid, y: 4 * tenthHeight - tenthHeightMid)
        GrayRabbita.size = CGSize(width: 120, height: 120)
        self.addChild(GrayRabbita)
        bunnyList.append("GrayRabbita")
        bunnyDictionary["GrayRabbita"] = GrayRabbita
        bunnyPriceList["GrayRabbita"] = 1000
        
        PurpleRabbita = SKSpriteNode(imageNamed: "Rabbita1")
        PurpleRabbita.run(SKAction.colorize(with: UIColor(red: 123, green: 75, blue: 171), colorBlendFactor: 0.4, duration: 0))
        PurpleRabbita.name = "PurpleRabbita"
        PurpleRabbita.zPosition = 3
        PurpleRabbita.position = CGPoint(x: halfiwdthMid, y: 2 * tenthHeight - tenthHeightMid)
        PurpleRabbita.size = CGSize(width: 120, height: 120)
        self.addChild(PurpleRabbita)
        bunnyList.append("PurpleRabbita")
        bunnyDictionary["PurpleRabbita"] = PurpleRabbita
        bunnyPriceList["PurpleRabbita"] = 1000
    }
    
    
    private func setPrices(list: [String]){
        for each in list{
            if UserDefaults().dictionary(forKey: "Owned")![each] as! Bool == true{
                if bunnyDictionary[each] != selectedBunny{
                createUseIcon(bunny: bunnyDictionary[each]!, justBoughtIt: false, num: nil)
                }
                else{createUsingTab(usePict: bunnyDictionary[each]!, num: 0)}
            }
            else{createPriceLabel(bunnyprice: bunnyDictionary[each]!, bunny: each)}
        }
    }
    
     private func createUseIcon(bunny: SKSpriteNode, justBoughtIt:Bool, num: Int?){
           useSquare = SKSpriteNode(imageNamed: "Use")
           useSquare.name = bunny.name
           useSquare.size = CGSize(width: 130, height: 45)
           useSquare.zPosition = 3
           useSquare.position.y = bunny.position.y - self.frame.height / 10
           useSquare.position.x = bunny.position.x
           self.addChild(useSquare)
           
           if justBoughtIt{
               if let pos = num{
                   useOrPriceList[pos] = useSquare
                   useOrPriceDict[useSquare] = selectedBunny
               }
           }
           else{useOrPriceList.append(useSquare)
               useOrPriceDict[useSquare] = bunny}
           
           use = SKLabelNode(text: "Use")
           use.fontName = "Noteworthy-Bold"
           use.fontSize = 30
           use.zPosition = 1
           use.position = CGPoint(x: 0, y: -11)
           use.fontColor = UIColor(red: 237, green: 183, blue: 128)
           useSquare.addChild(use)
       }
    
    private func createPriceLabel(bunnyprice: SKSpriteNode, bunny: String){
        priceTag = SKSpriteNode(imageNamed: "PriceTag")
        priceTag.name = bunny
        priceTag.size = CGSize(width: 130, height: 45)
        priceTag.zPosition = 3
        priceTag.position.y = bunnyprice.position.y - self.frame.height / 10
        priceTag.position.x = bunnyprice.position.x
        self.addChild(priceTag)
        
        let itsPrice:String = String(bunnyPriceList[bunny]!)
        price = SKLabelNode(text: itsPrice)
        price.position = CGPoint(x: -11, y: -11)
        
        price.fontName = "Noteworthy-Bold"
        price.fontSize = 22
        price.fontColor = UIColor(red: 252, green: 250, blue: 230)
        price.zPosition = 1
        priceTag.addChild(price)
        
        Carrot = SKSpriteNode(imageNamed: "Carrot")
        Carrot.setScale(0.01)
        Carrot.position.x = Carrot.frame.width/2 + price.position.x + price.frame.width/2 + 5
        Carrot.position.y = 2
        Carrot.zPosition = 1
        priceTag.addChild(Carrot)
        
        useOrPriceList.append(priceTag)
        useOrPriceDict[priceTag] = bunnyprice
    }
    
   private func createUsingTab(usePict: SKSpriteNode, num: Int){
       usingTab = SKSpriteNode(imageNamed: "Using")
       if inMovedToView{usingTab.position.y = usePict.position.y - self.frame.height / 10
           usingTab.position.x = usePict.position.x
           useOrPriceDict[usingTab] = selectedBunny
       }
       else{
       usingTab.position = usePict.position
       usePict.removeFromParent()
       useOrPriceDict[usingTab] = usePict
       useOrPriceList[num] = usingTab
       }
       usingTab.zPosition = 3
       usingTab.size = CGSize(width: 130, height: 45)
       self.addChild(usingTab)
       using = SKLabelNode(text: "Using")
       using.fontName = "Noteworthy-Bold"
       using.fontSize = 30
       using.position = CGPoint(x: 0, y: -11)
       using.zPosition = 1
       using.fontColor = UIColor(red: 125, green: 7, blue: 11)
       usingTab.addChild(using)
   }

    
    private func createSorryTab(){
        sorryTab = SKSpriteNode(imageNamed: "SorrySquare")
        sorryTab.position = CGPoint(x: 0, y: 0)
        sorryTab.zPosition = 6
        let wid = 1.5 * self.frame.width/2
        sorryTab.size = CGSize(width: wid, height: wid)
        self.addChild(sorryTab)
        
        sorryLabel = SKLabelNode(text: "Sorry, You need: ")
        sorryLabel.setScale(0.8)
        sorryLabel.fontName = "Noteworthy-Bold"
        sorryLabel.fontSize = 30
        sorryLabel.position = CGPoint(x: 0, y: 50)
        sorryLabel.zPosition = 7
        sorryLabel.fontColor = UIColor(red: 218, green: 211, blue: 244)
        sorryTab.addChild(sorryLabel)
        
        let difference = bunnyPriceList[selectedBunny!.name!]! - UserDefaults().integer(forKey: "CarrotCount")
        let diffString: String! = String(difference)
        sorryNum = SKLabelNode(text: diffString)
        sorryNum.setScale(0.8)
        sorryNum.fontName = "Noteworthy-Bold"
        sorryNum.fontSize = 30
        sorryNum.position = CGPoint.zero
        sorryNum.zPosition = 7
        sorryNum.fontColor = UIColor(red: 218, green: 211, blue: 244)
        sorryTab.addChild(sorryNum)
        
        sorryEnd = SKLabelNode(text: "more carrots!")
        sorryEnd.setScale(0.8)
        sorryEnd.fontName = "Noteworthy-Bold"
        sorryEnd.fontSize = 30
        sorryEnd.position = CGPoint(x: 0, y: -50)
        sorryEnd.zPosition = 7
        sorryEnd.fontColor = UIColor(red: 218, green: 211, blue: 244)
        sorryTab.addChild(sorryEnd)
        
        let halfWid = wid/2
        close = SKLabelNode(text: "Close")
        close.setScale(0.599)
        close.fontName = "Noteworthy-Bold"
        close.fontSize = 30
        close.position = CGPoint(x: -halfWid + 40, y: halfWid - 40)
        close.zPosition = 7
        close.fontColor = UIColor(red: 218, green: 211, blue: 244)
        sorryTab.addChild(close)
    }
    private func resetRabbita(){
        UserDefaults().string(forKey: "RabbitaColor")
        if UserDefaults().string(forKey: "RabbitaColor") != "" {
            let string = UserDefaults().string(forKey: "RabbitaColor")! + "Rabbita"
            UserDefaults.standard.set(string, forKey: "bunnyType")
        }
    }
    
    private func selectPosition(animationType: String){
        switch animationType{
        case "PurpleRabbita": select.position = PurpleRabbita.position; selectedBunny = PurpleRabbita; bunnyBeingUsed = PurpleRabbita
        case "PinkRabbita": select.position = PinkRabbita.position; selectedBunny = PinkRabbita; bunnyBeingUsed = PinkRabbita
        case "GreenRabbita": select.position = GreenRabbita.position; selectedBunny = GreenRabbita; bunnyBeingUsed = GreenRabbita
        case "BlueRabbita": select.position =  BlueRabbita.position; selectedBunny = BlueRabbita; bunnyBeingUsed = BlueRabbita
        case "OrangeRabbita": select.position = OrangeRabbita.position; selectedBunny = OrangeRabbita; bunnyBeingUsed = OrangeRabbita
        case "RedRabbita": select.position = RedRabbita.position; selectedBunny = RedRabbita; bunnyBeingUsed = RedRabbita
        case "GrayRabbita": select.position = GrayRabbita.position; selectedBunny = GrayRabbita; bunnyBeingUsed = GrayRabbita
        default: break
        }
    }
    
    private func selectRabbitaCol(bunny: SKSpriteNode){
        switch bunny {
        case GrayRabbita: UserDefaults.standard.set("Gray", forKey: "RabbitaColor")
        case GreenRabbita: UserDefaults.standard.set("Green", forKey: "RabbitaColor")
        case BlueRabbita: UserDefaults.standard.set("Blue", forKey: "RabbitaColor")
        case PurpleRabbita: UserDefaults.standard.set("Purple", forKey: "RabbitaColor")
        case OrangeRabbita: UserDefaults.standard.set("Orange", forKey: "RabbitaColor")
        case RedRabbita: UserDefaults.standard.set("Red", forKey: "RabbitaColor")
        case PinkRabbita: UserDefaults.standard.set("Pink", forKey: "RabbitaColor")
        default:
            break
        }
    }
    
    private func theBlender<T: SKNode>(runActionOn thisnode: T){
           let blendIt = SKAction.colorize(with: UIColor.black, colorBlendFactor: 0.25, duration: 0.75)
           let wait = SKAction.wait(forDuration: 0.05)
           let unBlend = SKAction.colorize(withColorBlendFactor: -0.9, duration: 0.25)
           let sequ = SKAction.sequence([blendIt, wait, unBlend])
           thisnode.run(sequ)
       }
    
    private func makeTheBorder(_ labelNode: SKLabelNode, color: UIColor, posit: CGPoint, scaleTo: CGFloat, theborder: inout SKShapeNode){
           if let path =  labelNode.createBorderPathForText(labelNode.text!) {
               theborder = SKShapeNode()
               theborder.strokeColor = color
            if labelNode == yourCarrots{
                theborder.lineWidth = 10}
            else{theborder.lineWidth = 7}
               theborder.path = path
               theborder.position = posit
               theborder.zPosition = 3
               theborder.setScale(scaleTo)
               self.addChild(theborder)
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
            for touch in touches{
                let loca = touch.location(in: self)
                if sorryTabClosed{
                if exit.contains(loca) {
                    theBlender(runActionOn: exit)
                    let mainGame = MainGame(fileNamed: "MainGame")
                    let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                    self.scene?.view?.presentScene(mainGame!, transition: fadeAway)
                }
                if BlueRabbita.contains(loca){
                    select.run(SKAction.move(to: BlueRabbita.position, duration: 0))
                    selectedBunny = BlueRabbita
                }
                if OrangeRabbita.contains(loca){
                    select.run(SKAction.move(to: OrangeRabbita.position, duration: 0))
                    selectedBunny = OrangeRabbita
                }
                if RedRabbita.contains(loca){
                    select.run(SKAction.move(to: RedRabbita.position, duration: 0))
                    selectedBunny = RedRabbita
                }
                if GreenRabbita.contains(loca){
                    select.run(SKAction.move(to: GreenRabbita.position, duration: 0))
                    selectedBunny = GreenRabbita
                }
                if PinkRabbita.contains(loca){
                    select.run(SKAction.move(to: PinkRabbita.position, duration: 0))
                    selectedBunny = PinkRabbita
                }
                if GrayRabbita.contains(loca){
                    select.run(SKAction.move(to: GrayRabbita.position, duration: 0))
                    selectedBunny = GrayRabbita
                }
                if PurpleRabbita.contains(loca){
                    select.run(SKAction.move(to: PurpleRabbita.position, duration: 0))
                    selectedBunny = PurpleRabbita
                }
                if arrow.contains(loca){
                    let storeScene = StoreScene(fileNamed: "StoreScene")
                    let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                    self.scene?.view?.presentScene(storeScene!, transition: fadeAway)
                }
                }
                if sorryTab.contains(loca){
                    sorryTabClosed = true; sorryTab.removeFromParent();
                }
                var counter = -1
                for each in useOrPriceList{
                    counter += 1
                    if each.contains(loca) && sorryTabClosed{
                    if selectedBunny == useOrPriceDict[each]!{
                        if UserDefaults().dictionary(forKey: "Owned")![each.name!] as! Bool == true{
                            let oldBunny = bunnyBeingUsed
                            if selectedBunny != bunnyBeingUsed{
                                let oldBunnyString = UserDefaults().string(forKey: "bunnyType")
                                UserDefaults.standard.set(useOrPriceDict[each]!.name!, forKey: "bunnyType")
                                bunnyBeingUsed = selectedBunny
                                if bunnyList.contains(oldBunnyString!){
                                    createUseIcon(bunny: oldBunny!, justBoughtIt: false, num: nil)}
                                    usingTab.removeFromParent()
                                    createUsingTab(usePict: each, num: counter)
                                    UserDefaults.standard.set("StoreScene1", forKey: "StoreScene")
                                    selectRabbitaCol(bunny: selectedBunny!)
                                    }
                                }
                            else{
                              if UserDefaults().integer(forKey: "CarrotCount") >= bunnyPriceList[each.name!]!{
                                each.removeFromParent()
                                createUseIcon(bunny: selectedBunny!, justBoughtIt: true, num: counter)
                                var dict = UserDefaults().dictionary(forKey: "Owned")
                                dict![each.name!] = true
                                UserDefaults.standard.set(dict, forKey: "Owned")
                                let carrotCount = UserDefaults().integer(forKey: "CarrotCount")
                                let price:Int! = bunnyPriceList[each.name!]
                                let difference = carrotCount - price
                                UserDefaults.standard.set(difference, forKey: "CarrotCount")
                                yourCarrots.removeFromParent()
                                blackLine.removeFromParent()
                                makeYourCarrots()
                                }
                                else{createSorryTab(); sorryTabClosed = false}
                            }
                        }
                    }
                }
            }
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


  
