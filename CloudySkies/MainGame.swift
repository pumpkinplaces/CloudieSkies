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
import AVFoundation
import UIKit
//import UIKit.UIGestureRecognizerSubclass
 
struct PhysicsCategory{
    static let Bunny:UInt32 = 0x1 << 3
    static let Poo:UInt32 = 0x1 << 2
    static let AirPlane: UInt32 = 0x1 << 1
    static let Lightening: UInt32 = 0x1 << 0
}

var bunnyFellSound: AVAudioPlayer?
var bunnyDidntHop: AVAudioPlayer?
var planeHitSound: AVAudioPlayer?
var blackCloudsound:AVAudioPlayer?
var planeSound:AVAudioPlayer?
var splat: AVAudioPlayer?
var lighteningSound: AVAudioPlayer?
var rainSound: AVAudioPlayer?


class MainGame: SKScene, SKPhysicsContactDelegate {
   
    private var spinnyNode : SKShapeNode?
    var RabbitTextureArray = [SKTexture]()
    var BirdTextureArray = [SKTexture]()
    var BirdTextureAtlas = SKTextureAtlas()
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
    var upSwipe = UISwipeGestureRecognizer()
    var bunnyxScale = CGFloat()
    
    var Cloud1:SKSpriteNode? = SKSpriteNode()
    var Cloud2: SKSpriteNode? = SKSpriteNode()
    var Cloud3:SKSpriteNode? = SKSpriteNode()
    let xdistance: CGFloat = 5
    let ydistance:CGFloat = 40
    var cloudheight = CGFloat()
    var countTheTriples:[Int: SKNode?] = [Int(): SKNode()]
    var listOfChildren: [Int:[SKSpriteNode?]] = [Int():[SKSpriteNode()]]
    var triplesChildren: [SKSpriteNode?] = [SKSpriteNode()]
    
    var score: SKLabelNode!
    var numberOfHops: SKLabelNode!
    
    var bunnysdone = Bool()
    var resetCalled = false
    var restart: SKSpriteNode!
    var scorenum:Int = 0
    var sorryTryAgain: SKSpriteNode!
    
    var cloudMoveTime:CGFloat = 0.005
    var cloudDelayTime = 0.59
    var bunnyHopTime = 0.482
    var bestScore = UserDefaults().integer(forKey: "highscore")
    var endGameFadeInTime:Double = 0.43
    var mostHops: SKLabelNode!
    var highScoreText: SKLabelNode!
    var playAgain: SKSpriteNode!
    var mainMenu: SKSpriteNode!
    var carrots: SKLabelNode!
    var carrotsNum = Int()
    var savedCarrotScore = Int()
    
    var listOfSkies:[SKSpriteNode] = []
    var blueSky = SKSpriteNode()
    var bluishBrownSky = SKSpriteNode()
    var redOrangeYellow = SKSpriteNode()
    var bluishGrey = SKSpriteNode()
    var original = SKSpriteNode()
    var purpleSky = SKSpriteNode()
    var purpleBlack = SKSpriteNode()
    var redOrangeYellowDark = SKSpriteNode()
    var pinkAndBlue = SKSpriteNode()
    var northernLights = SKSpriteNode()
    var darkBlue = SKSpriteNode()
    var blackBlue = SKSpriteNode()
    var brightBlueSky = SKSpriteNode()
    var brightBluishBrown = SKSpriteNode()
    var rainbow = SKSpriteNode()
    var pinkAndGreen = SKSpriteNode()
    var greenAndYellow = SKSpriteNode()
    
    var listOfCloudColors:[UIColor] = []
    var listOfHopsFontColors:[UIColor] = []
    
    var skyTimeWait = Int()
    var savedSky = Int()
    var oldSky = Int()
    var savedScore = Int()
    var colorCloudBlendFactor = CGFloat()
    
    var combinedScore: SKLabelNode!
    var combinedScoreNum = Int()
    var highestCombinedScore = UserDefaults().integer(forKey: "highestTotalScore")
    var highestCombinedScoreText: SKLabelNode!
    
    var carrot:SKSpriteNode? = SKSpriteNode()
    var listOfCarrots:[Int: [SKSpriteNode?]] = [:]
    var playButton = SKSpriteNode()
    var pauseButton = SKSpriteNode()
    var pauseCounter = false
    
    var soundOnButton = SKSpriteNode()
    var soundOffButton = SKSpriteNode()
    var soundTrack = true
    var bunnyMoveWithSound = true
    var pausedAfterOpening = false
    var gameIsActive = false
    var midnight = SKSpriteNode()
    var blackCloudList:[Int: [SKSpriteNode?]] = [:]

    var airPlane: SKSpriteNode?
    var planeCount = Int()
    var airPlaneXScale = CGFloat()
    var lowerPlaneBound = 10
    var upperPlaneBound = 15
    var planeSoundPaused = false
    
    var RabbitTextureAtlas = SKTextureAtlas()
    var bunnyAnimation = UserDefaults().string(forKey: "bunnyType")
    var smallBunnyImage: SKSpriteNode?
    var miniCloud:SKSpriteNode?
    
    var Bird = SKSpriteNode()
    var initialBirdXScale = CGFloat()
    var birdPoo = SKSpriteNode()
    var airPlanesAlive = Bool()
    var birdHasReachedPoint = Bool()
    var ranWasCalled = Bool()
    var pooPooPos = Float()
    var pooCount = 0
    var birdTap = Bool()
    var firstBirdTap = Bool()
    var birdCanPoo = true
    var airPlaneHitBunny = false
    var cameToPause = false
    var leftGame = false
    var visitBunnyStore:SKLabelNode?
    var arrow: SKSpriteNode?
    var calledBunnysDone = false
    var url: URL!, url1: URL!, url2: URL!, url3: URL!, url4:URL!, url5: URL!, url6: URL!, url7: URL!

    var carrotCounter = false
    var upOrDownSwipe = false
    
    var rainDrops: SKSpriteNode?
    var rainTextureArray = [SKTexture]()
    var rainTextureAtlas = SKTextureAtlas()
    var itsRaining = false
    var saveRain = 0
    var rainTimes = 0
    var rain2:SKSpriteNode?
    var lighteningTime = Bool()
    var lightening: SKSpriteNode?
    var lighteningTap = false
    var rainEmitter: SKEmitterNode?
    var rainFadingOut = false
    var willMakeRain = false
    var longPress = UILongPressGestureRecognizer()
    var lighteningHoldIt = false
    var lightening1: SKSpriteNode?
    var lightening2: SKSpriteNode?
    var lightening3: SKSpriteNode?
    var rainEffect: SKEffectNode?
    var bunnyIsProtected = false
    var rainSoundPaused = false
    
    var tapForwardSign: SKSpriteNode?
    var tapBird: SKSpriteNode?
    var holdLightning: SKSpriteNode?
    var swipeUpSign: SKSpriteNode?
    var swipeRightSign: SKSpriteNode?
    var swipeLeftSign: SKSpriteNode?
    var toldDirection = false
    
    var tapCounter = 0
    var upSwipeRightCounter = 0
    var upSwipeLeftCounter = 0
    var leftSwipeCounter = 0
    var rightSwipeCounter = 0
    var shouldTrackBird = true
    var shouldTrackLightning = true
    var expectedDirection = ""
    var rainCheckDispatchCalled = false
    var allSwipes = true
    var earn10Carrots: SKSpriteNode!

    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        createOurScene()
    }
    
    private func createClouds() -> Void{
        randomizeTheClouds()
        Cloud1!.run(SKAction.colorize(with: listOfCloudColors[savedSky], colorBlendFactor: 0.3, duration: 0))
        Cloud2!.run(SKAction.colorize(with: listOfCloudColors[savedSky], colorBlendFactor: 0.3, duration: 0))
        Cloud3!.run(SKAction.colorize(with: listOfCloudColors[savedSky], colorBlendFactor: 0.3, duration: 0))
        Cloud1!.zPosition = 1
        Cloud1!.setScale(0.32)
        Cloud1!.name = String(countfirst) + "Cloud1"
        Cloud2!.zPosition = 1
        Cloud2!.name = String(countfirst) + "Cloud2"
        Cloud2!.setScale(0.33)
        Cloud3!.zPosition = 1
        Cloud3!.name = String(countfirst) + "Cloud3"
        Cloud3!.setScale(0.34)
        
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
       
        blackCloudList[countfirst+1] = [nil, nil, nil]
        if countfirst > 0{
            nilOrNot(cloud1: &Cloud1, cloud2: &Cloud2, cloud3: &Cloud3)
        }
        countTheTriples[countfirst] = cloudTriple
        addTheKiddos(cloud1: Cloud1, cloud2: Cloud2, cloud3: Cloud3)
        self.addChild(cloudTriple)
        listOfChildren[countfirst] = [Cloud1, Cloud2, Cloud3]
        
        
        if countfirst == 0{
        cloudheight = Cloud1!.frame.height
        Bunny.position = CGPoint(x: secondthird + xdistance, y: cloudRowYPos + ydistance)
        onACloud = true
        cloudTriple.addChild(Bunny)
        triplesChildren = listOfChildren[0]!
        blackCloudList[0] = [nil, nil, nil]
        listOfCarrots[countfirst] = [nil, nil, nil]
        bunnyxScale = Bunny.xScale
        }
        
        distance = cloudRowYPos * 3
        let moveClouds = SKAction.moveBy(x: 0, y: -distance, duration:Double(cloudMoveTime * distance))
        let cloudWait = SKAction.wait(forDuration: 1)
        let removetriple = SKAction.removeFromParent()
        moveAndRemove = SKAction.sequence([moveClouds, cloudWait, removetriple])
        cloudTriple.run(moveAndRemove)
        countfirst += 1
    }
    
    
    private func setUpUI(){
        physicsWorld.contactDelegate = self
        organizeNotifications()
        blueSky = SKSpriteNode(texture: BunnyTexts.BlueSky)
        blueSky.name = "Blue Sky"
        blueSky.setScale(3.5)
        blueSky.position = CGPoint(x: 0, y: 0)
        blueSky.zPosition = 0
        oldSky = listOfSkies.count
        listOfSkies.append(blueSky)
        
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.black)
        savedSky = oldSky
        makeAllSkies()
        if UserDefaults().integer(forKey: "BirdTapCount") > 4{
            shouldTrackBird = false
        }
        if UserDefaults().integer(forKey: "LightningHoldCount") > 4{
            shouldTrackLightning = false
        }
        if UserDefaults().bool(forKey: "AllSwipes") == false{allSwipes = false}
        else{allSwipes = true}
        makeLighteningBolts()
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true{
            soundTrack = true
        }
        else{soundTrack = false}
        if UserDefaults().string(forKey: "RabbitaColor") != ""{
            UserDefaults.standard.set("Rabbita", forKey: "bunnyType")
        }
        animateBird()
        makeBunnyAnimation(name: UserDefaults().string(forKey: "bunnyType")!)
        makeMiniBunnyAndCloud()
        Bunny = SKSpriteNode(imageNamed: bunnyAnimation! + "1")
        Bunny.zPosition = 3
        sizeIt(bunnytype: UserDefaults().string(forKey: "bunnyType")!)
        choosePhysicsBody(bunnytype: UserDefaults().string(forKey: "bunnyType")!)
        Bunny.physicsBody?.categoryBitMask = PhysicsCategory.Bunny
        Bunny.physicsBody?.collisionBitMask = 0
        Bunny.physicsBody?.isDynamic = false
        Bunny.physicsBody?.affectedByGravity = false
       
        if UserDefaults().string(forKey: "bunnyType") == "Rabbita"{
        rabbitaHasColor(animation: UserDefaults().string(forKey: "RabbitaColor")!)
        }
        createSounds()
        if UserDefaults().bool(forKey: "VisitedStore") == false{
            if UserDefaults().integer(forKey: "VisitedStoreInt") < 3 {makeVisitBunnyStore()}
            else{UserDefaults.standard.set(true, forKey: "VisitedStore")}
        }
        touchToStart = SKLabelNode(text: "Touch To Start")
        touchToStart.setScale(0.5)
        touchToStart.position = CGPoint(x: 0, y: 0)
        touchToStart.fontSize = 100
        touchToStart.fontColor = UIColor.cyan
        touchToStart.fontName = "NoteWorthy-Bold"
        touchToStart.zPosition = 2
        
        tapScreen = UITapGestureRecognizer(target: self, action: #selector(tapPiece(_:)))
        leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        leftSwipe.direction = .left
        rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        rightSwipe.direction = .right
        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        upSwipe.direction = .up
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(lighteningHold(_:)))
        longPress.minimumPressDuration = 0.3
        longPress.allowableMovement = 20
        
        self.view!.addGestureRecognizer(tapScreen)
        self.view!.addGestureRecognizer(leftSwipe)
        self.view!.addGestureRecognizer(rightSwipe)
        self.view!.addGestureRecognizer(upSwipe)
        self.view!.addGestureRecognizer(longPress)
    }

    private func organizeNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(pauseEverything(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playNow(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func removeGestureRecognizers(){
        self.view!.removeGestureRecognizer(tapScreen); self.view!.removeGestureRecognizer(leftSwipe); self.view!.removeGestureRecognizer(rightSwipe); self.view!.removeGestureRecognizer(upSwipe); self.view!.removeGestureRecognizer(longPress)
    }
    
    private func makeBunnyAnimation(name: String){
        RabbitTextureAtlas = AllTextureAtlases.textureDict[name]!
        for i in 1...RabbitTextureAtlas.textureNames.count {
            let Name = "\(name)\(i).png"; RabbitTextureArray.append(SKTexture(imageNamed: Name))
        }
}
    
    
    private func choosePhysicsBody(bunnytype: String){
        switch bunnytype{
        case "LightBrownBunny", "DarkBrownBunny", "Joyce", "Rabbita":
             Bunny.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Bunny.frame.width * 0.5, height: Bunny.frame.height * 0.03), center: CGPoint(x: Bunny.position.x, y: Bunny.position.y - 11))
        case "GrayBunny", "Jackie", "PatchBunny":
            Bunny.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Bunny.frame.width * 0.5, height: Bunny.frame.height * 0.03), center: CGPoint(x: Bunny.position.x, y: Bunny.position.y - 22))
        case "Joshie", "SpottedBlackBunny", "BlackBunnyLight":
            Bunny.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Bunny.frame.width * 0.5, height: Bunny.frame.height * 0.03), center: CGPoint(x: Bunny.position.x, y: Bunny.position.y - 17))
        case "Jason":
             Bunny.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Bunny.frame.width * 0.5, height: Bunny.frame.height * 0.03), center: CGPoint(x: Bunny.position.x, y: Bunny.position.y - 19))
        default:
        Bunny.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Bunny.frame.width * 0.5, height: Bunny.frame.height * 0.03), center: CGPoint(x: Bunny.position.x, y: Bunny.position.y - 5))
        }
    }

    private func sizeIt(bunnytype: String){
        switch bunnytype{
        case "Bunny":
            Bunny.size = CGSize(width: 100, height: 100)
        case "BeigeBunny", "BrownRabbit", "Rabbita":
            let rabbitColor:String! = UserDefaults().string(forKey: "RabbitaColor")
            if rabbitColor == "Yellow" || rabbitColor == "Green" || rabbitColor == "Pink"{
                Bunny.size = CGSize(width: 125, height: 125)
            }
            else{
                Bunny.size = CGSize(width: 135, height: 135)}
        case "DarkBrownBunny", "LightBrownBunny", "GrayBunny":
            Bunny.size = CGSize(width: 130, height: 130)
        case "BlackBunny", "SpottedBlackBunny", "BlackBunnyLight", "Joyce", "Joshie", "PatchBunny", "Jackie": Bunny.size = CGSize(width: 140, height: 140)
        case "Jason":
            Bunny.size = CGSize(width: 145, height: 145)
        default: break
        }
    }
    
    
    private func rabbitaHasColor(animation: String) {
           switch animation {
           case "Yellow":  let color = SKAction.colorize(with: UIColor(red: 245, green: 225, blue: 77), colorBlendFactor: 0.4, duration: 0); Bunny.run(color); smallBunnyImage!.run(color)
           case "Blue": let color = SKAction.colorize(with: UIColor.blue, colorBlendFactor: 0.9, duration: 0); Bunny.run(color); smallBunnyImage!.run(color)
           case "Green": let color =  SKAction.colorize(with: UIColor(red: 82, green: 171, blue: 55), colorBlendFactor: 0.5, duration: 0); Bunny.run(color); smallBunnyImage!.run(color)
           case "Pink": let color = SKAction.colorize(with: UIColor.systemPink, colorBlendFactor: 0.4, duration: 0); Bunny.run(color); smallBunnyImage!.run(color)
            case "Purple": let color = SKAction.colorize(with: UIColor(red: 150, green: 3, blue: 255), colorBlendFactor: 0.9, duration: 0); Bunny.run(color); smallBunnyImage!.run(color)
           case "Orange": let color = SKAction.colorize(with: UIColor(red: 255, green: 153, blue: 0), colorBlendFactor: 0.9, duration: 0); Bunny.run(color); smallBunnyImage!.run(color)
           case "Red": let color = SKAction.colorize(with: UIColor.systemRed, colorBlendFactor: 0.6, duration: 0); Bunny.run(color); smallBunnyImage!.run(color)
           case "BabyBlue": let color = SKAction.colorize(with: UIColor(red: 59, green: 194, blue: 235), colorBlendFactor: 0.9, duration: 0); Bunny.run(color); smallBunnyImage!.run(color)
           default:
              break
           }
       }
    
    
    private func makeMiniBunnyAndCloud(){
        bunnyAnimation = UserDefaults().string(forKey: "bunnyType")
        smallBunnyImage = SKSpriteNode(imageNamed: bunnyAnimation! + "1")
        sizeItMini(bunnytype: bunnyAnimation!)
        smallBunnyImage!.position = CGPoint(x: self.frame.width/2 - 45, y: self.frame.height/2 - 55)
        smallBunnyImage!.zPosition = 2
        if UserDefaults().string(forKey: "bunnyType") == "Rabbita"{
        rabbitaHasColor(animation: UserDefaults().string(forKey: "RabbitaColor")!)
        }
        miniCloud = SKSpriteNode(texture: BunnyTexts.Cloud1)
        miniCloud!.setScale(0.21)
        miniCloud!.zPosition = 1
        miniCloud!.position = CGPoint(x: self.frame.width/2 - 50, y: self.frame.height/2 - 80)
        self.addChild(smallBunnyImage!); self.addChild(miniCloud!)
    }
    
    private func sizeItMini(bunnytype: String){
        switch bunnytype {
            case "Bunny":
                smallBunnyImage!.size = CGSize(width: 55, height: 55)
            case "BeigeBunny", "BrownRabbit", "Shiny", "Rabbita", "Joshie", "Joyce", "Jason", "PatchBunny", "Jackie":
                smallBunnyImage!.size = CGSize(width: 75, height: 75)
            case "DarkBrownBunny", "LightBrownBunny", "GrayBunny":
                smallBunnyImage!.size = CGSize(width: 71, height: 71)
        case "BlackBunny", "SpottedBlackBunny", "BlackBunnyLight": smallBunnyImage!.size = CGSize(width: 80, height: 80)
            default: break
        }
    }
    private func makeCarrot(){
        carrot = SKSpriteNode(texture: BunnyTexts.Carrot)
        carrot!.name = "Carrot" + String(countfirst)
        carrot!.setScale(0.0225)
        carrot!.zPosition = 2
    }
    
    private func makeVisitBunnyStore(){
        arrow = SKSpriteNode(imageNamed: "PinkishOrangeArrow")
        arrow!.position = CGPoint(x: miniCloud!.position.x - miniCloud!.frame.width/2 - 13, y: self.frame.height/2 - 70)
        arrow!.zPosition = 3
        arrow?.setScale(0.12)
        let dull = SKAction.colorize(with: UIColor.black, colorBlendFactor: 0.7, duration: 0.5)
        let brighten = SKAction.colorize(with: UIColor.black, colorBlendFactor: -0.7, duration: 0.5)
        let seq = SKAction.sequence([dull, brighten])
        let repeatIt = SKAction.repeatForever(seq)
        self.addChild(arrow!)
        arrow?.run(repeatIt)
        
        visitBunnyStore = SKLabelNode(text: "Visit the bunny store")
        visitBunnyStore!.fontName = "Noteworthy-Bold"
        visitBunnyStore!.fontColor = UIColor(red: 219, green: 192, blue: 177)
        visitBunnyStore!.fontSize = 22
        visitBunnyStore!.position = CGPoint(x: arrow!.position.x - arrow!.frame.width/2 - 10 - visitBunnyStore!.frame.width/2, y: self.frame.height/2 - 79)
        visitBunnyStore!.zPosition = 3
        visitBunnyStore!.alpha = 1
        self.addChild(visitBunnyStore!)
    }
    
    private func makeAllSkies(){
        bluishGrey = SKSpriteNode(texture: BunnyTexts.BlueGrayish)
        bluishGrey.name = "Bluish Grey"
        bluishGrey.alpha = 0
        bluishGrey.setScale(3.5)
        bluishGrey.position = CGPoint(x: 0, y: 0)
        bluishGrey.zPosition = 0
        self.addChild(bluishGrey)
        listOfSkies.append(bluishGrey)
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.white)
        
        purpleSky = SKSpriteNode(texture: BunnyTexts.PurpleSky)
        purpleSky.name = "Purple Sky"
        purpleSky.alpha = 0
        purpleSky.setScale(3.5)
        purpleSky.position = CGPoint(x: 0, y: 0)
        purpleSky.zPosition = 0
        self.addChild(purpleSky)
        listOfSkies.append(purpleSky)
        listOfCloudColors.append(UIColor(red: 47, green: 209, blue: 245))
        listOfHopsFontColors.append(UIColor.white)
               
        redOrangeYellow = SKSpriteNode(texture: BunnyTexts.RedOrangeYellow)
        redOrangeYellow.name = "Red Orange Yellow"
        redOrangeYellow.alpha = 0
        redOrangeYellow.setScale(3.5)
        redOrangeYellow.position = CGPoint(x: 0, y: 0)
        redOrangeYellow.zPosition = 0
        self.addChild(redOrangeYellow)
        listOfSkies.append(redOrangeYellow)
        listOfCloudColors.append(UIColor(red: 245, green: 169, blue: 47))
        listOfHopsFontColors.append(UIColor.white)
        
        blackBlue = SKSpriteNode(texture: BunnyTexts.BluishBlack)
        blackBlue.name = "Black Blue"
        blackBlue.alpha = 0
        blackBlue.setScale(3.5)
        blackBlue.position = CGPoint(x: 0, y: 0)
        blackBlue.zPosition = 0
        self.addChild(blackBlue)
        listOfSkies.append(blackBlue)
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.white)
        
        original = SKSpriteNode(texture: BunnyTexts.TheOriginal)
        original.name = "Original"
        original.alpha = 0
        original.setScale(3.5)
        original.position = CGPoint(x: 0, y: 0)
        original.zPosition = 0
        self.addChild(original)
        listOfSkies.append(original)
        listOfCloudColors.append(UIColor(red: 112, green: 55, blue: 140))
        listOfHopsFontColors.append(UIColor.white)
        
        pinkAndBlue = SKSpriteNode(texture: BunnyTexts.PinkBlue)
        pinkAndBlue.name = "Pink Blue"
        pinkAndBlue.alpha = 0
        pinkAndBlue.setScale(3.5)
        pinkAndBlue.position = CGPoint(x: 0, y: 0)
        pinkAndBlue.zPosition = 0
        self.addChild(pinkAndBlue)
        listOfSkies.append(pinkAndBlue)
        listOfCloudColors.append(UIColor(red: 47, green: 209, blue: 245))
        listOfHopsFontColors.append(UIColor.black)
        
        brightBlueSky = SKSpriteNode(texture: BunnyTexts.BrightBlueSky)
        brightBlueSky.name = "Bright Blue Sky"
        brightBlueSky.alpha = 0
        brightBlueSky.setScale(3.5)
        brightBlueSky.position = CGPoint(x: 0, y: 0)
        brightBlueSky.zPosition = 0
        self.addChild(brightBlueSky)
        listOfSkies.append(brightBlueSky)
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.black)
        
        redOrangeYellowDark = SKSpriteNode(texture: BunnyTexts.DarkRedOrangeYellow)
        redOrangeYellowDark.name = "Red Orange Yellow Dark"
        redOrangeYellowDark.alpha = 0
        redOrangeYellowDark.setScale(3.5)
        redOrangeYellowDark.position = CGPoint(x: 0, y: 0)
        redOrangeYellowDark.zPosition = 0
        self.addChild(redOrangeYellowDark)
        listOfSkies.append(redOrangeYellowDark)
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.white)
        
        bluishBrownSky = SKSpriteNode(texture: BunnyTexts.BluishBrown)
        bluishBrownSky.name = "Bluish Brown Sky"
        bluishBrownSky.alpha = 0
        bluishBrownSky.setScale(3.5)
        bluishBrownSky.position = CGPoint(x: 0, y: 0)
        bluishBrownSky.zPosition = 0
        self.addChild(bluishBrownSky)
        listOfSkies.append(bluishBrownSky)
        listOfCloudColors.append(UIColor.systemPink)
        listOfHopsFontColors.append(UIColor.black)
        
        purpleBlack = SKSpriteNode(texture: BunnyTexts.PurpleBlack)
        purpleBlack.name = "Purple Black"
        purpleBlack.alpha = 0
        purpleBlack.setScale(3.5)
        purpleBlack.position = CGPoint(x: 0, y: 0)
        purpleBlack.zPosition = 0
        self.addChild(purpleBlack)
        listOfSkies.append(purpleBlack)
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.white)
        
        northernLights = SKSpriteNode(texture: BunnyTexts.NorthernLights)
        northernLights.name = "Northern Lights"
        northernLights.alpha = 0
        northernLights.setScale(3.5)
        northernLights.position = CGPoint(x: 0, y: 0)
        northernLights.zPosition = 0
        self.addChild(northernLights)
        listOfSkies.append(northernLights)
        listOfCloudColors.append(UIColor(red: 47, green: 245, blue: 179))
        listOfHopsFontColors.append(UIColor.white)
        
        darkBlue = SKSpriteNode(texture: BunnyTexts.LightAndDarkBlue)
        darkBlue.name = "Dark Blue"
        darkBlue.alpha = 0
        darkBlue.setScale(3.5)
        darkBlue.position = CGPoint(x: 0, y: 0)
        darkBlue.zPosition = 0
        self.addChild(darkBlue)
        listOfSkies.append(darkBlue)
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.white)
        
        brightBluishBrown = SKSpriteNode(texture: BunnyTexts.BrightBluishBrown)
        brightBluishBrown.name = "Bright Bluish Brown"
        brightBluishBrown.alpha = 0
        brightBluishBrown.setScale(3.5)
        brightBluishBrown.position = CGPoint(x: 0, y: 0)
        brightBluishBrown.zPosition = 0
        self.addChild(brightBluishBrown)
        listOfSkies.append(brightBluishBrown)
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.black)
        
        rainbow = SKSpriteNode(texture: BunnyTexts.Rainbow)
        rainbow.name = "Rainbow"
        rainbow.alpha = 0
        rainbow.setScale(3.5)
        rainbow.position = CGPoint(x: 0, y: 0)
        rainbow.zPosition = 0
        self.addChild(rainbow)
        listOfSkies.append(rainbow)
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.black)
        
        pinkAndGreen = SKSpriteNode(texture: BunnyTexts.PinkAndGreen)
        pinkAndGreen.name = "Pink and Green"
        pinkAndGreen.alpha = 0
        pinkAndGreen.setScale(3.5)
        pinkAndGreen.position = CGPoint(x: 0, y: 0)
        pinkAndGreen.zPosition = 0
        self.addChild(pinkAndGreen)
        listOfSkies.append(pinkAndGreen)
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.black)
        
        greenAndYellow = SKSpriteNode(texture: BunnyTexts.BlueGreen)
        greenAndYellow.name = "green And Yellow"
        greenAndYellow.alpha = 0
        greenAndYellow.setScale(3.5)
        greenAndYellow.position = CGPoint(x: 0, y: 0)
        greenAndYellow.zPosition = 0
        self.addChild(greenAndYellow)
        listOfSkies.append(greenAndYellow)
        listOfCloudColors.append(UIColor(red: 252, green: 249, blue: 25))
        listOfHopsFontColors.append(UIColor.black)
        
        midnight = SKSpriteNode(texture: BunnyTexts.Midnight)
        midnight.name = "Midnight"
        midnight.alpha = 0
        midnight.setScale(3.5)
        midnight.position = CGPoint(x: 0, y: 0)
        midnight.zPosition = 0
        self.addChild(midnight)
        listOfSkies.append(midnight)
        listOfCloudColors.append(UIColor.white)
        listOfHopsFontColors.append(UIColor.white)
    }
    
    private func makeLighteningBolts(){
        let thirdwidth = self.frame.width/3
        let halfwidth = CGFloat(self.frame.width/2)
        let halfthirdwidth = Double(self.frame.width/3) / 2
        let firstthird = thirdwidth - CGFloat(halfthirdwidth) - halfwidth
        let secondthird = 2 * thirdwidth - CGFloat(halfthirdwidth) - halfwidth
        let thirdthird = self.frame.width - CGFloat(halfthirdwidth) - halfwidth
        
        lightening1 = SKSpriteNode(texture: BunnyTexts.Lightening)
        let lighteningHeight = self.frame.height * 1.1
        lightening1!.size = CGSize(width: lighteningHeight/10, height: lighteningHeight)
        lightening1!.zPosition = 8
        lightening1!.position.y = 0
        lightening1!.position.x = firstthird
        lightening1!.alpha = 0
        
        lightening1!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: lightening1!.frame.width/2, height: lightening1!.frame.height))
        lightening1!.physicsBody!.categoryBitMask = PhysicsCategory.Lightening
        lightening1!.physicsBody!.isDynamic = false
        lightening1!.physicsBody!.collisionBitMask = 0
        lightening1!.physicsBody!.contactTestBitMask = PhysicsCategory.Bunny
        lightening1!.physicsBody!.affectedByGravity = false
        self.addChild(lightening1!)
        
        lightening2 = SKSpriteNode(texture: BunnyTexts.Lightening)
        lightening2!.size = CGSize(width: lighteningHeight/10, height: lighteningHeight)
        lightening2!.zPosition = 8
        lightening2!.position.y = 0
        lightening2!.position.x = secondthird
        lightening2!.alpha = 0
        
        lightening2!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: lightening2!.frame.width/2, height: lightening2!.frame.height))
        lightening2!.physicsBody!.categoryBitMask = PhysicsCategory.Lightening
        lightening2!.physicsBody!.isDynamic = false
        lightening2!.physicsBody!.collisionBitMask = 0
        lightening2!.physicsBody!.contactTestBitMask = PhysicsCategory.Bunny
        lightening2!.physicsBody!.affectedByGravity = false
        self.addChild(lightening2!)
        
        lightening3 = SKSpriteNode(texture: BunnyTexts.Lightening)
        lightening3!.size = CGSize(width: lighteningHeight/10, height: lighteningHeight)
        lightening3!.zPosition = 8
        lightening3!.position.y = 0
        lightening3!.position.x = thirdthird
        lightening3!.alpha = 0
        
        lightening3!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: lightening3!.frame.width/2, height: lightening3!.frame.height))
        lightening3!.physicsBody!.categoryBitMask = PhysicsCategory.Lightening
        lightening3!.physicsBody!.isDynamic = false
        lightening3!.physicsBody!.collisionBitMask = 0
        lightening3!.physicsBody!.contactTestBitMask = PhysicsCategory.Bunny
        lightening3!.physicsBody!.affectedByGravity = false
        self.addChild(lightening3!)
    }
    
    
    @objc private func pauseEverything(_ application: UIApplication){
        if planeSound!.isPlaying{
            planeSound?.pause(); planeSoundPaused = true}
        if rainSound!.isPlaying{
            rainSound?.pause(); rainSoundPaused = true
        }
        if gameIsActive{
            cameToPause = true
            pauseCounter = true
            soundTrack = false
            leftGame = true
            self.isPaused = true
        }
    }
    
    @objc private func playNow(_ application: UIApplication){
        if gameIsActive && cameToPause{
            if playButton.parent == nil{
                pauseButton.removeFromParent()
                createPlayButton()}
            pauseCounter = true
            cameToPause = false
            self.isPaused = true
        }
    }
    
    
    private func removeSwipeTexts(){
        tapForwardSign?.removeFromParent()
        swipeUpSign?.removeFromParent()
        swipeRightSign?.removeFromParent()
        swipeLeftSign?.removeFromParent()
    }
       
       private func tapSign(){
           removeSwipeTexts()
           let wait = SKAction.wait(forDuration: 1.5)
           let fade2 = SKAction.fadeOut(withDuration: 0.5)
           let seq = SKAction.sequence([wait, fade2])
           tapForwardSign = SKSpriteNode(imageNamed: "TapTheScreen")
           tapForwardSign!.zPosition = 7
           tapForwardSign!.setScale(2)
           tapForwardSign!.position = CGPoint(x: 0, y: carrots.position.y - carrots.frame.height/2 - tapForwardSign!.frame.height/2 - 10)
           self.addChild(tapForwardSign!)
           tapForwardSign!.run(seq, completion: {self.tapForwardSign = nil})
       }
       
       private func swipeUpMessage(){
           removeSwipeTexts()
           let wait = SKAction.wait(forDuration: 1.5)
           let fade2 = SKAction.fadeOut(withDuration: 0.5)
           let seq = SKAction.sequence([wait, fade2])
           swipeUpSign = SKSpriteNode(imageNamed: "SwipeUp")
           swipeUpSign!.zPosition = 7
           swipeUpSign!.setScale(2)
           swipeUpSign!.position = CGPoint(x: 0, y: carrots.position.y - carrots.frame.height/2 - swipeUpSign!.frame.height/2 - 10)
           self.addChild(swipeUpSign!)
           swipeUpSign!.run(seq, completion: {self.swipeUpSign = nil})
       }
       
    private func makeSwipeUpSign(){
        removeSwipeTexts()
        let wait = SKAction.wait(forDuration: 1.5)
        let fade2 = SKAction.fadeOut(withDuration: 0.5)
        let seq = SKAction.sequence([wait, fade2])
        swipeUpSign = SKSpriteNode(imageNamed: "SwipeUp")
        swipeUpSign!.zPosition = 7
        swipeUpSign!.setScale(2)
        swipeUpSign!.position = CGPoint(x: 0, y: carrots.position.y - carrots.frame.height/2 - swipeUpSign!.frame.height/2 - 10)
        self.addChild(swipeUpSign!)
        swipeUpSign!.run(seq, completion: {self.swipeUpSign = nil})
    }
    
    
    private func makeSwipeLeftSign(){
        removeSwipeTexts()
        let wait = SKAction.wait(forDuration: 1.5)
        let fade2 = SKAction.fadeOut(withDuration: 0.5)
        let seq = SKAction.sequence([wait, fade2])
        swipeLeftSign = SKSpriteNode(imageNamed: "SwipeLeft")
        swipeLeftSign!.zPosition = 7
        swipeLeftSign!.setScale(2)
        swipeLeftSign!.position = CGPoint(x: 0, y: carrots.position.y - carrots.frame.height/2 - swipeLeftSign!.frame.height/2 - 10)
        self.addChild(swipeLeftSign!)
        swipeLeftSign!.run(seq, completion: {self.swipeLeftSign = nil})
    }
    
    private func makeSwipeRightSign(){
        removeSwipeTexts()
        let wait = SKAction.wait(forDuration: 1.5)
        let fade2 = SKAction.fadeOut(withDuration: 0.5)
        let seq = SKAction.sequence([wait, fade2])
        swipeRightSign = SKSpriteNode(imageNamed: "SwipeRight")
        swipeRightSign!.zPosition = 7
        swipeRightSign!.setScale(2)
        swipeRightSign!.position = CGPoint(x: 0, y: carrots.position.y - carrots.frame.height/2 - swipeRightSign!.frame.height/2 - 10)
        self.addChild(swipeRightSign!)
        swipeRightSign!.run(seq, completion: {self.swipeRightSign = nil})
    }
    
    private func makeLightningMessage(){
        removeLabels()
        let wait = SKAction.wait(forDuration: 1.5)
        let fade2 = SKAction.fadeOut(withDuration: 0.5)
        let seq = SKAction.sequence([wait, fade2])
        holdLightning = SKSpriteNode(imageNamed: "HoldLightning")
        holdLightning!.zPosition = 9
        holdLightning!.setScale(2.5)
        holdLightning!.position = CGPoint.zero
        self.addChild(holdLightning!)
        holdLightning!.run(seq, completion: {self.holdLightning = nil})
    }
       
    private func dictateDirection(){
        if let childList = listOfChildren[savepos+1]{
            if isOnCloud!.name!.hasSuffix("d3") && childList[0] != nil && childList[1] == nil{
                if UserDefaults().integer(forKey: "UpSwipesLeft") < 3 && upSwipeLeftCounter < 3{
                    swipeUpMessage()
                    toldDirection = true
                    expectedDirection = "up"
                }
            }
            else if isOnCloud!.name!.hasSuffix("d1") && childList[1] == nil && childList[2] != nil{
                if UserDefaults().integer(forKey: "UpSwipesRight") < 3 && upSwipeRightCounter < 3{
                    swipeUpMessage()
                    toldDirection = true
                    expectedDirection = "up"
                }
            }
            else if isOnCloud!.name!.hasSuffix("d1") && childList[1] == nil && childList[2] == nil{
                if tapCounter < 3 && UserDefaults().integer(forKey: "Taps") < 3{
                    tapSign()
                    toldDirection = true
                    expectedDirection = "forward"
                }
            }
            else if isOnCloud!.name!.hasSuffix("d2") && childList[0] == nil && childList[2] == nil{
                if tapCounter < 3 && UserDefaults().integer(forKey: "Taps") < 3{
                    tapSign()
                    toldDirection = true
                    expectedDirection = "forward"
                }
            }
            else if isOnCloud!.name!.hasSuffix("d3") && childList[0] == nil && childList[1] == nil{
                if tapCounter < 3 && UserDefaults().integer(forKey: "Taps") < 3{
                    tapSign()
                    toldDirection = true
                    expectedDirection = "forward"
                }
            }
            else if (isOnCloud!.name!.hasSuffix("d2") && childList[0] != nil) || (isOnCloud!.name!.hasSuffix("d3") && childList[1] != nil){
                if leftSwipeCounter < 3 && UserDefaults().integer(forKey: "LeftSwipes") < 3{
                    makeSwipeLeftSign()
                    toldDirection = true
                    expectedDirection = "left"
                }
            }
            else if (isOnCloud!.name!.hasSuffix("d1") && childList[1] != nil) || (isOnCloud!.name!.hasSuffix("d2") && childList[2] != nil){
                if rightSwipeCounter < 3 && UserDefaults().integer(forKey: "RightSwipes") < 3{
                    makeSwipeRightSign()
                    toldDirection = true
                    expectedDirection = "right"
                }
            }
        }
    }

       
       private func removeLabels(){
            tapBird?.removeFromParent()
            holdLightning?.removeFromParent()
       }
       
       private func tapMeSign(){
           removeLabels()
           tapBird = SKSpriteNode(imageNamed: "TapTheBird")
           tapBird!.zPosition = 7
           tapBird!.position = CGPoint.zero
           tapBird!.setScale(2)
           self.addChild(tapBird!)
           let wait = SKAction.wait(forDuration: 0.5)
           let fade = SKAction.fadeIn(withDuration: 1)
           let fade2 = SKAction.fadeOut(withDuration: 1)
           let seq = SKAction.sequence([wait, fade, wait, fade2])
           tapBird!.run(seq, completion: {self.tapBird = nil})
       }
       
    
    private func createMainMenu(){
        mainMenu = SKSpriteNode(texture: BunnyTexts.MainMenu)
        mainMenu.size = CGSize(width: 210, height: 48)
        mainMenu.setScale(1.5)
        let playAgainYPos = playAgain.position.y - playAgain.frame.height/2 - mainMenu.frame.height/2
        mainMenu.position = CGPoint(x: 0, y: playAgainYPos)
        mainMenu.zPosition = 7
        mainMenu.alpha = 0
        self.addChild(mainMenu)
        mainMenu.run(SKAction.fadeIn(withDuration: endGameFadeInTime))
    }
    
    private func makeEarnCarrotsPic(){
        earn10Carrots = SKSpriteNode(texture: BunnyTexts.Earn10Carrots)
        earn10Carrots.position.x = 0
        earn10Carrots.position.y = mainMenu.position.y - mainMenu.frame.height/2 - 40
        earn10Carrots.size = CGSize(width: 245, height: 57)
        
        let carrotswidth = earn10Carrots.size.width
        let carrotHeight = earn10Carrots.size.height
        earn10Carrots.zPosition = 7
        earn10Carrots.alpha = 0
        self.addChild(earn10Carrots)
        let makeWidth = SKAction.resize(toWidth: earn10Carrots.size.width + 15, duration: 0.75)
        let makeHigher = SKAction.resize(toHeight: earn10Carrots.size.height + 5, duration: 0.75)
        let group = SKAction.group([makeWidth, makeHigher])
        let makeSmaller = SKAction.resize(toWidth: carrotswidth, duration: 0.75)
        let makeLower = SKAction.resize(toHeight: carrotHeight, duration: 0.75)
        let group2 = SKAction.group([makeSmaller, makeLower])
        let sequence = SKAction.sequence([group, group2])
        let repeatTheSizeChange = SKAction.repeatForever(sequence)
        earn10Carrots.run(SKAction.fadeIn(withDuration: endGameFadeInTime), completion: {self.earn10Carrots.run(repeatTheSizeChange)})
        
    }
    
    private func createPlayButton(){
        if let _ = pauseButton.parent{
            pauseButton.removeFromParent()
        }
        playButton = SKSpriteNode(texture: BunnyTexts.PlayButton)
        playButton.position = CGPoint(x: -self.frame.width/2 + 40, y: self.frame.height/2 - 40)
        playButton.setScale(0.1)
        playButton.zPosition = 9
        if listOfHopsFontColors[savedSky] == UIColor.black{
            playButton.color = UIColor.black; playButton.colorBlendFactor = 1.0
        }
        self.addChild(playButton)
    }
    
    
    private func createpauseButton(){
        pauseButton = SKSpriteNode(texture: BunnyTexts.PauseButton)
        pauseButton.position = CGPoint(x: -self.frame.width/2 + 40, y: self.frame.height/2 - 40)
        pauseButton.setScale(0.1)
        pauseButton.zPosition = 9
        pauseButton.alpha = 0
        pauseButton.run(SKAction.fadeIn(withDuration: 1))
        self.addChild(pauseButton)
        if listOfHopsFontColors[savedSky] == UIColor.black{
            pauseButton.color = UIColor.black; pauseButton.colorBlendFactor = 1.0
        }
    }
    
    
    private func playAgainButton(){
        playAgain = SKSpriteNode(texture: BunnyTexts.PlayAgainBar)
        playAgain.size = CGSize(width: 210, height: 48)
        playAgain.setScale(1.5)
        let restartYPos = restart.position.y
        playAgain.position = CGPoint(x: 0, y: restartYPos - 125)
        playAgain.zPosition = 7
        playAgain.alpha = 0
        self.addChild(playAgain)
        playAgain.run(SKAction.fadeIn(withDuration: endGameFadeInTime))
    }
    
    
    private func makeSorryTryAgain(){
        sorryTryAgain = SKSpriteNode(imageNamed: "SorryTryAgain")
        sorryTryAgain.setScale(1)
        let restartYPos = restart.position.y
        sorryTryAgain.position = CGPoint(x:0, y: restartYPos + 185)
        sorryTryAgain.alpha = 0
        sorryTryAgain.zPosition = 9
        self.addChild(sorryTryAgain)
        let fade = SKAction.fadeIn(withDuration: endGameFadeInTime)
        sorryTryAgain.run(fade)
    }
    
    
    private func setUpCarrotScore(){
        carrots = SKLabelNode(text: "Carrots: " + String(carrotsNum))
        carrots.zPosition = 8
        carrots.fontName = "BistroBlock"
        carrots.alpha = 0
        carrots.fontSize = 50
        carrots.run(SKAction.colorize(with: UIColor.black, colorBlendFactor: 1, duration: 0))
        carrots.setScale(0.75)
        carrots.position = CGPoint(x: self.frame.width/2 - 140, y: self.frame.height/2 - 65)
        let scorefadein = SKAction.fadeIn(withDuration: 0.5); carrots.run(scorefadein)
        self.addChild(carrots)
    }
    
    
    private func setUpScore(){
        score = SKLabelNode(text: "Hops: " + String(scorenum))
        score.fontSize = 40
        score.fontName = "BistroBlock"
        score.alpha = 0
        score.zPosition = 8
        score.run(SKAction.colorize(with: UIColor.black, colorBlendFactor: 1, duration: 0))
        if bunnysdone == false{
            score.setScale(1.1)
            score.position = CGPoint(x: -self.frame.width/2 + 110, y: -self.frame.height/2 + 27)
            let scorefadein = SKAction.fadeIn(withDuration: 0.5); score.run(scorefadein)
        }
        else{
            score.fontName = "Noteworthy-Bold"
            score.run(SKAction.colorize(with: UIColor.white, colorBlendFactor: 1, duration: 0))
            let scorefadein = SKAction.fadeIn(withDuration: endGameFadeInTime)
            let restartYPos = restart.position.y
            score.position = CGPoint(x: 0, y: restartYPos)
            score.setScale(0.975)
            score.run(scorefadein)
        }
        self.addChild(score)
    }
    
    
    private func createHighestCombinedScoreLabel(){
        highestCombinedScoreText = SKLabelNode(text: "Highest Score:  " + String(highestCombinedScore))
        highestCombinedScoreText.fontColor = UIColor.white
        highestCombinedScoreText.fontName = "Noteworthy-Bold"
        highestCombinedScoreText.fontSize = 35
        let restartYPos = restart.position.y
        highestCombinedScoreText.position = CGPoint(x: 0, y: restartYPos + 64)
        highestCombinedScoreText.zPosition = 7
        highestCombinedScoreText.setScale(0.77)
        highestCombinedScoreText.alpha = 0
        highestCombinedScoreText.run(SKAction.fadeIn(withDuration: endGameFadeInTime))
        self.addChild(highestCombinedScoreText)
    }
    
    private func createTotalScoreLabel(){
        combinedScore = SKLabelNode(text: "Score: " + String(combinedScoreNum))
        combinedScore.fontColor = UIColor.white
        combinedScore.fontName = "Noteworthy-Bold"
        combinedScore.fontSize = 45
        combinedScore.zPosition = 7
        let restartYPos = restart.position.y
        combinedScore.position = CGPoint(x: 0, y: restartYPos - 63)
        combinedScore.alpha = 0
        combinedScore.setScale(0.9)
        combinedScore.run(SKAction.fadeIn(withDuration: endGameFadeInTime))
        self.addChild(combinedScore)
    }
    
    
    private func createHighestScoreLabel(){
        mostHops = SKLabelNode(text: "Most Hops: " + String(bestScore))
        mostHops.color = UIColor.white
        mostHops.fontName = "Noteworthy-Bold"
        mostHops.fontSize = 35
        let restartYPos = restart.position.y
        mostHops.position = CGPoint(x: 0, y: restartYPos + 120)
        mostHops.zPosition = 7
        mostHops.setScale(0.77)
        mostHops.alpha = 0
        mostHops.run(SKAction.fadeIn(withDuration: endGameFadeInTime))
        self.addChild(mostHops)
    }
    
    
    private func highestScore(score: Int){
        if score > UserDefaults().integer(forKey: "highscore"){
            UserDefaults.standard.set(score, forKey: "highscore")
            bestScore = score
        }
    }
    
    private func highestCombinedScore(highest: Int){
        if highest > UserDefaults().integer(forKey: "highestTotalScore"){
            UserDefaults.standard.set(highest, forKey: "highestTotalScore")
            highestCombinedScore = highest
        }
    }
    
    private func makeEndOfGameButton(){
        GameScore.gameCenterButton = UIButton()
        self.view!.addSubview(GameScore.gameCenterButton)
        GameScore.gameCenterButton.translatesAutoresizingMaskIntoConstraints = false
        GameScore.gameCenterButton.backgroundColor = UIColor.clear.withAlphaComponent(0)
        GameScore.gameCenterButton.contentMode = .scaleToFill
        GameScore.gameCenterButton.clipsToBounds = true
        GameScore.gameCenterButton.setImage(UIImage(named: "Medals"), for: .normal)
        GameScore.gameCenterButton.adjustsImageWhenHighlighted = true
        GameScore.gameCenterButton.isUserInteractionEnabled = true
        GameScore.gameCenterButton.addTarget(self, action: #selector(self.sendGameCenterNotification), for: .touchUpInside)
        GameScore.gameCenterButton.setTitle("Medals", for: .normal)
        let heightdifference = self.frame.height - 30 - 70
        let widthdifference = self.frame.width - 30 - 70
        GameScore.gameCenterButton.topAnchor.constraint(equalTo: self.view!.topAnchor, constant: 32).isActive = true
        GameScore.gameCenterButton.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: 32).isActive = true
        GameScore.gameCenterButton.trailingAnchor.constraint(equalTo: self.view!.trailingAnchor, constant:  -widthdifference).isActive = true
        GameScore.gameCenterButton.bottomAnchor.constraint(equalTo: self.view!.bottomAnchor, constant: -heightdifference).isActive = true
    }

    
    @objc private func sendGameCenterNotification(){
        NotificationCenter.default.post(name: Notification.Name(rawValue: "GameCenterLeaderBoard"), object: self)
    }
    
     private func makeSoundOffButton(){
        soundOffButton = SKSpriteNode(texture: BunnyTexts.SoundOffButton)
        soundOffButton.position =  CGPoint(x: self.frame.width/2 - 40, y: -self.frame.height/2 + 40)
        soundOffButton.zPosition = 9
        soundOffButton.setScale(0.12)
        self.addChild(soundOffButton)
    }
    
     private func makeSoundOnButton(){
        soundOnButton = SKSpriteNode(texture: BunnyTexts.SoundButton)
        soundOnButton.position = CGPoint(x: self.frame.width/2 - 40, y: -self.frame.height/2 + 40)
        soundOnButton.zPosition = 9
        soundOnButton.setScale(0.12)
        self.addChild(soundOnButton)
    }
   
    
    private func randomizeTheClouds(){
        for each in 0...2{
            let randomNum = Int.random(in: 0...3)
            if randomNum == 0{
                if each == 0{
                    Cloud1 = SKSpriteNode(texture: BunnyTexts.Cloud1)
                }
                else if each == 1{
                    Cloud2 = SKSpriteNode(texture: BunnyTexts.Cloud1)
                }
                else {
                    Cloud3 = SKSpriteNode(texture: BunnyTexts.Cloud1)
                }
            }
            else if randomNum == 1{
                 if each == 0{
                    Cloud1 = SKSpriteNode(texture: BunnyTexts.Cloud2)
                }
                else if each == 1{
                    Cloud2 = SKSpriteNode(texture: BunnyTexts.Cloud2)
                }
                 else {
                    Cloud3 = SKSpriteNode(texture: BunnyTexts.Cloud2)
                }
            }
            else if randomNum == 2{
                if each == 0{
                    Cloud1 = SKSpriteNode(texture: BunnyTexts.Cloud3)
                }
                else if each == 1{
                    Cloud2 = SKSpriteNode(texture: BunnyTexts.Cloud3)
                }
                else {
                    Cloud3 = SKSpriteNode(texture: BunnyTexts.Cloud3)
                }
            }
            else {
                if each == 0{
                    Cloud1 = SKSpriteNode(texture: BunnyTexts.Cloud4)
                }
                else if each == 1{
                    Cloud2 = SKSpriteNode(texture: BunnyTexts.Cloud4)
                }
                else {
                    Cloud3 = SKSpriteNode(texture: BunnyTexts.Cloud4)
                }
            }
        }
    }

    
    private func makeAirPlane(){
        airPlanesAlive = true
        airPlane = SKSpriteNode(texture: BunnyTexts.AirPlane)
        airPlane!.setScale(0.9)
        airPlane!.zPosition = 4
        airPlaneXScale = airPlane!.xScale
        let screenhighHeight = Float(self.frame.height/2 - 90)
        let screenlowHeight = Float(-self.frame.height/2 + 90)
    
        let convertedBunnyPos = self.convert(Bunny.position, from: Bunny.parent!)
        if convertedBunnyPos.y >= 0{
            let randFloat = Float.random(in: 0...screenhighHeight)
            airPlane!.position.y = CGFloat(randFloat)
        }
        else{
            let randFloat = Float.random(in: screenlowHeight...0)
            airPlane!.position.y = CGFloat(randFloat)
        }
        let randNum = Int.random(in: 1...2)
        var xD = self.frame.width + 2 * airPlane!.frame.width
        if randNum == 1{
            airPlane!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: airPlane!.frame.width/2, height: airPlane!.frame.height - airPlane!.frame.height/3), center: CGPoint(x: -airPlane!.frame.width/4, y: 0))
            airPlane!.position.x = -self.frame.width / 2 - airPlane!.frame.width/2
        }
        else{
            airPlane!.xScale = airPlane!.xScale * -1
            airPlane!.position.x = self.frame.width / 2 + airPlane!.frame.width/2
            xD *= -1
            airPlane!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: airPlane!.frame.width/2, height: airPlane!.frame.height - airPlane!.frame.height/3), center: CGPoint(x: airPlane!.frame.width/4, y: 0))
        }
        airPlane!.physicsBody?.categoryBitMask = PhysicsCategory.AirPlane
        airPlane!.physicsBody?.affectedByGravity = false
        airPlane!.physicsBody?.isDynamic = true
        airPlane!.physicsBody?.collisionBitMask = 0
        airPlane!.physicsBody?.contactTestBitMask = PhysicsCategory.Bunny
        makePlaneSound()
        let moveIt = SKAction.moveBy(x: xD, y: 0, duration: 5)
        let removePlane = SKAction.removeFromParent()
        let seq = SKAction.sequence([moveIt, removePlane])
        airPlane!.run(seq)
        self.addChild(airPlane!)
    }
    
    
    private func airPlanePass(){
        if scorenum == 0{
            let randNum = Int.random(in: lowerPlaneBound...upperPlaneBound)
            planeCount = randNum
        }
        else{
            if scorenum == planeCount {
                let randNum = Int.random(in: lowerPlaneBound...upperPlaneBound)
                planeCount = scorenum + randNum
                makeAirPlane()
            }
        }
    }
    
    
    private func animateBird(){
        BirdTextureAtlas = SKTextureAtlas(named: "BirdAnimation")
        for i in 1...BirdTextureAtlas.textureNames.count {
            let Name = "Bird\(i).png"; BirdTextureArray.append(SKTexture(imageNamed: Name))
        }
    }
    
    private func makeBird(){
        if shouldTrackBird{
            if UserDefaults().integer(forKey: "BirdTapCount") <= 4{
                tapMeSign()}}
        birdCanPoo = true
        firstBirdTap = true
        birdHasReachedPoint = true
        Bird = SKSpriteNode(texture: BunnyTexts.Bird)
        initialBirdXScale = Bird.xScale
        Bird.setScale(0.35)
        Bird.zPosition = 7
        let maxY = self.frame.height/2 - Bird.frame.height/2
        let minY = maxY - 150
        let randY = CGFloat.random(in: minY...maxY)
        Bird.position.y = randY
        var distance = self.frame.width + 2 * Bird.frame.width
        let rand = Int.random(in: 1...2)
        if rand == 1{
            Bird.position.x = -self.frame.width/2 - Bird.frame.width
        }
        else{Bird.xScale = Bird.xScale * -1
            Bird.position.x = self.frame.width/2 + Bird.frame.width
            distance = distance * -1
        }
        
        let moveDist = SKAction.moveBy(x: distance, y: 0, duration: 2.8)
        let flapWings = SKAction.animate(with: BirdTextureArray, timePerFrame: Double(2.8) / (Double(BirdTextureArray.count) * 10))
        let flapForever = SKAction.repeatForever(flapWings)
        let remove = SKAction.removeFromParent()
        let groupMove = SKAction.group([moveDist, flapForever])
        Bird.run(SKAction.sequence([groupMove, remove]), withKey: "Firstflight")
        makeBirdChirp()
        self.addChild(Bird)
    }
    
    private func makeBirdPoop(){
        birdPoo = SKSpriteNode(texture: BunnyTexts.BirdPoo)
        birdPoo.position = Bird.position
        birdPoo.zPosition = 5
        birdPoo.setScale(0.1)
        birdPoo.physicsBody = SKPhysicsBody(circleOfRadius: (birdPoo.frame.width/CGFloat(2)) * 0.49)
        birdPoo.physicsBody?.categoryBitMask = PhysicsCategory.Poo
        birdPoo.physicsBody?.collisionBitMask = 0
        birdPoo.physicsBody?.contactTestBitMask = PhysicsCategory.Bunny
        birdPoo.physicsBody?.affectedByGravity = true
        birdPoo.physicsBody?.isDynamic = true
        self.addChild(birdPoo)
    }

    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstContactBody = contact.bodyA
        let secondContactBody = contact.bodyB
        if firstContactBody.categoryBitMask == PhysicsCategory.Bunny && secondContactBody.categoryBitMask == PhysicsCategory.Poo || firstContactBody.categoryBitMask == PhysicsCategory.Poo && secondContactBody.categoryBitMask == PhysicsCategory.Bunny{
            if resetCalled == false{
                bunnysdone = true
                makeSplatSound()
                let joint = SKPhysicsJointFixed.joint(withBodyA: firstContactBody, bodyB: secondContactBody, anchor: CGPoint(x: Bunny.position.x, y: Bunny.position.y))
                physicsWorld.add(joint)
                resetCalled = true
                let currentCarrotCount = UserDefaults().integer(forKey: "CarrotCount")
                UserDefaults.standard.set(currentCarrotCount + carrotsNum, forKey: "CarrotCount")
                combinedScoreNum = carrotsNum + scorenum
                if rainSound!.isPlaying{
                    rainSound!.setVolume(0, fadeDuration: 3)
                }
                restartButton()

            }
        }
        else if firstContactBody.categoryBitMask == PhysicsCategory.Bunny && secondContactBody.categoryBitMask == PhysicsCategory.AirPlane || firstContactBody.categoryBitMask == PhysicsCategory.AirPlane && secondContactBody.categoryBitMask == PhysicsCategory.Bunny{
            planeHitBunny()
            airPlaneHitBunny = true
        }
        else if firstContactBody.categoryBitMask == PhysicsCategory.Lightening && secondContactBody.categoryBitMask == PhysicsCategory.Bunny || firstContactBody.categoryBitMask == PhysicsCategory.Bunny && secondContactBody.categoryBitMask == PhysicsCategory.Lightening {
            if !bunnyIsProtected{
                if resetCalled == false{
                    makeLighteningSound()
                    bunnysdone = true
                    resetCalled = true
                    let yellowBunny = SKAction.colorize(with: UIColor(red: 255, green: 238, blue: 51), colorBlendFactor: 1, duration: 0)
                    let wait = SKAction.wait(forDuration: 0.5)
                    let fadeOut = SKAction.fadeOut(withDuration: endGameFadeInTime)
                    let sequence = SKAction.sequence([yellowBunny, wait, fadeOut])
                    Bunny.run(sequence)
                    let currentCarrotCount = UserDefaults().integer(forKey: "CarrotCount")
                    UserDefaults.standard.set(currentCarrotCount + carrotsNum, forKey: "CarrotCount")
                    combinedScoreNum = carrotsNum + scorenum; resetCalled = true;
                    if rainSound!.isPlaying{
                        rainSound!.setVolume(0, fadeDuration: 3)
                    }
                    restartButton()
                }
            }
        }
    }
    
    
    private func restartButton(){
        Ads.adTimer += 1
        removeLabels()
        GameScore.viewController.saveHighScore(thescore: combinedScoreNum)
        restart = SKSpriteNode(color: UIColor(red: 36, green: 8, blue: 59, a: 1), size: CGSize(width: 210, height: 300))
        restart.position = CGPoint(x: 0, y: 30)
        restart.setScale(1.5)
        restart.zPosition = 6
        restart.alpha = 0
        restart.run(SKAction.fadeAlpha(by: 0.95, duration: endGameFadeInTime))
        gameIsActive = false
        highestScore(score: scorenum)
        highestCombinedScore(highest: combinedScoreNum)
        self.addChild(restart)
        changeSwipeValues()
        makeSorryTryAgain()
        createTotalScoreLabel()
        createHighestScoreLabel()
        createHighestCombinedScoreLabel()
        pauseButton.run(SKAction.fadeOut(withDuration: endGameFadeInTime))
        soundOnButton.run(SKAction.fadeOut(withDuration: endGameFadeInTime))
        soundOffButton.run(SKAction.fadeOut(withDuration: endGameFadeInTime))
        score.removeFromParent()
        playAgainButton()
        setUpScore()
        createMainMenu()
        makeEarnCarrotsPic()
        if GameScore.playerIsAuthentic{
           makeEndOfGameButton()}
        airPlane = nil
        if Ads.adTimer == 7{
            Ads.adTimer = 0
            NotificationCenter.default.post(name: Notification.Name(rawValue: "InterstitialAdPlayer"), object: self)
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "BannerAdShow"), object: self)
    }
    
    
    private func changeSwipeValues(){
        if UserDefaults().bool(forKey: "AllSwipes") == false{
            if UserDefaults().integer(forKey: "RightSwipes") <= 3{
                if rightSwipeCounter >= 3{
                    var amt = UserDefaults().integer(forKey: "RightSwipes")
                    amt += 1
                    UserDefaults.standard.set(amt, forKey: "RightSwipes")
                }
            }
            if UserDefaults().integer(forKey: "LeftSwipes") <= 3{
                if leftSwipeCounter >= 3{
                    var amt = UserDefaults().integer(forKey: "LeftSwipes")
                    amt += 1
                    UserDefaults.standard.set(amt, forKey: "LeftSwipes")
                }
            }
            if UserDefaults().integer(forKey: "UpSwipesRight") <= 3{
                if upSwipeRightCounter >= 3{
                    var amt = UserDefaults().integer(forKey: "UpSwipesRight")
                    amt += 1
                    UserDefaults.standard.set(amt, forKey: "UpSwipesRight")
                }
            }
            if UserDefaults().integer(forKey: "UpSwipesLeft") <= 3{
                if upSwipeLeftCounter >= 3{
                    var amt = UserDefaults().integer(forKey: "UpSwipesLeft")
                    amt += 1
                    UserDefaults.standard.set(amt, forKey: "UpSwipesLeft")
                }
            }
            if UserDefaults().integer(forKey: "Taps") <= 3{
                if tapCounter >= 3{
                    var amt = UserDefaults().integer(forKey: "Taps")
                    amt += 1
                    UserDefaults.standard.set(amt, forKey: "Taps")
                }
            }
            if UserDefaults().integer(forKey: "RightSwipes") > 2 && UserDefaults().integer(forKey: "LeftSwipes") > 2 && UserDefaults().integer(forKey: "UpSwipesRight") > 2 && UserDefaults().integer(forKey: "UpSwipesLeft") > 2 && UserDefaults().integer(forKey: "Taps") > 2{
                UserDefaults.standard.set(true, forKey: "AllSwipes")
            }
        }
    }
    
    private func chooseSky(){
        if scorenum == 1{
            savedScore = scorenum
            skyTimeWait = Int.random(in: 20...35)
        }
        else if scorenum > 1{
            if scorenum == savedScore + skyTimeWait{
                savedScore = scorenum
                skyTimeWait = Int.random(in: 20...35)
                changeTheSky()
            }
        }
    }
       
       
    private func changeTheSky(){
        oldSky = savedSky
        if scorenum < 50 {
            let randomNum1 = Int.random(in: 0...2)
            if randomNum1 == savedSky && savedSky > 0 {
                   savedSky = randomNum1 - 1
            }
            else if randomNum1 == savedSky && savedSky == 0 {
                savedSky = randomNum1 + 1
            }
            else{
                savedSky = randomNum1
            }
        }
        else if scorenum < 100{
                let randomNum1 = Int.random(in: 3...4)
                if randomNum1 == savedSky && savedSky > 3 {
                       savedSky = randomNum1 - 1
                }
                else if randomNum1 == savedSky && savedSky == 3 {
                    savedSky = randomNum1 + 1
                }
                else{
                    savedSky = randomNum1
                }
            }
        else if scorenum < 150{
            let randomNum1 = Int.random(in: 5...8)
            if randomNum1 == savedSky && savedSky > 5 {
                savedSky = randomNum1 - 1
            }
            else if randomNum1 == savedSky && savedSky == 5 {
                savedSky = randomNum1 + 1
            }
            else{
                savedSky = randomNum1
            }
        }
           
        else if scorenum < 200{
            let randomNum1 = Int.random(in: 9...12)
            if randomNum1 == savedSky && savedSky > 9 {
                savedSky = randomNum1 - 1
            }
            else if randomNum1 == savedSky && savedSky == 9 {
                savedSky = randomNum1 + 1
            }
            else{
                savedSky = randomNum1
            }
        }
        else if scorenum < 250{
            let randomNum1 = Int.random(in: 13...17)
            if randomNum1 == savedSky && savedSky > 13 {
                savedSky = randomNum1 - 1
            }
            else if randomNum1 == savedSky && savedSky == 13 {
                savedSky = randomNum1 + 1
            }
            else{
                savedSky = randomNum1
            }
        }
        else {
            let randomNum1 = Int.random(in: 0...17)
            if randomNum1 == savedSky && savedSky > 0{
                savedSky = randomNum1 - 1
            }
            else if randomNum1 == savedSky && savedSky == 0{
                savedSky = randomNum1 + 1
            }
            else {
                savedSky = randomNum1
            }
        }
        if listOfHopsFontColors[savedSky] == UIColor.black && listOfHopsFontColors[oldSky] == UIColor.white{
            let colorIt = SKAction.colorize(with: UIColor.black, colorBlendFactor: 1, duration: 1)
            score.run(colorIt)
            carrots.run(colorIt)
            pauseButton.run(colorIt)
        }
        else if listOfHopsFontColors[savedSky] == UIColor.white && listOfHopsFontColors[oldSky] == UIColor.black{
            let colorIt = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1, duration: 1)
            score.run(colorIt)
            carrots.run(colorIt)
            pauseButton.run(colorIt)
            soundOnButton.run(colorIt)
        }
    
        listOfSkies[oldSky].run(SKAction.fadeAlpha(by: -1, duration: 2.5))
        listOfSkies[savedSky].run(SKAction.fadeAlpha(by: 1, duration: 2.5))
        checkIfRaining()
    }
    private func checkIfRaining(){
        if self.itsRaining{
            listOfSkies[savedSky].color = UIColor.gray
            listOfSkies[savedSky].colorBlendFactor = 0.7
        }
        else{
            listOfSkies[savedSky].colorBlendFactor = 0
        }
        if !rainCheckDispatchCalled{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {self.rainCheckDispatchCalled = true; self.checkIfRaining()})
        }
    }

    private func changeTheSpeed(){
        switch scorenum{
        case 10:
            cloudMoveTime = 0.0047
        case 20:
            cloudMoveTime = 0.00465
        case 30:
            cloudMoveTime = 0.0046
        case 50:
            cloudMoveTime = 0.00445
        case 75:
            cloudMoveTime = 0.00453
        case 100:
            cloudMoveTime = 0.00415
        case 125:
            cloudMoveTime = 0.004
        case 150:
            cloudMoveTime = 0.00385
        case 175:
            cloudMoveTime = 0.0037
        case 200:
            cloudMoveTime = 0.00355
        case 225:
            cloudMoveTime = 0.0034
        case 250:
            cloudMoveTime = 0.00325
        case 275:
            cloudMoveTime = 0.0031
        case 300:
            cloudMoveTime = 0.00298
             bunnyHopTime = 0.485
        case 325:
            cloudMoveTime = 0.00295
            lowerPlaneBound = 8
            upperPlaneBound = 12
            bunnyHopTime = 0.49
        case 350:
             cloudMoveTime = 0.00293
             bunnyHopTime = 0.4974
        default: break
        }
    }
    
    
    private func addTheKiddos(cloud1: SKSpriteNode?, cloud2: SKSpriteNode?, cloud3: SKSpriteNode?){
        var carrotlist:[SKSpriteNode?] = []
        if let _ = cloud1{
            cloudTriple.addChild(cloud1!)
            if countfirst > 0{
                let randNum = Int.random(in: 1...10)
                if randNum == 1{
                    makeCarrot()
                    carrot!.position.x = cloud1!.position.x
                    carrot!.position.y = cloud1!.position.y + ydistance
                    carrotlist.append(carrot!)
                    countTheTriples[countfirst]!!.addChild(carrot!)
                }
                else {carrotlist.append(nil)}
            }
        }
        else{carrotlist.append(nil)}
        if let _ = cloud2{
            cloudTriple.addChild(cloud2!)
            if countfirst > 0{
                let randNum = Int.random(in: 1...10)
                if randNum == 2{ //can be any number
                    makeCarrot()
                    carrot!.position.x = cloud2!.position.x + xdistance
                    carrot!.position.y = cloud2!.position.y + ydistance
                    carrotlist.append(carrot!)
                    countTheTriples[countfirst]!!.addChild(carrot!)
                }
                else{carrotlist.append(nil)}
            }
        }
        else{carrotlist.append(nil)}
        if let _ = cloud3{
            cloudTriple.addChild(cloud3!)
            if countfirst > 0{
                let randNum = Int.random(in: 1...10)
                if randNum == 1{
                    makeCarrot()
                    carrot!.position.x = cloud3!.position.x + xdistance
                    carrot!.position.y = cloud3!.position.y + ydistance
                    carrotlist.append(carrot!)
                    countTheTriples[countfirst]!!.addChild(carrot!)
                }
                else{carrotlist.append(nil)}
            }
        }
        else{carrotlist.append(nil)}
        listOfCarrots[countfirst] = carrotlist
    }
    
    
    private func makeBlackCloud(theCloud: inout SKSpriteNode?){
        let randNum = Int.random(in: 1...3)
        if randNum > 1 {
            theCloud!.run(SKAction.colorize(with: UIColor.black, colorBlendFactor: 0.4, duration: 0))
            let num = theCloud!.name!.count
            let name = Int(String(theCloud!.name![num - 1]))
            if name!-1 == 0{
                blackCloudList[countfirst] = [theCloud, nil, nil]
            }
            else if name!-1 == 1{
                blackCloudList[countfirst] = [nil, theCloud, nil]
            }
            else{ blackCloudList[countfirst] = [nil, nil, theCloud] }
        }
    }
    
    
    private func nilOrNot(cloud1: inout SKSpriteNode?, cloud2: inout SKSpriteNode?, cloud3: inout SKSpriteNode?){
        let randomNum = Int.random(in: 0...2)
        if randomNum == 0{
            var lineOfClouds:[SKSpriteNode?] = [cloud1, cloud2, cloud3]
            lineOfClouds.remove(at: 0)
            let randomNum2 = Int.random(in: 1...100)
            let randomNum1or2 = Int.random(in: 1...2)
            if randomNum1or2 == 1 {
                if randomNum2 > 25{
                cloud2 = nil
                lineOfClouds.remove(at: 0)
                let finalRan = Int.random(in: 1...100)
                if finalRan > 3{
                    cloud3 = nil
                }
            }
                else if randomNum2 < 25{
                    if savedSky > 0{
                        makeBlackCloud(theCloud: &cloud2)}
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 3{
                        cloud3 = nil}
                }
            }
            else if randomNum1or2 == 2{
                if randomNum2 > 25{
                    cloud3 = nil
                    lineOfClouds.remove(at: 1)
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 3{
                        cloud2 = nil
                    }
                }
                else if randomNum2 < 25{
                    if savedSky > 0{
                        makeBlackCloud(theCloud: &cloud3) }
                let finalRan = Int.random(in: 1...100)
                if finalRan > 3{
                    cloud2 = nil}
            }
        }
    }
            
        else if randomNum == 1{
            var lineOfClouds:[SKSpriteNode?] = [cloud1, cloud2, cloud3]
            lineOfClouds.remove(at: 1)
            let randomNum2 = Int.random(in: 1...100)
            let randomNum1or2 = Int.random(in: 1...2)
            if randomNum1or2 == 1 {
                if randomNum2 > 25{
                    cloud1 = nil
                    lineOfClouds.remove(at: 0)
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 3{
                        cloud3 = nil
                    }
                }
                else if randomNum2 < 25{
                    if savedSky > 0{
                        makeBlackCloud(theCloud: &cloud1) }
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 3{
                        cloud3 = nil}
                }
            }
            else if randomNum1or2 == 2{
                if randomNum2 > 25{
                    cloud3 = nil
                    lineOfClouds.remove(at: 1)
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 3{
                        cloud1 = nil
                    }
                }
                else if randomNum2 < 25{
                    if savedSky > 0{
                        makeBlackCloud(theCloud: &cloud3) }
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 3{
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
                if randomNum2 > 25{
                    cloud1 = nil
                    lineOfClouds.remove(at: 0)
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 3{
                        cloud2 = nil
                    }
                }
                else if randomNum2 < 25{
                    if savedSky > 0{
                        makeBlackCloud(theCloud: &cloud1) }
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 3{
                        cloud2 = nil}
                }
            }
                else if randomNum1or2 == 2{
                    if randomNum2 > 25{
                        cloud2 = nil
                        lineOfClouds.remove(at: 1)
                        let finalRan = Int.random(in: 1...100)
                        if finalRan > 3{
                            cloud1 = nil
                        }
                    }
                else if randomNum2 < 25{
                        if savedSky > 0{
                            makeBlackCloud(theCloud: &cloud2) }
                    let finalRan = Int.random(in: 1...100)
                    if finalRan > 3{
                        cloud1 = nil}
                    }
                }
            }
        }
    
    
    private func samePos(bunny: SKSpriteNode, cloudpos1: SKSpriteNode?,  cloudpos2: SKSpriteNode?, cloudpos3: SKSpriteNode?) -> Bool{
        if let onCloud1 = cloudpos1{
            if bunny.position.x > onCloud1.position.x - 35 + (xdistance) && bunny.position.x < onCloud1.position.x + 35 + (xdistance) && bunny.position.y > onCloud1.position.y - 35 + ydistance && bunny.position.y < onCloud1.position.y + 35 + ydistance {
                isOnCloud = cloudpos1
                return true}
            else{
                if samePos(bunny: bunny, cloudpos1: nil, cloudpos2: cloudpos2, cloudpos3: cloudpos3) == true{
                    return true
                }
            }
        }
            else if let onCloud2 = cloudpos2{
              if bunny.position.x > onCloud2.position.x - 35 + (xdistance) && bunny.position.x < onCloud2.position.x + 35 + (xdistance) && bunny.position.y > onCloud2.position.y - 35 + ydistance && bunny.position.y < onCloud2.position.y + 35 + ydistance {
                isOnCloud = cloudpos2
                   return true}
                else{
                    if samePos(bunny: bunny, cloudpos1: nil, cloudpos2: nil, cloudpos3: cloudpos3) == true{
                        return true
                    }
                }
            }
            else if let onCloud3 = cloudpos3{
               if bunny.position.x > onCloud3.position.x - 35 + (xdistance) && bunny.position.x < onCloud3.position.x + 35 + (xdistance) && bunny.position.y > onCloud3.position.y - 35 + ydistance && bunny.position.y < onCloud3.position.y + 35 + ydistance {
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
    
    
    private func inFarRangeLeft(_ bunny: SKSpriteNode) -> Bool{
        let thirdWidth = self.frame.width / 3
        if bunny.position.x + (2 * thirdWidth) < self.frame.width / 2 {
            return true
        }
        return false
    }
    
    
    private func bunnyInFarRangeRight(_ bunny: SKSpriteNode) -> Bool{
        let thirdWidth = self.frame.width / 3
        if bunny.position.x - (2 * thirdWidth) >  -self.frame.width / 2{
            return true
        }
        return false
    }
    
    
    private func checkBunnyCarrotPos(){
        if isOnCloud!.name!.hasSuffix("d2") && upOrDownSwipe{ return }
        let strCount = isOnCloud!.name!.count
        let theEnd = String(isOnCloud!.name![strCount-1])
        if let theEndInt = Int(theEnd){
            if let hasCarrot = listOfCarrots[savepos]![theEndInt-1]{
                makeCarrotSound()
                carrotsNum += 1
                carrots!.text = "Carrots: " + String(carrotsNum)
                hasCarrot.run(SKAction.fadeOut(withDuration: 1))
            }
        }
        listOfCarrots.removeValue(forKey: savepos)
    }


    private func createOurScene(){
        setUpUI()
        self.addChild(blueSky)
        self.addChild(touchToStart)
    }
    
    
    private func restartGame(){
        DispatchQueue.global().async {
            self.removeAllActions()
            self.removeAllChildren()
        }
        bunnysdone = false; firsttouch = false; savepos = 0; countfirst = 0; scorenum = 0; onACloud = false; resetCalled = false; cloudMoveTime = 0.005; cloudDelayTime = 0.59; bunnyHopTime = 0.482; listOfSkies = []; colorCloudBlendFactor = 0; carrotsNum = 0; listOfCloudColors = []; listOfHopsFontColors = []; combinedScoreNum = 0; RabbitTextureArray = []; pauseCounter = false; soundTrack = true; bunnyMoveWithSound = true; pausedAfterOpening = false; gameIsActive = false; blackCloudList = [:]; planeCount = 0; lowerPlaneBound = 10; upperPlaneBound = 15; planeSoundPaused = false; listOfCarrots = [:]; triplesChildren = []; countTheTriples = [:]; listOfChildren = [:]; BirdTextureArray = []; birdHasReachedPoint = false; airPlanesAlive = false; ranWasCalled = false; pooPooPos = 0; pooCount = 0; cameToPause = false; birdCanPoo = true; airPlaneHitBunny = false; leftGame = false; calledBunnysDone = false; carrotCounter = false; upOrDownSwipe = false; rainTextureArray = []; itsRaining = false; saveRain = 0; rainTimes = 0; lighteningTime = false; lighteningTap = false; rainFadingOut = false; willMakeRain = false; lighteningHoldIt = false; rainEmitter = nil; bunnyIsProtected = false; rainSoundPaused = false; toldDirection = false; tapCounter = 0; leftSwipeCounter = 0; rightSwipeCounter = 0; upSwipeRightCounter = 0; upSwipeLeftCounter = 0; shouldTrackBird = true; shouldTrackLightning = true; expectedDirection = ""; rainCheckDispatchCalled = false; allSwipes = true
        
        removeGestureRecognizers()
        bunnyFellSound = nil; bunnyDidntHop = nil; planeHitSound = nil; blackCloudsound = nil
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        if GameScore.playerIsAuthentic{
        GameScore.gameCenterButton.removeTarget(self, action: #selector(self.sendGameCenterNotification), for: .touchUpInside)
            GameScore.gameCenterButton.removeFromSuperview()}
        createOurScene()
    }
    
    private func transitionToStoreScene(){
        Views.initialScrollDone = false
        removeGestureRecognizers()
        let storeScene = StoreScene(fileNamed: "StoreScene")
        let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
        self.scene?.view?.presentScene(storeScene!, transition: fadeAway)
    }
    
    private func theBlender<T: SKNode>(runActionOn thisnode: T){
        let blendIt = SKAction.colorize(with: UIColor.black, colorBlendFactor: 0.45, duration: 0.35)
        let wait = SKAction.wait(forDuration: 0.05)
        let unBlend = SKAction.colorize(withColorBlendFactor: -0.9, duration: 0.25)
        let sequ = SKAction.sequence([blendIt, wait, unBlend])
        thisnode.run(sequ)
    }
    

    private func rotateRabbit(recognizerDirection: UISwipeGestureRecognizer.Direction){
        switch recognizerDirection {
        case .left:
            if isOnCloud!.name!.hasSuffix("d2") || isOnCloud!.name!.hasSuffix("d3"){
                if Bunny.xScale == bunnyxScale{
                    Bunny.xScale = Bunny.xScale * -1
                }
            }
        case .right:
            if isOnCloud!.name!.hasSuffix("d1") || isOnCloud!.name!.hasSuffix("d2"){
                if Bunny.xScale != bunnyxScale{
                    Bunny.xScale = Bunny.xScale * -1
                }
            }
        case .up:
            if isOnCloud!.name!.hasSuffix("d1") ||  isOnCloud!.name!.hasSuffix("d3"){
                Bunny.xScale = Bunny.xScale * -1
            }
        default:
            break
        }
    }
    
    private func makeLightening(){
        lighteningHoldIt = false
        if !bunnysdone && !rainFadingOut{
            if shouldTrackLightning{makeLightningMessage()}
            let rand = Int.random(in: 1...3)
            if rand == 1{
                let makeLighter = SKAction.colorize(withColorBlendFactor: -0.8, duration: 0.75)
                let bringBack = SKAction.colorize(withColorBlendFactor: 0.8, duration: 1)
                let sequence = SKAction.sequence([makeLighter, bringBack])
                let changeDynamic = SKAction.run({self.lightening1!.physicsBody!.isDynamic = true})
                let brightYellowColor = SKAction.colorize(with: UIColor(red: 255, green: 238, blue: 51), colorBlendFactor: 1, duration: 0)
                let waitASecond = SKAction.wait(forDuration: 0.3)
                let seq = SKAction.sequence([brightYellowColor, waitASecond])
                let groupAction = SKAction.group([changeDynamic, seq])
                self.lightening1!.alpha = 1
                self.bunnyIsProtected = false
                self.lightening1!.run(sequence, completion: {self.lightening1!.run(groupAction, completion: {self.lightening1!.run(SKAction.fadeAlpha(by: -1, duration: 0.2)); self.lightening1!.physicsBody!.isDynamic = false})
                })
            }
            else if rand == 2 {
                let makeLighter = SKAction.colorize(withColorBlendFactor: -0.8, duration: 0.75)
                let bringBack = SKAction.colorize(withColorBlendFactor: 0.8, duration: 1)
                let sequence = SKAction.sequence([makeLighter, bringBack])
                let changeDynamic = SKAction.run({self.lightening2!.physicsBody!.isDynamic = true})
                let brightYellowColor = SKAction.colorize(with: UIColor(red: 255, green: 238, blue: 51), colorBlendFactor: 1, duration: 0)
                let waitASecond = SKAction.wait(forDuration: 0.3)
                let seq = SKAction.sequence([brightYellowColor, waitASecond])
                let groupAction = SKAction.group([changeDynamic, seq])
                self.lightening2!.alpha = 1
                self.bunnyIsProtected = false
                self.lightening2!.run(sequence, completion: {self.lightening2!.run(groupAction, completion: {self.lightening2!.run(SKAction.fadeAlpha(by: -1, duration: 0.2)); self.lightening2!.physicsBody!.isDynamic = false})
                })
            }
            else{
                let makeLighter = SKAction.colorize(withColorBlendFactor: -0.8, duration: 0.75)
                let bringBack = SKAction.colorize(withColorBlendFactor: 0.8, duration: 1)
                let sequence = SKAction.sequence([makeLighter, bringBack])
                let changeDynamic = SKAction.run({self.lightening3!.physicsBody!.isDynamic = true})
                let brightYellowColor = SKAction.colorize(with: UIColor(red: 255, green: 238, blue: 51), colorBlendFactor: 1, duration: 0)
                let waitASecond = SKAction.wait(forDuration: 0.3)
                let seq = SKAction.sequence([brightYellowColor, waitASecond])
                let groupAction = SKAction.group([changeDynamic, seq])
                self.lightening3!.alpha = 1
                self.bunnyIsProtected = false
                self.lightening3!.run(sequence, completion: {self.lightening3!.run(groupAction, completion: {self.lightening3!.run(SKAction.fadeAlpha(by: -1, duration: 0.2)); self.lightening3!.physicsBody!.isDynamic = false})
                })
            }
        }
    }

    
    private func checkLightningHoldCount(){
        var amt = UserDefaults().integer(forKey: "LightningHoldCount")
        amt += 1
        UserDefaults.standard.set(amt, forKey: "LightningHoldCount")
    }
    
    private func makeItRain(){
        rainCheckDispatchCalled = false
        rainFadingOut = false
        makeRainSound()
        rainEmitter = SKEmitterNode(fileNamed: "Rain")
        rainEmitter!.zPosition = 15
        rainEmitter!.position = CGPoint(x: 0, y: size.height)
        self.addChild(rainEmitter!)
        self.run(SKAction.wait(forDuration: 1), completion: {self.listOfSkies[self.savedSky].color = UIColor.gray
            self.listOfSkies[self.savedSky].colorBlendFactor = 0.7})
        let randInt = Int.random(in: 15...30)
        let lightItUp: Double! = Double(randInt)
        self.run(SKAction.wait(forDuration: lightItUp), completion: {self.stopTheRain(); let randNum = Int.random(in: 40...70); self.saveRain = self.scorenum + randNum; self.listOfSkies[self.savedSky].colorBlendFactor = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {self.itsRaining = false})})
    }
    
    
    private func stopTheRain(){
        rainSound?.stop()
        self.rainFadingOut = true
        self.willMakeRain = false
        self.rainEmitter!.removeFromParent()
    }
    

    private func willItRain(){
        if scorenum == 0{
            saveRain = Int.random(in: 30...70)
        }
        else{
            if scorenum == saveRain || scorenum == saveRain + 1{
                if willMakeRain == false && !itsRaining{
                    willMakeRain = true
                    itsRaining = true
                    lighteningTime = true
                    makeItRain()
                }
            }
        }
    }
    
    private func doTheBunnyHop(){
        carrotCounter = false
        savepos += 1
        nextTriple = countTheTriples[savepos]!
        triplesChildren = listOfChildren[savepos]!
        countTheTriples.removeValue(forKey: savepos-1)
        listOfChildren.removeValue(forKey: savepos-1)
        blackCloudList.removeValue(forKey: savepos-1)
        Bunny.move(toParent: nextTriple)
    }
    
    
    private func makeHopSound(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            self.run(SKAction.playSoundFileNamed("BunnyHop.wav", waitForCompletion: false))
        }
    }
    
    
    private func makeBunnyFellSound(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            DispatchQueue.global().async {
            bunnyFellSound?.play()
            }
        }
    }
    
    private func makeRainSound(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            DispatchQueue.global().async {
                rainSound?.play()
            }
        }
    }
    
    
    private func makeLighteningSound(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            DispatchQueue.global().async {
                lighteningSound?.play()
            }
        }
    }
    
    private func createSounds(){
        let pathToSound1 = Bundle.main.path(forResource: "BunnyFell", ofType: "m4a")
        url = URL(fileURLWithPath: pathToSound1!)
        
        let pathToSound2 = Bundle.main.path(forResource: "BunnyDidntHop", ofType: "wav")
        url1 = URL(fileURLWithPath: pathToSound2!)
        
        let pathToSound4 = Bundle.main.path(forResource: "BlackCloud", ofType: "m4a")
        url2 = URL(fileURLWithPath: pathToSound4!)
        
        let pathToSound6 = Bundle.main.path(forResource: "PlaneHit", ofType: "m4a")
        url3 = URL(fileURLWithPath: pathToSound6!)
        
        let pathToSound5 = Bundle.main.path(forResource: "planeSound", ofType: "m4a")
        url4 = URL(fileURLWithPath: pathToSound5!)
        
        let pathToSound7 = Bundle.main.path(forResource: "Splat", ofType: "m4a")
        url5 = URL(fileURLWithPath: pathToSound7!)
        
        let pathToSound8 = Bundle.main.path(forResource: "RainSound", ofType: "m4a")
        url6 = URL(fileURLWithPath: pathToSound8!)
        
        let pathToSound9 = Bundle.main.path(forResource: "Lightening", ofType: "m4a")
        url7 = URL(fileURLWithPath: pathToSound9!)
        
        do{ planeSound = try AVAudioPlayer(contentsOf: url4) }
        catch{}
        planeSound?.prepareToPlay()
        
        do{ planeHitSound = try AVAudioPlayer(contentsOf: url3) }
        catch{}
        planeHitSound?.prepareToPlay()
        
        do{ blackCloudsound = try AVAudioPlayer(contentsOf: url2) }
        catch{}
        blackCloudsound?.prepareToPlay()
        
        do{ bunnyDidntHop = try AVAudioPlayer(contentsOf: url1) }
        catch{}
        bunnyDidntHop?.prepareToPlay()
        
        do{ bunnyFellSound = try AVAudioPlayer(contentsOf: url) }
        catch{}
        bunnyFellSound?.prepareToPlay()
        
        do { splat = try AVAudioPlayer(contentsOf: url5)}
        catch{}
        splat?.prepareToPlay()
        
        do {rainSound = try AVAudioPlayer(contentsOf: url6)}
        catch{}
        rainSound?.prepareToPlay()
        
        do {lighteningSound = try AVAudioPlayer(contentsOf: url7)}
        catch{}
        lighteningSound?.prepareToPlay()
    }
 

    private func setHopSound(_ sound: SKSpriteNode){
        if sound == soundOffButton{
            UserDefaults.standard.set(true, forKey: "SoundOffOrOn")
            soundTrack = true
        }
        else if sound == soundOnButton{
            UserDefaults.standard.set(false, forKey: "SoundOffOrOn")
            soundTrack = false
        }
    }
    
    private func makeCarrotSound(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            self.run(SKAction.playSoundFileNamed("GetCarrot.m4a", waitForCompletion: false))
        }
    }
    
    private func makeBunnyDidntHop(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            DispatchQueue.global().async {
            bunnyDidntHop?.play()
            }
        }
    }
    
    private func makeblackCloudSound(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            DispatchQueue.global().async {
            blackCloudsound?.play()
            }
        }
    }
    
    private func makePlaneSound(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            DispatchQueue.global().async {
                planeSound?.play()
            }
        }
    }
    
    private func planeHitBunny(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            planeSound?.stop()
            DispatchQueue.global().async {
                planeHitSound?.play()
            }
        }
    }
    
    private func makeBirdChirp(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            self.run(SKAction.playSoundFileNamed("Chirp.m4a", waitForCompletion: false))
        }
    }
    
    private func makeSplatSound(){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true && soundTrack{
            DispatchQueue.global().async {
                splat?.play()
            }
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
        removeSwipeTexts()
        lighteningHoldIt = false
        for touch in touches{
            let local = touch.location(in: self)
            if bunnysdone == true{
                if playAgain.contains(local) && !playAgain.hasActions(){
                    theBlender(runActionOn: playAgain)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "RemoveBannerAdShow"), object: self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.14, execute: {
                            self.restartGame()
                    })
                }
                if mainMenu.contains(local) && !mainMenu.hasActions(){
                    theBlender(runActionOn: mainMenu)
                    if GameScore.playerIsAuthentic{
                     GameScore.gameCenterButton.removeTarget(self, action: #selector(self.sendGameCenterNotification), for: .touchUpInside)
                        GameScore.gameCenterButton.removeFromSuperview()}
                     removeGestureRecognizers()
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "RemoveBannerAdShow"), object: self)
                    let playScene = PlayScene(fileNamed: "PlayScene")
                    let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                    DispatchQueue.global().async {
                        self.scene?.view?.presentScene(playScene!, transition: fadeAway)
                    }
                }
                if earn10Carrots.contains(local) && earn10Carrots.alpha == 1{
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "RewardShow"), object: self)
                }
            }
            else if bunnysdone == false {
                if Bird.contains(local) && self.isPaused == false{
                    birdCanPoo = false
                    birdTap = true
                    tapBird?.removeFromParent()
                    if shouldTrackBird{
                        var amt = UserDefaults().integer(forKey: "BirdTapCount")
                        amt += 1
                        UserDefaults.standard.set(amt, forKey: "BirdTapCount")
                    }
                    if firstBirdTap{
                        Bird.xScale = Bird.xScale * -1
                        if Bird.xScale > 0{
                            firstBirdTap = false
                            let flight: CGFloat = self.frame.width/2 + Bird.frame.width
                            Bird.removeAction(forKey: "Firstflight")
                            let flapWings = SKAction.animate(with: BirdTextureArray, timePerFrame: Double(2.8) / (Double(BirdTextureArray.count) * 10))
                            let moveDist = SKAction.moveTo(x: flight, duration: Double(flight * 0.0075))
                            let flapForever = SKAction.repeatForever(flapWings)
                            let remove = SKAction.removeFromParent()
                            let groupMove = SKAction.group([moveDist, flapForever])
                            Bird.run(SKAction.sequence([groupMove, remove]))
                        }
                        else{
                            firstBirdTap = false
                            let flight: CGFloat = -self.frame.width/2 - Bird.frame.width
                            Bird.removeAction(forKey: "Firstflight")
                            let flapWings = SKAction.animate(with: BirdTextureArray, timePerFrame: Double(2.8) / (Double(BirdTextureArray.count) * 10))
                            let moveDist = SKAction.moveTo(x: flight, duration: Double(flight * -0.0075))
                            let flapForever = SKAction.repeatForever(flapWings)
                            let remove = SKAction.removeFromParent()
                            let groupMove = SKAction.group([moveDist, flapForever])
                            Bird.run(SKAction.sequence([groupMove, remove]))
                        }
                    }
                }
            
                else{birdTap = false
                }
                if lightening1!.contains(local) || lightening2!.contains(local) || lightening3!.contains(local) {
                        lighteningTap = true
                }
                else {lighteningTap = false}
                if !pauseButton.contains(local) && playButton.parent != nil{
                    pausedAfterOpening = true
                }
                else if !pauseButton.contains(local){
                    pauseCounter = false
                }
                if pauseButton.contains(local) && self.isPaused == false && !leftGame{
                    pauseButton.removeFromParent()
                    if playButton.parent == nil{
                        createPlayButton()}
                    pauseCounter = true
                    self.isPaused = true
                    if planeSound!.isPlaying{
                        planeSound?.pause(); planeSoundPaused = true
                    }
                    if rainSound!.isPlaying{
                        rainSound?.pause(); rainSoundPaused = true
                    }
                }
                else if playButton.contains(local) && self.isPaused == true {
                    leftGame = false
                    self.isPaused = false
                    if UserDefaults().bool(forKey: "SoundOffOrOn") == true{
                        soundTrack = true
                    if planeSoundPaused{planeSound?.play(); planeSoundPaused = false}
                    }
                    if rainSoundPaused{rainSound?.play(); rainSoundPaused = false}
                    pausedAfterOpening = false
                    playButton.removeFromParent()
                    if pauseButton.parent == nil{
                        createpauseButton()}
                }
                if !soundOnButton.contains(local) && !soundOffButton.contains(local){
                    bunnyMoveWithSound = true
                }
                else {bunnyMoveWithSound = false}
                if let _ = soundOnButton.parent{
                    if soundOnButton.contains(local){
                        setHopSound(soundOnButton)
                        soundOnButton.removeFromParent()
                        makeSoundOffButton()
                    }
                }
                else if let _ = soundOffButton.parent{
                    if soundOffButton.contains(local){
                        setHopSound(soundOffButton)
                        soundOffButton.removeFromParent()
                        makeSoundOnButton()
                    }
                }
                if let _ = smallBunnyImage{
                    if smallBunnyImage!.contains(local) && !smallBunnyImage!.hasActions(){
                        if UserDefaults().bool(forKey: "VisitedStore") == false{
                            var firstthree = UserDefaults().integer(forKey: "VisitedStoreInt")
                            firstthree += 1
                            UserDefaults.standard.set(firstthree, forKey: "VisitedStoreInt")
                        }
                        theBlender(runActionOn: smallBunnyImage!)
                        theBlender(runActionOn: miniCloud!)
                        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
                        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                            self.transitionToStoreScene()
                        })
                    }
                }
                else if let _ = miniCloud{
                    if miniCloud!.contains(local) && !miniCloud!.hasActions(){
                         if UserDefaults().bool(forKey: "VisitedStore") == false{
                            var firstthree = UserDefaults().integer(forKey: "VisitedStoreInt")
                            firstthree += 1
                            UserDefaults.standard.set(firstthree, forKey: "VisitedStoreInt")
                        }
                        theBlender(runActionOn: smallBunnyImage!)
                        theBlender(runActionOn: miniCloud!)
                        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
                        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                            self.transitionToStoreScene()
                        })
                    }
                }
            }
            if firsttouch == false && !smallBunnyImage!.contains(local) && !miniCloud!.contains(local){
                firsttouch = true
                let spawn = SKAction.run({
                    () in
                    self.createClouds()
                })
                let delay = SKAction.wait(forDuration: cloudDelayTime)
                let spawnDelay = SKAction.sequence([spawn, delay])
                let spawnDelayForever = SKAction.repeatForever(spawnDelay)
                self.run(spawnDelayForever)
                setUpScore()
                setUpCarrotScore()
                createpauseButton()
                if UserDefaults().bool(forKey: "SoundOffOrOn") == true{
                    makeSoundOnButton()}
                else{makeSoundOffButton()}
                gameIsActive = true
                let fadeAlph = SKAction.fadeAlpha(by: -1, duration: 1)
                let remove = SKAction.removeFromParent(); let groupThem = SKAction.sequence([fadeAlph, remove])
                touchToStart.run(groupThem)
                let fadeAway = SKAction.fadeOut(withDuration: 1)
                let seque = SKAction.sequence([fadeAway, remove])
                smallBunnyImage!.run(seque, completion: {self.smallBunnyImage = nil})
                miniCloud!.run(seque, completion: {self.miniCloud = nil})
                arrow?.run(seque, completion: {self.arrow = nil})
                visitBunnyStore?.run(seque, completion: {self.visitBunnyStore = nil})
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
    
    
    @IBAction func tapPiece(_ gestureRecognizer : UITapGestureRecognizer ) {
    guard gestureRecognizer.view != nil else { return }
    guard pauseCounter == false && bunnyMoveWithSound == true else { return }
    guard pausedAfterOpening == false else {return}
    guard bunnysdone == false else { return }
    guard birdTap == false && lighteningHoldIt == false else { return}
        upOrDownSwipe = false
        if firsttouch == true && gestureRecognizer.state == .ended {
            if onACloud == true {
                if inRange(Bunny.parent!){
                    if expectedDirection == "forward"{tapCounter += 1}
                    let thispos = countTheTriples[savepos]!!.position.y
                    let thatpos = countTheTriples[savepos+1]!!.position.y
                    let distBetween = thatpos - thispos
                    let moveIt = SKAction.moveBy(x: 0, y: distBetween, duration:bunnyHopTime)
                    let hopIt = SKAction.animate(with: RabbitTextureArray, timePerFrame: bunnyHopTime / Double(RabbitTextureArray.count))
                    let thegroup = SKAction.group([moveIt, hopIt])
                    makeHopSound()
                    Bunny.run(thegroup)
                    doTheBunnyHop()
                    chooseSky()
                    airPlanePass()
                    willItRain()
                    changeTheSpeed()
                }
            }
        }
    }
       

    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        guard pauseCounter == false && bunnyMoveWithSound == true else { return }
        guard pausedAfterOpening == false else {return}
        guard bunnysdone == false else { return }
        guard birdTap == false else {return}
        upOrDownSwipe = false
        let firstThirdWidth = self.frame.width / 3
        gestureRecognizer.isEnabled = true
        if firsttouch == true{
            if gestureRecognizer.state == .ended {
                if onACloud == true {
                    switch gestureRecognizer.direction{
                    case .left:
                        if inRange(Bunny.parent!) && bunnyInRangeLeft(Bunny){
                            if expectedDirection == "left"{leftSwipeCounter += 1}
                            let thispos = countTheTriples[savepos]!!.position.y
                            let thatpos = countTheTriples[savepos+1]!!.position.y
                            let distBetween = thatpos - thispos
                            rotateRabbit(recognizerDirection: .left)
                            let moveIt = SKAction.moveBy(x: -firstThirdWidth, y: distBetween, duration:bunnyHopTime)
                            let hopIt = SKAction.animate(with: RabbitTextureArray, timePerFrame: bunnyHopTime / Double(RabbitTextureArray.count))
                            let thegroup = SKAction.group([moveIt, hopIt])
                            makeHopSound()
                            Bunny.run(thegroup)
                            doTheBunnyHop()
                            airPlanePass()
                            chooseSky()
                            willItRain()
                            changeTheSpeed()
                        }
                    case .right:
                        if inRange(Bunny.parent!) && bunnyInRangeRight(Bunny){
                            if expectedDirection == "right"{rightSwipeCounter += 1}
                            let thispos = countTheTriples[savepos]!!.position.y
                            let thatpos = countTheTriples[savepos+1]!!.position.y
                            let distBetween = thatpos - thispos
                            rotateRabbit(recognizerDirection: .right)
                            let moveIt = SKAction.moveBy(x: firstThirdWidth, y: distBetween, duration:bunnyHopTime)
                            let hopIt = SKAction.animate(with: RabbitTextureArray, timePerFrame: bunnyHopTime / Double(RabbitTextureArray.count))
                            let thegroup = SKAction.group([moveIt, hopIt])
                            makeHopSound()
                            Bunny.run(thegroup)
                            doTheBunnyHop()
                            chooseSky()
                            airPlanePass()
                            willItRain()
                            changeTheSpeed()
                        }
                    case .up:
                    upOrDownSwipe = true
                    if isOnCloud!.name!.hasSuffix("d3"){
                        if inRange(Bunny.parent!) && bunnyInFarRangeRight(Bunny) {
                            if expectedDirection == "up"{upSwipeRightCounter += 1}
                            let thispos = countTheTriples[savepos]!!.position.y
                            let thatpos = countTheTriples[savepos+1]!!.position.y
                            let distBetween = thatpos - thispos
                            rotateRabbit(recognizerDirection: .up)
                            let moveIt = SKAction.moveBy(x: -2 * firstThirdWidth, y: distBetween, duration:bunnyHopTime)
                            let hopIt = SKAction.animate(with: RabbitTextureArray, timePerFrame: bunnyHopTime / Double(RabbitTextureArray.count))
                            let thegroup = SKAction.group([moveIt, hopIt])
                            makeHopSound()
                            Bunny.run(thegroup)
                            doTheBunnyHop()
                            chooseSky()
                            changeTheSpeed()
                            willItRain()
                            airPlanePass()
                        }
                    }
                    else if isOnCloud!.name!.hasSuffix("d1"){
                        if inRange(Bunny.parent!) && inFarRangeLeft(Bunny){
                            if expectedDirection == "up"{upSwipeLeftCounter += 1}
                            let thispos = countTheTriples[savepos]!!.position.y
                            let thatpos = countTheTriples[savepos+1]!!.position.y
                            let distBetween = thatpos - thispos
                            rotateRabbit(recognizerDirection: .up)
                            let moveIt = SKAction.moveBy(x: 2 * firstThirdWidth, y: distBetween, duration:bunnyHopTime)
                            let hopIt = SKAction.animate(with: RabbitTextureArray, timePerFrame: bunnyHopTime / Double(RabbitTextureArray.count))
                            let thegroup = SKAction.group([moveIt, hopIt])
                            makeHopSound()
                            Bunny.run(thegroup)
                            doTheBunnyHop()
                            chooseSky()
                            airPlanePass()
                            willItRain()
                            changeTheSpeed()
                        }
                    }
                    default:
                        break
                    }
                }
            }
        }
    }
    
    @IBAction func lighteningHold(_ gestureRecognizer: UILongPressGestureRecognizer){
        guard gestureRecognizer.view != nil else { return }
        if gestureRecognizer.state == .began{
             lighteningHoldIt = true
        }
        guard pauseCounter == false && bunnyMoveWithSound == true else { return }
        guard pausedAfterOpening == false else {return}
        guard bunnysdone == false else { return }
        guard lighteningTap else { return }
        if lightening1!.alpha > 0{
            bunnyIsProtected = true
            if shouldTrackLightning{if UserDefaults().integer(forKey: "LightningHoldCount") <= 4{checkLightningHoldCount()}}
            lightening1!.run(SKAction.fadeAlpha(by: -1, duration: 0))
        }
        else if lightening2!.alpha > 0{
            bunnyIsProtected = true
         if shouldTrackLightning{if UserDefaults().integer(forKey: "LightningHoldCount") <= 4{checkLightningHoldCount()}}
        lightening2!.run(SKAction.fadeAlpha(by: -1, duration: 0))
        }
        else if lightening3!.alpha > 0{
            bunnyIsProtected = true
         if shouldTrackLightning{if UserDefaults().integer(forKey: "LightningHoldCount") <= 4{checkLightningHoldCount()}}
            lightening3!.run(SKAction.fadeAlpha(by: -1, duration: 0))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        scorenum = savepos
        theCountFirstIf: if countfirst > 0 && bunnysdone == false{
        if samePos(bunny: Bunny, cloudpos1: triplesChildren[0], cloudpos2: triplesChildren[1], cloudpos3: triplesChildren[2]){
            onACloud = true
            if allSwipes == false{
                if !toldDirection{
                    dictateDirection()
                }
            }
            let num = isOnCloud!.name!.count
            let name = Int(String(isOnCloud!.name![num - 1]))
            blackCloudChecker: if let _ = blackCloudList[savepos]![name!-1]{
                if isOnCloud!.name!.hasSuffix("d2") && upOrDownSwipe{
                    break blackCloudChecker
                }
                isOnCloud!.run(SKAction.fadeOut(withDuration: 1))
                Bunny.run(SKAction.fadeOut(withDuration: 1))
                if resetCalled == false{
                    bunnysdone = true
                    makeblackCloudSound()
                    let currentCarrotCount = UserDefaults().integer(forKey: "CarrotCount")
                    UserDefaults.standard.set(currentCarrotCount + carrotsNum, forKey: "CarrotCount")
                    scorenum = savepos - 1
                    combinedScoreNum = carrotsNum + scorenum
                    resetCalled = true
                    if rainSound!.isPlaying{
                        rainSound!.setVolume(0, fadeDuration: 3)
                    }
                    restartButton()
                    break theCountFirstIf
                }
            }
            if !carrotCounter{
                checkBunnyCarrotPos()
                carrotCounter = true
            }
            score!.text = "Hops: " + String(scorenum)
        }
        else {onACloud = false
            toldDirection = false
            if !Bunny.hasActions() {
                if resetCalled == false{
                    bunnysdone = true
                    makeBunnyFellSound()
                    Bunny.run(SKAction.fadeOut(withDuration: 1))
                    let currentCarrotCount = UserDefaults().integer(forKey: "CarrotCount")
                    UserDefaults.standard.set(currentCarrotCount + carrotsNum, forKey: "CarrotCount")
                    resetCalled = true
                    scorenum = savepos-1
                    combinedScoreNum  = carrotsNum + scorenum
                    if rainSound!.isPlaying{
                        rainSound!.setVolume(0, fadeDuration: 3)
                    }
                    restartButton()
                }
            }
        }
        let convertedBunnyPos = self.convert(Bunny.position, from: Bunny.parent!)
        if convertedBunnyPos.y < -self.frame.height / 2 + Bunny.frame.height / 2{
            if resetCalled == false{
                bunnysdone = true
                makeBunnyDidntHop()
                Bunny.run(SKAction.fadeOut(withDuration: 1))
                let currentCarrotCount = UserDefaults().integer(forKey: "CarrotCount")
                UserDefaults.standard.set(currentCarrotCount + carrotsNum, forKey: "CarrotCount")
                resetCalled = true
                combinedScoreNum = carrotsNum + scorenum
                if rainSound!.isPlaying{
                    rainSound!.setVolume(0, fadeDuration: 3)
                }
                restartButton()
            }
        }
    }
        if let plane = airPlane{
            if airPlaneHitBunny{
                if resetCalled == false{
                    bunnysdone = true;
                    Bunny.run(SKAction.fadeOut(withDuration: 1))
                    let currentCarrotCount = UserDefaults().integer(forKey: "CarrotCount")
                    UserDefaults.standard.set(currentCarrotCount + carrotsNum, forKey: "CarrotCount")
                    combinedScoreNum = carrotsNum + scorenum; resetCalled = true;
                    if rainSound!.isPlaying{
                        rainSound!.setVolume(0, fadeDuration: 3)
                    }
                    restartButton()
                }
            }
            else{
                if !itsRaining{
                    if airPlanesAlive{
                        let randN:CGFloat! = CGFloat(Float.random(in: 20...150))
                        if plane.xScale == airPlaneXScale{
                            if plane.position.x > self.frame.width/2 + randN{
                                let randInt = Int.random(in: 1...3)
                                airPlanesAlive = false
                                if randInt > 1{
                                    makeBird()
                                }
                            }
                        }
                        else{
                            if plane.position.x < -self.frame.width/2 - randN{
                                let randInt = Int.random(in: 1...3)
                                airPlanesAlive = false
                                if randInt < 3{
                                    makeBird()
                                }
                            }
                        }
                    }
                }
            }
            if Bird.hasActions() && birdCanPoo{
                if birdHasReachedPoint{
                    if !ranWasCalled{
                        let lowerBound = Float(-self.frame.width/2 + 50); let upperBound = Float(self.frame.width/2 - 50)
                        pooPooPos = Float.random(in: lowerBound...upperBound)
                        ranWasCalled = true
                    }
                    if CGFloat(pooPooPos) + 15 > Bird.position.x && CGFloat(pooPooPos) - 15 < Bird.position.x {
                        makeBirdPoop()
                        ranWasCalled = false
                        pooCount += 1
                        if pooCount > 3{
                            pooCount = 0
                            birdHasReachedPoint = false
                    }
                }
            }
        }
        if itsRaining && lighteningTime{
            let lightItUp = Int.random(in: 2...3)
            let waitForLightening = SKAction.wait(forDuration: TimeInterval(lightItUp))
            self.run(waitForLightening, completion: {self.makeLightening()})
            lighteningTime = false
            let time = Int.random(in: 4...9)
            let lightUp:Double! = Double(time)
            self.run(SKAction.wait(forDuration: lightUp), completion: {self.lighteningTime = true})
        }
    }
        if bunnysdone == true{
            if calledBunnysDone == false{
                self.removeAllActions()
                calledBunnysDone = true
            }
        }
    }
}
