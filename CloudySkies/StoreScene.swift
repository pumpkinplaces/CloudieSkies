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



class StoreScene: SKScene, UICollectionViewDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?

    var use = SKLabelNode()
    var exit = SKLabelNode()
    var exitBorder = SKShapeNode()

    var storeBackground = SKSpriteNode()
    var rabbitaColor = UserDefaults().string(forKey: "RabbitaColor")
    
    var priceTag = SKSpriteNode()
    var Carrot = SKSpriteNode()
    var price = SKLabelNode()
    private var bunnyList:[String] = []
    var bunnyPriceList:[String:Int] = [:]
    var bunnyDictionary: [String: SKSpriteNode] = [:]
    var yourCarrots = SKLabelNode()
    var yourCarrotsBorder = SKShapeNode()
    var selectedBunny:SKSpriteNode?
    var blackLine = SKSpriteNode()

    var useOrPriceList:[SKSpriteNode] = []
    var useOrPriceDict:[SKSpriteNode:SKSpriteNode] = [:]
    
    var sorryTab = SKSpriteNode()
    var sorryLabel = SKLabelNode()
    var sorryNum = SKLabelNode()
    var sorryEnd = SKLabelNode()
    var close = SKSpriteNode()
    var sorryTabClosed = true
    var bunnyBeingUsed:SKSpriteNode?
    var inMovedToView = Bool()
    var getMoreCarrots = SKSpriteNode()
    var collectionView: UICollectionView!
    var collectionCount = 0
    var saveCollectionCount = 0
    var trackSavedCollectionCount = 0
    var usingCellName: String!
    var firstSelectedCell:CustomCell!
    var firstSelectedCellName: String!
    var selectedCellName: String!
    var selectedCellIndexPath: IndexPath!
    var usingIndexPath: IndexPath!
    var selectedCell: CustomCell?
    var sorryImage: UIImageView!
    var closeButton: UIButton!
    var previouslySelecrtedCell: CustomCell!
    var previousCell: CustomCell!
    var usingCell: CustomCell!
    var previouslyUsingCellIndePath: IndexPath!
    var savedFirstIndexPath: IndexPath!
    var calledScrollThingy = false
    var firstUsingPath: IndexPath?
    var selectedCellChanged = false
    var selectCellCalled = false
    

    var data = [CustomData(title: "BunnyName", image: #imageLiteral(resourceName: "Dock")), CustomData(title: "DarkBrownBunnyName", image: #imageLiteral(resourceName: "Heidi")), CustomData(title: "Bunny", image: #imageLiteral(resourceName: "Bunny1.png")), CustomData(title: "DarkBrownBunny", image: #imageLiteral(resourceName: "DarkBrownBunny1")), CustomData(title: "BunnyUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "DarkBrownBunnyUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "BeigeBunnyName", image: #imageLiteral(resourceName: "Chloe")), CustomData(title: "GrayBunnyName", image: #imageLiteral(resourceName: "Gus")), CustomData(title: "BeigeBunny", image: UIImage(named: "BeigeBunny1")!), CustomData(title: "GrayBunny", image: #imageLiteral(resourceName: "GrayBunny1")), CustomData(title: "BeigeBunnyUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "GrayBunnyUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "BrownRabbitName", image: #imageLiteral(resourceName: "Casey")), CustomData(title: "BlackBunnyLightName", image: #imageLiteral(resourceName: "Klaus")), CustomData(title: "BrownRabbit", image: #imageLiteral(resourceName: "BrownRabbit1")), CustomData(title: "BlackBunnyLight", image: #imageLiteral(resourceName: "BlackBunnyLight1")), CustomData(title: "BrownRabbitUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "BlackBunnyLightUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "LightBrownBunnyName", image:#imageLiteral(resourceName: "Benji")), CustomData(title: "SpottedBlackBunnyName", image: #imageLiteral(resourceName: "Felicity")), CustomData(title: "LightBrownBunny", image: #imageLiteral(resourceName: "LightBrownBunny1")), CustomData(title: "SpottedBlackBunny", image: #imageLiteral(resourceName: "SpottedBlackBunny1")),CustomData(title: "LightBrownBunnyUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "SpottedBlackBunnyUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "JoshieName", image: #imageLiteral(resourceName: "PapaJoshie")), CustomData(title: "JoyceName", image:#imageLiteral(resourceName: "GrandmaJoyce")), CustomData(title: "Joshie", image: #imageLiteral(resourceName: "Joshie1")), CustomData(title: "Joyce", image: #imageLiteral(resourceName: "Joyce1")),  CustomData(title: "JoshieUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "JoyceUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "JasonName", image: #imageLiteral(resourceName: "JasonPeck")), CustomData(title: "RabbitaName", image: #imageLiteral(resourceName: "Marshmallow")), CustomData(title: "Jason", image: #imageLiteral(resourceName: "Jason1")), CustomData(title: "Rabbita", image: #imageLiteral(resourceName: "Rabbita1")), CustomData(title: "JasonUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "RabbitaUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "RedRabbitaName", image: #imageLiteral(resourceName: "Cherry")), CustomData(title: "BlueRabbitaName", image: #imageLiteral(resourceName: "Spencer")), CustomData(title: "RedRabbita", image: #imageLiteral(resourceName: "RedRabbita1")), CustomData(title: "BlueRabbita", image: #imageLiteral(resourceName: "BlueRabbita1")), CustomData(title: "RedRabbitaUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "BlueRabbitaUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "OrangeRabbitaName", image: #imageLiteral(resourceName: "Ginger")), CustomData(title: "PurpleRabbitaName", image: #imageLiteral(resourceName: "Tulip")), CustomData(title: "OrangeRabbita", image: #imageLiteral(resourceName: "OrangeRabbita1")), CustomData(title: "PurpleRabbita", image: #imageLiteral(resourceName: "PurpleRabbita1")), CustomData(title: "OrangeRabbitaUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "PurpleRabbitaUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "YellowRabbitaName", image: #imageLiteral(resourceName: "Katie")), CustomData(title: "PinkRabbitaName", image: #imageLiteral(resourceName: "Paris")), CustomData(title: "YellowRabbita", image: #imageLiteral(resourceName: "YellowRabbita1")), CustomData(title: "PinkRabbita", image: #imageLiteral(resourceName: "PinkRabbita1")), CustomData(title: "YellowRabbitaUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "PinkRabbitaUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "GreenRabbitaName", image: #imageLiteral(resourceName: "Lucky")), CustomData(title: "BabyBlueRabbitaName", image: #imageLiteral(resourceName: "Scooter")), CustomData(title: "GreenRabbita", image: #imageLiteral(resourceName: "GreenBunny-1")), CustomData(title: "BabyBlueRabbita", image: #imageLiteral(resourceName: "BabyBlueRabbita1")),  CustomData(title: "GreenRabbitaUse", image: #imageLiteral(resourceName: "Use1")), CustomData(title: "BabyBlueRabbitaUse", image: #imageLiteral(resourceName: "Use1"))]


    
    
    var soundOff = SKSpriteNode(), soundOn = SKSpriteNode()
    
   
    override func didMove(to view: SKView) {
    // Get label node from scene and store it for use later
        inMovedToView = true
        setUpStore()
        resetRabbita()
        firstSelectedCellName = UserDefaults().string(forKey: "bunnyType")
        addPriceTags()
        setUpStoreSong()
        addNotifications()
        makeCollectionView()
    }
    
    private func addPriceTags(){
        var counter = 0
        let dataCount =  data.count - 1
        for each in 0...dataCount{
            if data[each].title.hasSuffix("Use"){
                let thetitle =  data[each].title
                let lastindex = thetitle.endIndex
                let prefix = thetitle.index(lastindex, offsetBy: -4)
                let bunnyName:String =  String(thetitle[thetitle.startIndex...prefix])
                if UserDefaults().dictionary(forKey: "Owned")![bunnyName] as! Bool == false{
                    if StorePrices.bunnyPriceList[bunnyName] == 400{
                    data[each] = CustomData(title: bunnyName + "Price", image: #imageLiteral(resourceName: "PriceTag-1"))
                    }
                    else{data[each] = CustomData(title: bunnyName + "Price", image: #imageLiteral(resourceName: "PriceTag300"))}
                }
            }
            counter += 1
        }
    }
    

    private func makeCollectionView(){
        collectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellWidth: CGFloat = 115
        let doubleWidthDiff: CGFloat = 2 * cellWidth
            let distIn = self.frame.width/4 - 57.5
        let min = self.frame.width - doubleWidthDiff - (distIn * 2)
        layout.minimumInteritemSpacing = min
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
            cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
        }()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        self.view?.addSubview(collectionView)
        let distDown = exit.position.y - exit.frame.height/2 - 10
        let distUp = self.frame.height/2 - distDown
        let yourCarrotsYPos = yourCarrots.position.y + yourCarrots.frame.height + 10
        let bottomsUp = self.frame.height/2 + yourCarrotsYPos
        let distIn = self.frame.width/4 - 57.5
        collectionView.topAnchor.constraint(equalTo: self.view!.topAnchor, constant: distUp).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: distIn).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view!.trailingAnchor, constant: -distIn).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view!.bottomAnchor, constant: -bottomsUp).isActive = true
    }
    
    private func setUpStore(){
        storeBackground = SKSpriteNode(imageNamed: "StoreBackground2")
        storeBackground.setScale(3.5)
        storeBackground.position = CGPoint.zero
        storeBackground.zPosition = 0
        self.addChild(storeBackground)
        
        exit = SKLabelNode(text: "Exit")
        exit.fontName = "Noteworthy-Bold"
        exit.fontSize = 30
        exit.fontColor = UIColor.black
        exit.zPosition = 3
        exit.position = CGPoint(x: self.frame.width/2 - 50, y: self.frame.height/2 - 55)
         self.addChild(exit)
        makeTheBorder(exit, color: UIColor.white, posit: CGPoint(x: self.frame.width/2 - 75, y: self.frame.height/2 - 55), scaleTo: 1, theborder: &exitBorder)
        exitBorder.zPosition = 2
        makeYourCarrots()
    }
    
    private func setUpStoreSong(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true{makeSoundOnButton()
            if !StoreSong.storeSongPlaying{
                NotificationCenter.default.post(name: Notification.Name(rawValue: "PlayBackgroundSound"), object: self)
            StoreSong.storeSongPlaying = true
            }
        }
        else{makeSoundOffButton()
        }
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
    
  private func makeSoundOffButton(){
       soundOff = SKSpriteNode(imageNamed: "SoundOffButton")
       soundOff.name = "SoundOff"
       soundOff.position =  CGPoint(x: -self.frame.width/2 + 50, y: self.frame.height/2 - 35)
       soundOff.zPosition = 9
       soundOff.setScale(0.12)
       self.addChild(soundOff)
    }
   
  
    private func makeSoundOnButton(){
        soundOn = SKSpriteNode(imageNamed: "SoundButton")
        soundOn.name = "SoundOn"
        soundOn.position = CGPoint(x: -self.frame.width/2 + 50, y: self.frame.height/2 - 35)
        soundOn.zPosition = 9
        soundOn.setScale(0.12)
        self.addChild(soundOn)
   }
    
    
    private func addNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(pauseEverything(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playNow(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func removeNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc private func pauseEverything(_ application: UIApplication){
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PauseBackgroundSound"), object: self)
        self.isPaused = true
       }
       
    @objc private func playNow(_ application: UIApplication){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true{
            NotificationCenter.default.post(name: Notification.Name(rawValue: "ResumeBackGroundSound"), object: self)
        }
           self.isPaused = false
    }
    
    private func rememberSoundSettings(_ soundPic: SKSpriteNode){
        if soundPic.name == "SoundOff"{
            UserDefaults.standard.set(true, forKey: "SoundOffOrOn")}
        else if soundPic.name == "SoundOn"{UserDefaults.standard.set(false, forKey: "SoundOffOrOn")}
    }
    
    
    private func resetRabbita(){
        if UserDefaults().string(forKey: "RabbitaColor") != "" {
            let string = UserDefaults().string(forKey: "RabbitaColor")! + "Rabbita"
            UserDefaults.standard.set(string, forKey: "bunnyType")
        }
    }
    
    
    private func theBlender<T: SKNode>(runActionOn thisnode: T){
     let blendIt = SKAction.colorize(with: UIColor.black, colorBlendFactor: 0.4, duration: 0.2)
        thisnode.run(blendIt)
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

    private func createSorryTab(name: String){
        sorryTabClosed = false
        sorryImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 2 * (self.frame.height - self.frame.height/3), height: 2 * (self.frame.height - self.frame.height/3)))
        sorryImage.translatesAutoresizingMaskIntoConstraints = false
        sorryImage.contentMode = .scaleToFill
        sorryImage.clipsToBounds = true
        sorryImage.image = #imageLiteral(resourceName: "SorrySquare")
        sorryImage.isUserInteractionEnabled = true
        
        collectionView.addSubview(sorryImage)
        let boxHeight = self.frame.height - (2 * self.frame.height/3)
        let width = self.frame.width
        let heightDifference = width - boxHeight
        let halfHeightDiff = heightDifference / 2
        sorryImage.topAnchor.constraint(equalTo: self.view!.topAnchor, constant: self.frame.height/3).isActive = true
        sorryImage.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: halfHeightDiff).isActive = true
        sorryImage.trailingAnchor.constraint(equalTo: self.view!.trailingAnchor, constant: -halfHeightDiff).isActive = true
        sorryImage.bottomAnchor.constraint(equalTo: self.view!.bottomAnchor, constant: -self.frame.height/3).isActive = true
        
    
        let priceDifference = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        sorryImage.addSubview(priceDifference)
        priceDifference.translatesAutoresizingMaskIntoConstraints = false
        priceDifference.contentMode = .scaleToFill
        priceDifference.clipsToBounds = true
        priceDifference.isUserInteractionEnabled = true
        let difference: String! = String(StorePrices.bunnyPriceList[name]! - UserDefaults().integer(forKey: "CarrotCount"))
        priceDifference.text = difference
        priceDifference.textColor = UIColor.white
        priceDifference.font = UIFont(name: "Noteworthy-Bold", size: 30)
        priceDifference.center = sorryImage.center
        priceDifference.textAlignment = .center
        priceDifference.backgroundColor = UIColor.clear.withAlphaComponent(0)
        priceDifference.topAnchor.constraint(equalTo: self.view!.topAnchor, constant: self.frame.height/2 - 40).isActive = true
        priceDifference.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: self.frame.width/2 - 40).isActive = true
        priceDifference.trailingAnchor.constraint(equalTo: self.view!.trailingAnchor, constant: -self.frame.width/2 + 40).isActive = true
        priceDifference.bottomAnchor.constraint(equalTo: self.view!.bottomAnchor, constant: -self.frame.height/2 + 40).isActive = true
        
        closeButton = UIButton()
        sorryImage.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = UIColor.clear.withAlphaComponent(0)
        closeButton.contentMode = .scaleToFill
        closeButton.clipsToBounds = true
        closeButton.setImage(UIImage(named: "closeSorrySquare"), for: .normal)
        closeButton.adjustsImageWhenHighlighted = true
        closeButton.addTarget(self, action: #selector(self.closeTheSquare), for: .touchUpInside)
        closeButton.setTitle("closeButton", for: .normal)
        closeButton.isUserInteractionEnabled = true
        closeButton.topAnchor.constraint(equalTo: sorryImage.topAnchor, constant: 15).isActive = true
        closeButton.widthAnchor.constraint(equalTo: sorryImage.widthAnchor, multiplier: 0.2).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: sorryImage.trailingAnchor, constant: -20).isActive = true
        closeButton.heightAnchor.constraint(equalTo: sorryImage.heightAnchor, multiplier: 0.15).isActive = true
    }
    
    @IBAction func closeTheSquare(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.closeButton.removeTarget(self, action: #selector(self.closeTheSquare), for: .touchUpInside)
            self.sorryImage.removeFromSuperview()
            self.sorryTabClosed = true
    })
    }
    
    
    private func hasRabbitaColor(name: String){
        switch name {
        case "RedRabbita": UserDefaults.standard.set("Red", forKey: "RabbitaColor")
        case "OrangeRabbita": UserDefaults.standard.set("Orange", forKey: "RabbitaColor")
        case "YellowRabbita": UserDefaults.standard.set("Yellow", forKey: "RabbitaColor")
        case "GreenRabbita": UserDefaults.standard.set("Green", forKey: "RabbitaColor")
        case "BlueRabbita": UserDefaults.standard.set("Blue", forKey: "RabbitaColor")
        case "PurpleRabbita": UserDefaults.standard.set("Purple", forKey: "RabbitaColor")
        case "PinkRabbita": UserDefaults.standard.set("Pink", forKey: "RabbitaColor")
        case "BabyBlueRabbita": UserDefaults.standard.set("BabyBlue", forKey: "RabbitaColor")
        default:
            UserDefaults.standard.set("", forKey: "RabbitaColor")
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
                //if collectionView.backgroundColor = UIColor.white
                if sorryTabClosed{
                if exit.contains(loca) {
                    collectionView.removeFromSuperview()
                    removeNotifications()
                    theBlender(runActionOn: exit)
                    StoreSong.stoppedSongForMain = true
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self)
                    StoreSong.storeSongPlaying = false
                    let mainGame = MainGame(fileNamed: "MainGame")
                    let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                    self.scene?.view?.presentScene(mainGame!, transition: fadeAway)
                }
                }
                if let _ = soundOn.parent{
                    if soundOn.contains(loca){
                        rememberSoundSettings(soundOn)
                        StoreSong.stoppedSongForMain = false
                        StoreSong.storeSongPlaying = false
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "StopBackgroundSound"), object: self)
                        soundOn.removeFromParent()
                        makeSoundOffButton()
                    }
                }
                else if let _ = soundOff.parent{
                    if soundOff.contains(loca){
                        rememberSoundSettings(soundOff)
                        StoreSong.storeSongPlaying = true
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "PlayBackgroundSound"), object: self)
                        soundOff.removeFromParent()
                        makeSoundOnButton()
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
        if !calledScrollThingy{
            if Views.initialScrollDone{
                let savedIndexPathRow: Int! = UserDefaults().integer(forKey: "IndexPathRow")
                collectionView.scrollToItem(at: [0, savedIndexPathRow], at: UICollectionView.ScrollPosition.centeredVertically, animated: true)
                calledScrollThingy = true
                Views.initialScrollDone = false
            }
        }
    }
}


extension StoreScene: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.data[indexPath.row]
        let dataTitle = cell.data!.title
        if dataTitle == firstSelectedCellName{
            firstSelectedCellName = ""
            selectedCellName = dataTitle
            selectedCell = cell
            usingCellName = dataTitle
            selectedCellIndexPath = indexPath
            usingIndexPath = [indexPath.section, indexPath.row + 2]
            firstUsingPath = usingIndexPath
        }
        if firstUsingPath != nil{
            if let cellInView = collectionView.cellForItem(at: firstUsingPath!){
                let useCell = cellInView as! CustomCell
                usingCell = useCell
                firstUsingPath = nil
                useCell.data = CustomData(title: "Using", image: #imageLiteral(resourceName: "Using-1"))
            }
        }
        
        if selectedCellName == dataTitle {selectedCell = cell; cell.backgroundColor = UIColor.white.withAlphaComponent(0.35)}
        else {cell.backgroundColor = UIColor.clear.withAlphaComponent(0)}
       
        if dataTitle.hasSuffix("Use"){
            let lastindex = dataTitle.endIndex
            let prefix = dataTitle.index(lastindex, offsetBy: -4)
            let bunnyName:String = String(dataTitle[dataTitle.startIndex...prefix])
            if bunnyName == usingCellName{
                usingCell = cell
                cell.data = CustomData(title: "Using", image: #imageLiteral(resourceName: "Using-1"))
            }
            else{cell.data = CustomData(title: bunnyName + "Use", image: #imageLiteral(resourceName: "Use1"))}
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout CollectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionCount < 4{
            if collectionCount == 0 || collectionCount == 1{
                collectionCount += 1
                return CGSize(width: 115, height: 44.8)
            }
            else{collectionCount += 1
                saveCollectionCount = collectionCount - 2
                return CGSize(width: 115, height: 115)
            }
        }
        else{
         if saveCollectionCount == collectionCount || saveCollectionCount + 1 == collectionCount{
            collectionCount += 1
            return CGSize(width: 115, height: 115)
         }
        else{
            collectionCount += 1
            trackSavedCollectionCount = saveCollectionCount
            if trackSavedCollectionCount + 6 == collectionCount{
                saveCollectionCount = collectionCount}
            return CGSize(width: 115, height: 44.8)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if sorryTabClosed{
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCell
        let dataTitle = cell.data!.title
        if let _ = UserDefaults().dictionary(forKey: "Owned")![dataTitle] {
            if selectedCell != nil{
                    previouslySelecrtedCell = selectedCell
                if let cellInView = collectionView.cellForItem(at: selectedCellIndexPath) {
                    let oldCell = cellInView
                    oldCell.backgroundColor = UIColor.clear.withAlphaComponent(0)
                }
                else if previouslySelecrtedCell != nil{
                    previouslySelecrtedCell!.backgroundColor = UIColor.clear.withAlphaComponent(0)
                }
                selectedCellName = dataTitle
                selectedCell = cell
                selectedCellIndexPath = indexPath
                cell.backgroundColor = UIColor.white.withAlphaComponent(0.35)
            }
        }
        if dataTitle.hasSuffix("Use") && selectedCellName != nil{
            let lastindex = dataTitle.endIndex
            let prefix = dataTitle.index(lastindex, offsetBy: -4)
            let bunnyName:String = String(dataTitle[dataTitle.startIndex...prefix])
            if selectedCellName == bunnyName{
                previousCell = usingCell
            if let onScreen = collectionView.cellForItem(at: usingIndexPath){
                   let preCell = onScreen as! CustomCell
                    preCell.data = CustomData(title: usingCellName + "Use", image: #imageLiteral(resourceName: "Use1"))
                }
            else if usingCell != nil{
                if usingCell.data!.title == "Using"{
                    usingCell.data = CustomData(title: usingCellName + "Use", image: #imageLiteral(resourceName: "Use1"))
                }
            }
                usingCellName = bunnyName
                
                usingIndexPath = indexPath
                usingCell = cell
                cell.data = CustomData(title: "Using", image: #imageLiteral(resourceName: "Using-1"))
                UserDefaults.standard.set(bunnyName, forKey: "bunnyType")
                hasRabbitaColor(name: selectedCellName)
                UserDefaults.standard.set(indexPath.row, forKey: "IndexPathRow")
            }
        }
        if dataTitle.hasSuffix("Price") && selectedCellName != nil{
            let lastindex = dataTitle.endIndex
            let prefix = dataTitle.index(lastindex, offsetBy: -6)
            let bunnyName:String = String(dataTitle[dataTitle.startIndex...prefix])
            if bunnyName == selectedCellName{
                if UserDefaults().integer(forKey: "CarrotCount") >= StorePrices.bunnyPriceList[selectedCellName]!{
                    cell.data = CustomData(title: selectedCellName + "Use", image: #imageLiteral(resourceName: "Use1"))
                    self.data[indexPath.row] = cell.data!
                    var carrotCount = UserDefaults().integer(forKey: "CarrotCount")
                    carrotCount -= StorePrices.bunnyPriceList[selectedCellName]!
                    UserDefaults.standard.set(carrotCount, forKey: "CarrotCount")
                    yourCarrots.removeFromParent()
                    blackLine.removeFromParent()
                    makeYourCarrots()
                    var dict = UserDefaults().dictionary(forKey: "Owned")
                    dict![selectedCellName] = true
                    UserDefaults.standard.set(dict, forKey: "Owned")
                }
                else{
                    createSorryTab(name: selectedCellName)
                }
                }
            }
        }
    }
}


class CustomCell: UICollectionViewCell{

    fileprivate let imageView = UIImageView()
    var data: CustomData? {
        didSet{
            guard let data = data else {return}
            imageView.image = data.image
        }
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct CustomData{
    var title: String
    var image: UIImage
}


