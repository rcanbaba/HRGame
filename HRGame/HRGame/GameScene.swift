//
//  GameScene.swift
//  HRGame
//
//  Created by Can Babaoğlu on 24.08.2019.
//  Copyright © 2019 Can Babaoğlu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var pauseStageButtonNode:SKSpriteNode!
    var playStageButtonNode:SKSpriteNode!
    var balls = ["ballRed","ballBlue","ballCyan","ballGreen","ballGrey","ballPurple","ballYellow"]
    let userDefaults = UserDefaults.standard
    var starfield:SKEmitterNode!
    var character:SKSpriteNode = SKSpriteNode()
    var characterPosition = CGPoint()
    var pad:SKSpriteNode = SKSpriteNode()
    var startTouch = CGPoint()
    var stage2timer:Timer!
    var buttonTimer:Timer!
    var scoreLabel: SKLabelNode!
    var stageKey = Int(0)
    var lineCount = Int(0)
    var score = 0{
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var stageLabel: SKLabelNode!
    var stageCount = 0{
        didSet {
            stageLabel.text = "Stage: \(stageCount)"
        }
    }
    var getPointLabel: SKLabelNode!
    var getPoint = 0 {
        didSet {
            getPointLabel.text = " + \(getPoint)"
        }
    }
    var colorButton1:SKSpriteNode = SKSpriteNode()
    var colorButton2:SKSpriteNode = SKSpriteNode()
    var colorButton3:SKSpriteNode = SKSpriteNode()
    var colorButton4:SKSpriteNode = SKSpriteNode()
    var colorButton5:SKSpriteNode = SKSpriteNode()
    var colorButtonLabel1:SKLabelNode = SKLabelNode()
    var colorButtonLabel2:SKLabelNode = SKLabelNode()
    var colorButtonLabel3:SKLabelNode = SKLabelNode()
    var colorButtonLabel4:SKLabelNode = SKLabelNode()
    var colorButtonLabel5:SKLabelNode = SKLabelNode()
    var colorQuestionLabel:SKLabelNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        stageKey = userDefaults.integer(forKey: "stageKey")
        
        linkButton()
        
        pauseStageButtonNode = (self.childNode(withName: "pauseStageButton") as! SKSpriteNode)
        playStageButtonNode = (self.childNode(withName: "playStageButton") as! SKSpriteNode)
        
//        starfield = (self.childNode(withName: "starfield") as! SKEmitterNode)
//        starfield.advanceSimulationTime(10)
//        self.addChild(starfield)
//        starfield.zPosition = -1
        
        
//        let background = SKSpriteNode(imageNamed: "background")
//        background.size.height = 1500
//        background.position = CGPoint(x: 0, y: 0)
//        background.blendMode = .replace
//        background.zPosition = -3
//        addChild(background)
        
        let background = SKSpriteNode(imageNamed: "background2")
        background.size.width = self.frame.size.width * 1.7
        background.size.height = self.frame.size.height * 1.5
        background.position = CGPoint(x: (frame.size.width / 2) - 190, y: (frame.size.height / 2) - 160)
        background.zPosition = -3
        addChild(background)
        
        let dollar = SKSpriteNode(imageNamed: "dollar")
        dollar.size.height = dollar.size.height / 2.0
        dollar.size.width = dollar.size.width / 2.0
        dollar.position = CGPoint(x: -180, y: 600)
        //background.blendMode = .replace
        dollar.zPosition = 1
        addChild(dollar)
        
        let star = SKSpriteNode(imageNamed: "star")
        star.size.height = star.size.height / 2.0
        star.size.width = star.size.width / 2.0
        star.position = CGPoint(x: 180, y:600 )
        //background.blendMode = .replace
        star.zPosition = 1
        addChild(star)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 135, y: 590)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
        stageLabel = SKLabelNode(fontNamed: "Chalkduster")
        stageLabel.text = "Stage: 0"
        stageLabel.horizontalAlignmentMode = .left
        stageLabel.position = CGPoint(x: -255, y: 590)
        stageLabel.zPosition = 2
        addChild(stageLabel)
        
        getPointLabel = SKLabelNode(fontNamed: "Chalkduster")
        getPointLabel.text = "Point"
        getPointLabel.fontSize = 60
        getPointLabel.horizontalAlignmentMode = .left
        getPointLabel.position = CGPoint(x: -60, y: 480)
        addChild(getPointLabel)
        
        //physicsBody = SKPhysicsBody (edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        if let somePlayer:SKSpriteNode = self.childNode(withName: "player") as? SKSpriteNode{
            character = somePlayer
            print("that worked")
        }else{
            print("that failed")
        }
        character.name = "character"
        //character.physicsBody = SKPhysicsBody( rectangleOf: character.size)
        character.physicsBody?.isDynamic = false
        //self.addChild(character)
        
        if let someNode:SKSpriteNode = self.childNode(withName: "pad") as? SKSpriteNode{
            pad = someNode
            print("that worked")
        }
        
        if(stageKey == 1 ){
            nextRow(row: stageCount+1)
        }else if(stageKey == 2){
            isHiddenColorLabels(status: true)
            isHiddenColorButtons(status: true)
            isHiddenColorQuestion(status: false)
            stage2timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addNewLine), userInfo: nil, repeats: true)
        }else if(stageKey == 3){
            stage2timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(addNewLine), userInfo: nil, repeats: true)
            
//  MARK: --------------- BURDA KALDIM ---------------
            
            
            
        }
    }
//  MARK: STAGE leri yukarda ayarla ---------------
    
//  MARK: Touches Catch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            startTouch = location
            characterPosition = character.position
            
            let nodesArray = self.nodes(at: location)
            if (nodesArray.first?.name == "colorBtn1" || nodesArray.first?.name == "clrBtnLbl1"){
                colorButton1.texture = SKTexture(imageNamed: "colorBtnPushed")
            }else if(nodesArray.first?.name == "colorBtn2" || nodesArray.first?.name == "clrBtnLbl2"){
                colorButton2.texture = SKTexture(imageNamed: "colorBtnPushed")
            }else if(nodesArray.first?.name == "colorBtn3" || nodesArray.first?.name == "clrBtnLbl3"){
                colorButton3.texture = SKTexture(imageNamed: "colorBtnPushed")
            }else if(nodesArray.first?.name == "colorBtn4" || nodesArray.first?.name == "clrBtnLbl4"){
                colorButton4.texture = SKTexture(imageNamed: "colorBtnPushed")
            }else if(nodesArray.first?.name == "colorBtn5" || nodesArray.first?.name == "clrBtnLbl5"){
                colorButton5.texture = SKTexture(imageNamed: "colorBtnPushed")
            }else if(nodesArray.first?.name == "pauseStageButton" ){
                self.scene?.view?.isPaused = true
                stage2timer.invalidate()
            }else if(nodesArray.first?.name == "playStageButton" ){
                self.scene?.view?.isPaused = false
                stage2timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addNewLine), userInfo: nil, repeats: true)
            }
            buttonTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(buttonReloader), userInfo: nil, repeats: true)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            character.run(SKAction.move(to: CGPoint(x:  characterPosition.x + location.x - startTouch.x, y: -270), duration: 0.1))
        }
    }
//
    @objc func addNewLine(){ //count koy ona ulaşınca girmeyi bıraksın
        
        if (lineCount > 18) { // 20 olur
            stage2timer!.invalidate()
        }
        let ballCount = Int.random(in: 2 ... 5)
        addLine(bCount: ballCount)
        lineCount = lineCount + 1
    }
//  MARK: Set Lines ******************
    func addLine(bCount: Int){
  // initX & deltaX setted for ball positions
        var random: Int!
        var initX: Int!
        var deltaX: Int!
        if(bCount == 2){
            initX = -200
            deltaX = 400
        }else if(bCount == 3){
            initX = -250
            deltaX = 250
        }else if(bCount == 4){
            initX = -270
            deltaX = 180
        }else if(bCount == 5){
            initX = -300
            deltaX = 150
        }else{
            print("Error: inRandom line generator")
        }
        
        for _ in 0..<bCount{
            random =  Int.random(in: 0 ... 6)
            addBallwithoutSize(at: CGPoint (x: initX, y: 640), name: balls[random])
            initX = initX + deltaX
            if(stageKey == 3){
                addButton(buttonCount: bCount+1, name: balls[random])
            }
        }
    }
  
//  MARK: Stage 2 içim yazıldı
    func addBallwithoutSize (at position: CGPoint, name: String) {
        let ball = SKSpriteNode(imageNamed: name)
        ball.name = name
        ball.size = CGSize(width: 90, height: 90)
        ball.position = position
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.restitution = 0.4
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        addChild(ball)
    }
    
//  MARK: Stage 3 Colour Test alanı
    func addButton (buttonCount: Int, name: String) {
        
        
    }
        
    
//  MARK: Eski yöntemler -----------------
    func addBall (at position: CGPoint, name: String, size: CGSize) {
        let ball = SKSpriteNode(imageNamed: name)
        ball.name = name
        ball.size = size
        ball.position = position
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.restitution = 0.4
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        addChild(ball)
    }

    
//  MARK: ************ AFTER COLLISION ***********
    func collisionBetween(character: SKNode, ball: SKNode) {
        //pad.zPosition = 2
        let randomNumber = Int.random(in: 1 ... 10)
        switch ball.name {
        case "ballRed":
            getPoint = scoreCalculate(ballName: "ballRed", randomNo: randomNumber)
            score = score + getPoint
            destroy(ball: ball)
        case "ballBlue":
            getPoint = scoreCalculate(ballName: "ballBlue", randomNo: randomNumber)
            destroy(ball: ball)
            score = score + getPoint
        case "ballCyan":
            getPoint = scoreCalculate(ballName: "ballCyan", randomNo: randomNumber)
            destroy(ball: ball)
            score = score + getPoint
        case "ballGreen":
            getPoint = scoreCalculate(ballName: "ballGreen", randomNo: randomNumber)
            destroy(ball: ball)
            score = score + getPoint
        case "ballGrey":
            getPoint = scoreCalculate(ballName: "ballGrey", randomNo: randomNumber)
            destroy(ball: ball)
            score = score + getPoint
        case "ballPurple":
            getPoint = scoreCalculate(ballName: "ballPurple", randomNo: randomNumber)
            destroy(ball: ball)
            score = score + getPoint
        case "ballYellow":
            getPoint = scoreCalculate(ballName: "ballYellow", randomNo: randomNumber)
            destroy(ball: ball)
            score = score + getPoint
        default:
            print("farklı bir şey çarptı!!!")
        }
        stageCount = stageCount + 1
        if(stageKey == 1){
            nextRow(row: stageCount)
        }
        
    }
    
    
    func scoreCalculate(ballName: String, randomNo: Int) -> Int {
        
        switch ballName {
        case "ballGrey":
            return 1
        case "ballCyan":
            switch randomNo {
            case 1:
                return 0
            case 2:
                return 0
            case 3:
                return 0
            case 4:
                return 0
            case 5:
                return 2
            case 6:
                return 2
            case 7:
                return 2
            case 8:
                return 2
            case 9:
                return 2
            case 10:
                return 2
            default:
                print("farklı bir şey çarptı!!!")
            }
        case "ballBlue":
            switch randomNo {
            case 1:
                return 0
            case 2:
                return 0
            case 3:
                return 0
            case 4:
                return 0
            case 5:
                return 0
            case 6:
                return 3
            case 7:
                return 3
            case 8:
                return 3
            case 9:
                return 3
            case 10:
                return 3
            default:
                print("farklı bir şey çarptı!!!")
            }

        case "ballYellow":
            switch randomNo {
            case 1:
                return 0
            case 2:
                return 0
            case 3:
                return 0
            case 4:
                return 0
            case 5:
                return 0
            case 6:
                return 0
            case 7:
                return 5
            case 8:
                return 5
            case 9:
                return 5
            case 10:
                return 5
            default:
                print("farklı bir şey çarptı!!!")
            }

        case "ballGreen":
            switch randomNo {
            case 1:
                return 0
            case 2:
                return 0
            case 3:
                return 0
            case 4:
                return 0
            case 5:
                return 0
            case 6:
                return 0
            case 7:
                return 0
            case 8:
                return 10
            case 9:
                return 10
            case 10:
                return 10
            default:
                print("farklı bir şey çarptı!!!")
            }

        case "ballPurple":
            switch randomNo {
            case 1:
                return 0
            case 2:
                return 0
            case 3:
                return 0
            case 4:
                return 0
            case 5:
                return 0
            case 6:
                return 0
            case 7:
                return 0
            case 8:
                return 0
            case 9:
                return 15
            case 10:
                return 15
            default:
                print("farklı bir şey çarptı!!!")
            }

        case "ballRed":
            switch randomNo {
            case 1:
                return 0
            case 2:
                return 0
            case 3:
                return 0
            case 4:
                return 0
            case 5:
                return 0
            case 6:
                return 0
            case 7:
                return 0
            case 8:
                return 0
            case 9:
                return 0
            case 10:
                return 20
            default:
                print("farklı bir şey çarptı!!!")
            }
        default:
            print("farklı bir şey çarptı!!!")
        }
        
        return 0
        
    }
        
    
//  MARK: Eski Yöntemler
    func nextRow(row: Int){
        if (row == 1){
            physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
        }else if(row == 2){
            physicsWorld.gravity = CGVector(dx: 0, dy: -15.8)
            addBall(at: CGPoint (x: -200, y: 640), name: "ballRed", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  200, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
        }else if(row == 3){
            physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
            addBall(at: CGPoint (x: -200, y: 640), name: "bouncer", size: CGSize(width: 150, height: 150))
            addBall(at: CGPoint (x:  200, y: 640), name: "spark", size: CGSize(width: 200, height: 200))
        }else if(row == 4){
            physicsWorld.gravity = CGVector(dx: 0, dy: -7.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  -90, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:   90, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  270, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 5){
            addBall(at: CGPoint (x: -200, y: 640), name: "bouncer", size: CGSize(width: 150, height: 150))
            addBall(at: CGPoint (x:  200, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
        }else if(row == 6){
            physicsWorld.gravity = CGVector(dx: 0, dy: -12.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 7){
            physicsWorld.gravity = CGVector(dx: 0, dy: -19.8)
            addBall(at: CGPoint (x: -200, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  200, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 8){
            physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballRed", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "spark", size: CGSize(width: 200, height: 200))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 9){
            physicsWorld.gravity = CGVector(dx: 0, dy: -12.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballCyan", size: CGSize(width: 90, height: 90))
        }else if(row == 10){
            physicsWorld.gravity = CGVector(dx: 0, dy: -8.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  -90, y: 640), name: "ballCyan", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:   90, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  270, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
        }else if(row == 11){
            physicsWorld.gravity = CGVector(dx: 0, dy: -18.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "bouncer", size: CGSize(width: 150, height: 150))
        }else if(row == 12){
            physicsWorld.gravity = CGVector(dx: 0, dy: -5.8)
            addBall(at: CGPoint (x: -300, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x: -150, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  150, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  300, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
        }else if(row == 13){
            physicsWorld.gravity = CGVector(dx: 0, dy: -15.8)
            addBall(at: CGPoint (x: -200, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  200, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 14){
            physicsWorld.gravity = CGVector(dx: 0, dy: -8.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  -90, y: 640), name: "ballCyan", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:   90, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  270, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
        }else if(row == 15){
            physicsWorld.gravity = CGVector(dx: 0, dy: -7.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballRed", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
        }else if(row == 16){
            physicsWorld.gravity = CGVector(dx: 0, dy: -5.8)
            addBall(at: CGPoint (x: -300, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x: -150, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  150, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  300, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
        }else if(row == 17){
            physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "ballCyan", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  -90, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:   90, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  270, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
        }else if(row == 18){
            physicsWorld.gravity = CGVector(dx: 0, dy: -7.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballRed", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
        }else if(row == 19){
            physicsWorld.gravity = CGVector(dx: 0, dy: -15.8)
            addBall(at: CGPoint (x: -200, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  200, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 20){
            physicsWorld.gravity = CGVector(dx: 0, dy: -8.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  -90, y: 640), name: "ballCyan", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:   90, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  270, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
        }else if(row == 21){
            physicsWorld.gravity = CGVector(dx: 0, dy: -8.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballRed", size: CGSize(width: 90, height: 90))
        }else if(row == 22){
            physicsWorld.gravity = CGVector(dx: 0, dy: -15.8)
            addBall(at: CGPoint (x: -200, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  200, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 23){
            physicsWorld.gravity = CGVector(dx: 0, dy: -19.8)
            addBall(at: CGPoint (x: -200, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  200, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 24){
            physicsWorld.gravity = CGVector(dx: 0, dy: -7.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballCyan", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
        }else if(row == 25){
            physicsWorld.gravity = CGVector(dx: 0, dy: -5.8)
            physicsWorld.gravity = CGVector(dx: 0, dy: -7.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballRed", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
        }else if(row == 26){
            physicsWorld.gravity = CGVector(dx: 0, dy: -19.8)
            addBall(at: CGPoint (x: -200, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  200, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 27){
            physicsWorld.gravity = CGVector(dx: 0, dy: -12.8)
            addBall(at: CGPoint (x: -0, y: 640), name: "bouncer", size: CGSize(width: 150, height: 150))
        }else if(row == 28){
            physicsWorld.gravity = CGVector(dx: 0, dy: -7.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  -90, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:   90, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  270, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 29){
            physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 30){
            physicsWorld.gravity = CGVector(dx: 0, dy: -5.8)
            addBall(at: CGPoint (x: -300, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x: -150, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  150, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  300, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
        }else if(row == 31){
            physicsWorld.gravity = CGVector(dx: 0, dy: -7.8)
            addBall(at: CGPoint (x: -250, y: 640), name: "ballRed", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:    0, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  250, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
        }else if(row == 32){
            physicsWorld.gravity = CGVector(dx: 0, dy: -17.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  -90, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:   90, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  270, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 33){
            physicsWorld.gravity = CGVector(dx: 0, dy: -5.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  -90, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:   90, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  270, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 34){
            physicsWorld.gravity = CGVector(dx: 0, dy: -27.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  -90, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:   90, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  270, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else if(row == 35){
            physicsWorld.gravity = CGVector(dx: 0, dy: -7.8)
            addBall(at: CGPoint (x: -270, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  -90, y: 640), name: "ballYellow", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:   90, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
            addBall(at: CGPoint (x:  270, y: 640), name: "ballGrey", size: CGSize(width: 90, height: 90))
        }else{
            
        }
        
    }
//  MARK: REMOVE GIVEN NODE
    func destroy(ball: SKNode) {
//        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
//            fireParticles.position = ball.position
//            addChild(fireParticles)
//        }
        ball.removeFromParent()
    }
// MARK: COLLISION DETECTION
    func didBegin(_ contact: SKPhysicsContact) {
        character.name = "character"
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA.name == "character" {
            collisionBetween(character: nodeA, ball: nodeB)
        } else if nodeB.name == "character" {
            collisionBetween(character: nodeB, ball: nodeA)
        }
    }

// MARK: Button Touch link etc
    
    func linkButton(){
        // colorButton1 = (self.childNode(withName: "colorBtn1") as! SKSpriteNode)
         if let someNode:SKSpriteNode = self.childNode(withName: "colorBtn1") as? SKSpriteNode{
             colorButton1 = someNode
             print("colorButton1 linked")
         }
        if let someNode:SKSpriteNode = self.childNode(withName: "colorBtn2") as? SKSpriteNode{
            colorButton2 = someNode
            print("colorButton2 linked")
        }
        if let someNode:SKSpriteNode = self.childNode(withName: "colorBtn3") as? SKSpriteNode{
            colorButton3 = someNode
            print("colorButton3 linked")
        }
        if let someNode:SKSpriteNode = self.childNode(withName: "colorBtn4") as? SKSpriteNode{
            colorButton4 = someNode
            print("colorButton4 linked")
        }
        if let someNode:SKSpriteNode = self.childNode(withName: "colorBtn5") as? SKSpriteNode{
            colorButton5 = someNode
            print("colorButton5 linked")
        }
        if let someNode:SKLabelNode = (self.childNode(withName: "clrBtnLbl1") as! SKLabelNode){
            colorButtonLabel1 = someNode
            print("colorButtonLabel1 linked")
        }
        if let someNode:SKLabelNode = (self.childNode(withName: "clrBtnLbl2") as! SKLabelNode){
            colorButtonLabel2 = someNode
            print("colorButtonLabel2 linked")
        }
        if let someNode:SKLabelNode = (self.childNode(withName: "clrBtnLbl3") as! SKLabelNode){
            colorButtonLabel3 = someNode
            print("colorButtonLabel3 linked")
        }
        if let someNode:SKLabelNode = (self.childNode(withName: "clrBtnLbl4") as! SKLabelNode){
            colorButtonLabel4 = someNode
            print("colorButtonLabel4 linked")
        }
        if let someNode:SKLabelNode = (self.childNode(withName: "clrBtnLbl5") as! SKLabelNode){
            colorButtonLabel5 = someNode
            print("colorButtonLabel5 linked")
        }
        if let someNode:SKLabelNode = (self.childNode(withName: "clrQuestionLbl") as! SKLabelNode){
            colorQuestionLabel = someNode
            print("colorQuestionLabel linked")
        }
        colorButtonLabel1.text = "CYAN"
        colorButtonLabel1.fontColor = .cyan
        colorButtonLabel1.fontName = "AvenirNext-Bold"
        colorButtonLabel2.text = "PURPLE"
        colorButtonLabel2.fontColor = .yellow
        colorButtonLabel2.fontName = "AvenirNext-Bold"
        colorButtonLabel3.text = "GREEN"
        colorButtonLabel3.fontColor = .green
        colorButtonLabel3.fontName = "AvenirNext-Bold"
        colorButtonLabel4.text = "YELLOW"
        colorButtonLabel4.fontColor = .gray
        colorButtonLabel4.fontName = "AvenirNext-Bold"
        colorButtonLabel5.text = "GRAY"
        colorButtonLabel5.fontColor = .purple
        colorButtonLabel5.fontName = "AvenirNext-Bold"
        //colorButtonLabel1
    }
    
     @objc func buttonReloader(){
        buttonTimer!.invalidate()
        colorButton1.texture = SKTexture(imageNamed: "colorBtn")
        colorButton2.texture = SKTexture(imageNamed: "colorBtn")
        colorButton3.texture = SKTexture(imageNamed: "colorBtn")
        colorButton4.texture = SKTexture(imageNamed: "colorBtn")
        colorButton5.texture = SKTexture(imageNamed: "colorBtn")
        
    }
    
    
    func isHiddenColorLabels(status: Bool){
        
        if(status == true){
            colorButtonLabel1.isHidden = true
            colorButtonLabel2.isHidden = true
            colorButtonLabel3.isHidden = true
            colorButtonLabel4.isHidden = true
            colorButtonLabel5.isHidden = true
        }else{
            colorButtonLabel1.isHidden = false
            colorButtonLabel2.isHidden = false
            colorButtonLabel3.isHidden = false
            colorButtonLabel4.isHidden = false
            colorButtonLabel5.isHidden = false
        }

    }
    func isHiddenColorButtons(status: Bool){
        if(status == true){
             colorButton1.isHidden = true
             colorButton2.isHidden = true
             colorButton3.isHidden = true
             colorButton4.isHidden = true
             colorButton5.isHidden = true
         }else{
             colorButton1.isHidden = false
             colorButton2.isHidden = false
             colorButton3.isHidden = false
             colorButton4.isHidden = false
             colorButton5.isHidden = false
         }
    }
    func isHiddenColorQuestion(status: Bool){
        colorQuestionLabel.text = "Could you choose \n the rigth color button?"
        colorButtonLabel1.fontName = "AvenirNext-Bold"
        colorButtonLabel1.fontColor = .black
        colorButtonLabel1.fontSize = 30.0
        
        if(status == true){
            colorQuestionLabel.isHidden = true
         }else{
            colorQuestionLabel.isHidden = false
         }
    }
    
}
