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



class StoreScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?

    var Bunny = SKSpriteNode()
    var BrownRabbit = SKSpriteNode()
    var LightBrownBunny = SKSpriteNode()
    var DarkBrownBunny = SKSpriteNode()
    var Rabbita = SKSpriteNode()
    var YellowRabbita = SKSpriteNode()
    var Shiny = SKSpriteNode()
    var BeigeBunny = SKSpriteNode()
    
    var useSquare = SKSpriteNode()
    var use = SKLabelNode()
    var exit = SKLabelNode()
    var exitBorder = SKShapeNode()

    var using = SKLabelNode()
    var usingTab = SKSpriteNode()
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
    var selectedBunny:SKSpriteNode?
    var blackLine = SKSpriteNode()

    var useOrPriceList:[SKSpriteNode] = []
    var useOrPriceDict:[SKSpriteNode:SKSpriteNode] = [:]
    var arrow = SKSpriteNode()
    
    var sorryTab = SKSpriteNode()
    var sorryLabel = SKLabelNode()
    var sorryNum = SKLabelNode()
    var sorryEnd = SKLabelNode()
    var close = SKLabelNode()
    var sorryTabClosed = true
    var bunnyBeingUsed:SKSpriteNode?
    var inMovedToView = Bool()
    var getMoreCarrots = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
    // Get label node from scene and store it for use later
        //self.backgroundColor = UIColor(red: 41, green: 54, blue: 43)
        inMovedToView = true
        bunnyBeingUsed = Bunny
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
        else{select.position = CGPoint(x: 2 * self.frame.width, y: 0); selectedBunny = nil}
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
        arrow.position = CGPoint(x: 0, y: 5 * self.frame.height/10 - self.frame.height/20 - 11)
        arrow.zPosition = 3
        self.addChild(arrow)
    }
    
    private func setUpAnimals(){
        let tenthHeight = self.frame.height/10; let tenthHeightMid = self.frame.height/20
        let halfiwdthMid = self.frame.width/2 - self.frame.width/4
        Bunny = SKSpriteNode(imageNamed: "Bunny1")
        Bunny.name = "Bunny"
        Bunny.zPosition = 3
        Bunny.position = CGPoint(x: -halfiwdthMid, y: 4 * tenthHeight - tenthHeightMid)
        Bunny.size = CGSize(width: 93, height: 93)
        self.addChild(Bunny)
        bunnyList.append("Bunny")
        bunnyDictionary["Bunny"] = Bunny
        bunnyPriceList["Bunny"] = 0
        
        BeigeBunny = SKSpriteNode(imageNamed: "BeigeBunny1")
        BeigeBunny.name = "BeigeBunny"
        BeigeBunny.zPosition = 3
        BeigeBunny.position = CGPoint(x: -halfiwdthMid, y: 2 * tenthHeight - tenthHeightMid)
        BeigeBunny.size = CGSize(width: 120, height: 120)
        self.addChild(BeigeBunny)
        bunnyList.append("BeigeBunny")
        bunnyDictionary["BeigeBunny"] = BeigeBunny
        bunnyPriceList["BeigeBunny"] = 1000
        
        BrownRabbit = SKSpriteNode(imageNamed: "BrownRabbit1")
        BrownRabbit.name = "BrownRabbit"
        BrownRabbit.zPosition = 3
        BrownRabbit.position = CGPoint(x: -halfiwdthMid, y: -tenthHeightMid)
        BrownRabbit.size = CGSize(width: 120, height: 120)
        self.addChild(BrownRabbit)
        bunnyList.append("BrownRabbit")
        bunnyDictionary["BrownRabbit"] = BrownRabbit
        bunnyPriceList["BrownRabbit"] = 1
        
        YellowRabbita = SKSpriteNode(imageNamed: "Rabbita1")
        YellowRabbita.name = "YellowRabbita"
        YellowRabbita.run(SKAction.colorize(with: UIColor(red: 247, green: 240, blue: 22), colorBlendFactor: 0.25, duration: 0))
        YellowRabbita.zPosition = 3
        YellowRabbita.position = CGPoint(x: halfiwdthMid, y: -2 * tenthHeight - tenthHeightMid)
        YellowRabbita.size = CGSize(width: 120, height: 120)
        self.addChild(YellowRabbita)
        bunnyList.append("YellowRabbita")
        bunnyDictionary["YellowRabbita"] = YellowRabbita
        bunnyPriceList["YellowRabbita"] = 500
        
        LightBrownBunny = SKSpriteNode(imageNamed: "LightBrownBunny1")
        LightBrownBunny.name = "LightBrownBunny"
        LightBrownBunny.zPosition = 3
        LightBrownBunny.position = CGPoint(x: -halfiwdthMid, y: -2 * tenthHeight - tenthHeightMid)
        LightBrownBunny.size = CGSize(width: 120, height: 120)
        self.addChild(LightBrownBunny)
        bunnyList.append("LightBrownBunny")
        bunnyDictionary["LightBrownBunny"] = LightBrownBunny
        bunnyPriceList["LightBrownBunny"] = 4
        
        DarkBrownBunny = SKSpriteNode(imageNamed: "DarkBrownBunny1")
        DarkBrownBunny.name = "DarkBrownBunny"
        DarkBrownBunny.zPosition = 3
        DarkBrownBunny.position = CGPoint(x: halfiwdthMid, y: 4 * tenthHeight - tenthHeightMid)
        DarkBrownBunny.size = CGSize(width: 120, height: 120)
        self.addChild(DarkBrownBunny)
        bunnyList.append("DarkBrownBunny")
        bunnyDictionary["DarkBrownBunny"] = DarkBrownBunny
        bunnyPriceList["DarkBrownBunny"] = 5
        
        Rabbita = SKSpriteNode(imageNamed: "Rabbita1")
        Rabbita.name = "Rabbita"
        Rabbita.zPosition = 3
        Rabbita.position = CGPoint(x: halfiwdthMid, y: 2 * tenthHeight - tenthHeightMid)
        Rabbita.size = CGSize(width: 120, height: 120)
        self.addChild(Rabbita)
        bunnyList.append("Rabbita")
        bunnyDictionary["Rabbita"] = Rabbita
        bunnyPriceList["Rabbita"] = 500
        
        Shiny = SKSpriteNode(imageNamed: "Shiny1")
        Shiny.name = "Shiny"
        Shiny.zPosition = 3
        Shiny.position = CGPoint(x: halfiwdthMid, y: -tenthHeightMid)
        Shiny.size = CGSize(width: 120, height: 120)
        self.addChild(Shiny)
        bunnyList.append("Shiny")
        bunnyDictionary["Shiny"] = Shiny
        bunnyPriceList["Shiny"] = 1000
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
        sorryLabel.fontSize = 35
        sorryLabel.position = CGPoint(x: 0, y: 75)
        sorryLabel.zPosition = 7
        sorryLabel.fontColor = UIColor(red: 218, green: 211, blue: 244)
        sorryTab.addChild(sorryLabel)
        
        let difference = bunnyPriceList[selectedBunny!.name!]! - UserDefaults().integer(forKey: "CarrotCount")
        let diffString: String! = String(difference)
        sorryNum = SKLabelNode(text: diffString)
        sorryNum.setScale(0.8)
        sorryNum.fontName = "Noteworthy-Bold"
        sorryNum.fontSize = 35
        sorryNum.position = CGPoint(x: 0, y: 25)
        sorryNum.zPosition = 7
        sorryNum.fontColor = UIColor.white
        sorryTab.addChild(sorryNum)
        
        sorryEnd = SKLabelNode(text: "more carrots!")
        sorryEnd.setScale(0.8)
        sorryEnd.fontName = "Noteworthy-Bold"
        sorryEnd.fontSize = 35
        sorryEnd.position = CGPoint(x: 0, y: -20)
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
        close.fontColor = UIColor(red: 239, green: 235, blue: 252)
        sorryTab.addChild(close)
        
        getMoreCarrots = SKSpriteNode(imageNamed: "GetMoreCarrots")
        getMoreCarrots.setScale(0.35)
        getMoreCarrots.position = CGPoint(x: 0, y: -85)
        getMoreCarrots.zPosition = 7
        sorryTab.addChild(getMoreCarrots)
    }
    
    
    private func resetRabbita(){
        if UserDefaults().string(forKey: "RabbitaColor") != "" {
            let string = UserDefaults().string(forKey: "RabbitaColor")! + "Rabbita"
            UserDefaults.standard.set(string, forKey: "bunnyType")
        }
    }
    
    private func selectPosition(animationType: String){
        switch animationType{
        case "Bunny": select.position = Bunny.position; selectedBunny = Bunny; bunnyBeingUsed = Bunny
        case "Rabbita": select.position = Rabbita.position; selectedBunny = Rabbita; bunnyBeingUsed = Rabbita
        case "BrownRabbit": select.position = BrownRabbit.position; selectedBunny = BrownRabbit; bunnyBeingUsed = BrownRabbit
        case "BeigeBunny": select.position = BeigeBunny.position; selectedBunny = BeigeBunny; bunnyBeingUsed = BeigeBunny
        case "YellowRabbita": select.position = YellowRabbita.position; selectedBunny = YellowRabbita; bunnyBeingUsed = YellowRabbita
        case "Shiny": select.position = Shiny.position; selectedBunny = Shiny; bunnyBeingUsed = Shiny
        case "LightBrownBunny": select.position = LightBrownBunny.position; selectedBunny = LightBrownBunny; bunnyBeingUsed = LightBrownBunny
        case "DarkBrownBunny": select.position = DarkBrownBunny.position; selectedBunny = DarkBrownBunny; bunnyBeingUsed = DarkBrownBunny
        default: break
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
                if BeigeBunny.contains(loca){
                    select.run(SKAction.move(to: BeigeBunny.position, duration: 0))
                    selectedBunny = BeigeBunny
                }
                if Bunny.contains(loca){
                    select.run(SKAction.move(to: Bunny.position, duration: 0))
                    selectedBunny = Bunny
                }
                if BrownRabbit.contains(loca){
                    select.run(SKAction.move(to: BrownRabbit.position, duration: 0))
                    selectedBunny = BrownRabbit
                }
                if YellowRabbita.contains(loca){
                    select.run(SKAction.move(to: YellowRabbita.position, duration: 0))
                    selectedBunny = YellowRabbita
                }
                if LightBrownBunny.contains(loca){
                    select.run(SKAction.move(to: LightBrownBunny.position, duration: 0))
                    selectedBunny = LightBrownBunny
                }
                if Shiny.contains(loca){
                    select.run(SKAction.move(to: Shiny.position, duration: 0))
                    selectedBunny = Shiny
                }
                if DarkBrownBunny.contains(loca){
                    select.run(SKAction.move(to: DarkBrownBunny.position, duration: 0))
                    selectedBunny = DarkBrownBunny
                }
                if Rabbita.contains(loca){
                    select.run(SKAction.move(to: Rabbita.position, duration: 0))
                    selectedBunny = Rabbita
                }
                if arrow.contains(loca){
                    let storeScene1 = StoreScene1(fileNamed: "StoreScene1")
                    let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                    self.scene?.view?.presentScene(storeScene1!, transition: fadeAway)
                }
                }
                if close.contains(loca){
                    sorryTabClosed = true; sorryTab.removeFromParent();
                }
                if getMoreCarrots.contains(loca){
                    theBlender(runActionOn: getMoreCarrots)
                    let mainGame = MainGame(fileNamed: "MainGame")
                    let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                    self.scene?.view?.presentScene(mainGame!, transition: fadeAway)
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
                                        UserDefaults.standard.set("StoreScene", forKey: "StoreScene")
                                        if selectedBunny == YellowRabbita{UserDefaults.standard.set("Yellow", forKey: "RabbitaColor")}
                                        else{UserDefaults.standard.set("", forKey: "RabbitaColor")}
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


  
