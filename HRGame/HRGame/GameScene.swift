//
//  GameScene.swift
//  HRGame
//
//  Created by Can Babaoğlu on 24.08.2019.
//  Copyright © 2019 Can Babaoğlu. All rights reserved.
//

import SpriteKit
import Foundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var stage3clok =  Int(20)
 //   var pauseStageButtonNode:SKSpriteNode!
 //   var playStageButtonNode:SKSpriteNode!
    var menuButtonNode:SKSpriteNode!
    var starGold:SKSpriteNode!
    var starSilver:SKSpriteNode!
    var quesType:SKSpriteNode!
    var balls = ["ballRed","ballBlue","ballCyan","ballGreen","ballGrey","ballPurple","ballYellow"]
    let userDefaults = UserDefaults.standard
    var starfield:SKEmitterNode!
    var character:SKSpriteNode = SKSpriteNode()
    var characterPosition = CGPoint()
    var pad:SKSpriteNode = SKSpriteNode()
    var startTouch = CGPoint()
    var stageTimer:Timer!
    var getPointTimer:Timer!
    var getPointTimer1:Timer!
    var getPointTimer2:Timer!
    var getPointTimer3:Timer!
    var stage3Timer:Timer!
    var buttonTimer:Timer!
    var colorTimer:Timer!
    var startCountDownTimer: Timer!
    var buttonCountDown:Timer!
    var scoreLabel: SKLabelNode!
    var stageKey = Int(0)
    var lineCount = Int(0)
    var remainingLineCount = Int(20)
    var collidedBallName: String = ""
    var stage3QuestionType = Int(0)
    var isGotPoint = false
    var döndön = true
    
    struct result{
        var stageNumber = Int(-1)
        var currentLine = Int(-1)
        var fallingBallCount = Int(-1)
        var ballColors = [String]()
        var capturedBallColor = ""
        var pointFormCollision = Int(-1)
        var colorQuestionText = ""
        var buttonTexts = [String]()
        var buttonCollors = [UIColor]()
        var chosenButtonText = [String]()
        var isChooseRigth = false
        var pointFromColorTest = Int(-1)
        var colorDecisionTime = Int(-1)
    }
    
    var tempResult = result()
    
    var resultArray = [result]()
    
    var score = 0{
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var stageLabel: SKLabelNode!
    var stageCount = 0{
        didSet {
            stageLabel.text = "Remaining: \(remainingLineCount)"
        }
    }
    var getPointLabel: SKLabelNode!
    var getPoint = 0 {
        didSet {
            if( getPoint < 0){
                getPointLabel.fontColor = .red
                getPointLabel.text = "\(getPoint)"
                let scaleUp2 = SKAction.scale(to: CGSize(width: 280 , height: 243), duration: 0.2)
                let scaleDown2 = SKAction.scale(to: CGSize(width: 210 , height: 180), duration: 0.2)
                let actions2 = [scaleDown2, scaleUp2]
                let sekans2 = SKAction.sequence(actions2)
                character.run(sekans2)
                
                
            }else{
                getPointLabel.fontColor = .green
                getPointLabel.text = "+\(getPoint)"
                let scaleUp1 = SKAction.scale(to: CGSize(width: 300 , height: 300), duration: 0.2)
                let scaleDown1 = SKAction.scale(to: CGSize(width: 280 , height: 243), duration: 0.2)
                let actions1 = [scaleUp1, scaleDown1]
                let anlık1 = SKAction.sequence(actions1)
                character.run(anlık1)
                
                
            }
                    
            getPointLabel.position = character.position
            getPointLabel.zPosition = 35
            
            let move = SKAction.move(to:.init(x: 41, y: 580), duration: 1)
            let scaleUp = SKAction.scale(by: 2.0, duration: 0.5)
            let scaleDown = SKAction.scale(by: 0.5, duration: 0.5)
            let dönme = SKAction.rotate(byAngle: 6.28 , duration: 1)
            let actions = [dönme, move, scaleUp, scaleDown]
            //     let sequence = SKAction.sequence(actions)
            let anlık = SKAction.group(actions)
            getPointLabel.run(anlık)
            let dönme0 = SKAction.rotate(byAngle: 0 , duration: 0.3)
            let dönme1 = SKAction.rotate(byAngle: 6.28 , duration: 0.5)
            let dönme2 = SKAction.rotate(byAngle: -6.28 , duration: 0.5)
            
            let actions1 = [dönme0, dönme1]
            let actions2 = [dönme0, dönme2]
            
            let anlık1 = SKAction.sequence(actions1)
            let anlık2 = SKAction.sequence(actions2)
            
            starGold.run(anlık1)
            starSilver.run(anlık2)
            
         //   CGPoint(x: 50, y: 590)
            
            if (getPoint > 5){
  //              getPointTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(setGetPointLabelFontSize), userInfo: 1, repeats: true)
  //              getPointTimer1 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(setGetPointLabelFontSize1), userInfo: 2, repeats: true)
  //              getPointTimer2 = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(setGetPointLabelFontSize2), userInfo: 3, repeats: true)
  //              getPointTimer3 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setGetPointLabelFontSize3), userInfo: 4, repeats: true)
            }else{
                
            }
            
        }
    }
    var stage3clockLabel: SKLabelNode!
    var stage3clock = 4 {
        didSet {
            stage3clockLabel.fontSize = 200
            stage3clockLabel.horizontalAlignmentMode = .center
            stage3clockLabel.text = "\(stage3clock)"
            stage3clockLabel.position = CGPoint(x: 0, y: 300)
            if(stage3clock == -1){
                stage3clockLabel.text = "GO"
                stage3clockLabel.position = CGPoint(x: -30, y: 300)
            }
            if(stage3clock == -2){
                stage3clockLabel.text = ""
            }
            
            let scaleUp = SKAction.scale(by: 2.0, duration: 0.7)
            let scaleDown = SKAction.scale(by: 0.5, duration: 0.1)
            let actions = [scaleUp, scaleDown]
            //     let sequence = SKAction.sequence(actions)
            let anlık = SKAction.group(actions)
            stage3clockLabel.run(anlık)
            
        }
    }
    var colorTestCountDownLabel: SKLabelNode!
    var colorTestCountDown = 3 {
        didSet {
            colorTestCountDownLabel.text = "\(colorTestCountDown)"
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
    var colorViewTab:SKSpriteNode = SKSpriteNode()
    
    var riskViewBallRed:SKSpriteNode = SKSpriteNode()
    var riskViewBallPurple:SKSpriteNode = SKSpriteNode()
    var riskViewBallGreen:SKSpriteNode = SKSpriteNode()
    var riskViewBallYellow:SKSpriteNode = SKSpriteNode()
    var riskViewBallBlue:SKSpriteNode = SKSpriteNode()
    var riskViewBallCyan:SKSpriteNode = SKSpriteNode()
    var riskViewBallGrey:SKSpriteNode = SKSpriteNode()
    
// MARK: VIEWDIDLOAD
    override func didMove(to view: SKView) {
        lineCount = 0
        remainingLineCount = 20
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        stageKey = userDefaults.integer(forKey: "stageKey")
        
        linkButton()
        linkRiskyBallsView()
        
      //  pauseStageButtonNode = (self.childNode(withName: "pauseStageButton") as! SKSpriteNode)
    //    playStageButtonNode = (self.childNode(withName: "playStageButton") as! SKSpriteNode)
        menuButtonNode = (self.childNode(withName: "menuButton") as! SKSpriteNode)
        menuButtonNode.isHidden = true
        starGold = (self.childNode(withName: "starGold") as! SKSpriteNode)
        starSilver = (self.childNode(withName: "starSilver") as! SKSpriteNode)
        quesType = (self.childNode(withName: "questionTypeIcon") as! SKSpriteNode)
        quesType.isHidden = true
        
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
    //    addChild(dollar)
        
        let star = SKSpriteNode(imageNamed: "star")
        star.size.height = star.size.height / 2.0
        star.size.width = star.size.width / 2.0
        star.position = CGPoint(x: 180, y:600 )
        //background.blendMode = .replace
        star.zPosition = 1
     //   addChild(star)
        
        scoreLabel = SKLabelNode(fontNamed: "Phosphate-inline")
        scoreLabel.text = "Score: 0"
        scoreLabel.fontColor = #colorLiteral(red: 0.1504201059, green: 0.3853055239, blue: 0.5494609796, alpha: 1)
        scoreLabel.fontSize = 44
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 130, y: 615)
        scoreLabel.zPosition = 20
        addChild(scoreLabel)
        
        stageLabel = SKLabelNode(fontNamed: "Phosphate-inline")
        stageLabel.text = "Remaining: 20"
        stageLabel.fontColor = #colorLiteral(red: 0.1504201059, green: 0.3853055239, blue: 0.5494609796, alpha: 1)
        stageLabel.fontSize = 44
        stageLabel.horizontalAlignmentMode = .left
        stageLabel.position = CGPoint(x: -330, y: 615)
        stageLabel.zPosition = 20
        addChild(stageLabel)
        
        getPointLabel = SKLabelNode(fontNamed: "Phosphate-inline")
        getPointLabel.fontSize = 60
        getPointLabel.horizontalAlignmentMode = .center
        getPointLabel.position = character.position
        getPointLabel.zPosition = 20
        addChild(getPointLabel)
        
        stage3clockLabel = SKLabelNode(fontNamed: "Phosphate-inline")
        stage3clockLabel.text = "Ready!"
        stage3clockLabel.fontSize = 160
        stage3clockLabel.horizontalAlignmentMode = .left
        stage3clockLabel.position = CGPoint(x: -250, y: 300)
        stage3clockLabel.zPosition = 20
        addChild(stage3clockLabel)
        
        
        //physicsBody = SKPhysicsBody (edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        if let somePlayer:SKSpriteNode = self.childNode(withName: "player") as? SKSpriteNode{
            character = somePlayer
            print("player worked")
        }else{
            print("player failed")
        }
        character.name = "character"
        //character.physicsBody = SKPhysicsBody( rectangleOf: character.size)
        character.physicsBody?.isDynamic = false
        //self.addChild(character)
        
        if let someNode:SKSpriteNode = self.childNode(withName: "pad") as? SKSpriteNode{
            pad = someNode
            print("that worked")
        }
        
        resultArray.removeAll()
                
        if(stageKey == 0 ){ // tutorial elle set ettiğimiz kısım
            setColorViewTab(isHidden: true)
            setColorLabels(isHidden: true)
            setColorButtons(isHidden: true)
            setColorQuestion(isHidden: true)
            quesType.isHidden = true
            
            nextRow(row: stageCount+1)
        }else if(stageKey == 1){ // düz oyun top yakala
            setColorViewTab(isHidden: false)
         //   setRiskyBallsView(hide: false)
            setColorLabels(isHidden: true)
            setColorButtons(isHidden: true)
            setColorQuestion(isHidden: true)
            quesType.isHidden = true
            stage3clockLabel.text = ""
            
            stageTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(addNewLine), userInfo: nil, repeats: true)
        }else if(stageKey == 2){ // renk soruları gelecek
            setColorViewTab(isHidden: false)
            setColorLabels(isHidden: true)
            setColorButtons(isHidden: true)
            setColorQuestion(isHidden: true)
            quesType.isHidden = true
            colorTestCountDownLabel = SKLabelNode(fontNamed: "Chalkduster")
          //  colorTestCountDownLabel.text = "GO"
            colorTestCountDownLabel.fontSize = 150
            colorTestCountDownLabel.horizontalAlignmentMode = .center
            colorTestCountDownLabel.position = CGPoint(x: 0, y: 300)
            addChild(colorTestCountDownLabel)
            colorTestCountDownLabel.isHidden = true
            
            startCountDownTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(startCountDown), userInfo: nil, repeats: true)
            stageTimer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(addNewLine), userInfo: nil, repeats: true)
            
        }else if(stageKey == 3 || stageKey == 4){ // süre geri sayımı
            setColorViewTab(isHidden: false)
            setColorLabels(isHidden: true)
            setColorButtons(isHidden: true)
            setColorQuestion(isHidden: true)
            quesType.isHidden = true
              colorTestCountDownLabel = SKLabelNode(fontNamed: "Chalkduster")
            //  colorTestCountDownLabel.text = "GO"
              colorTestCountDownLabel.fontSize = 150
              colorTestCountDownLabel.horizontalAlignmentMode = .center
              colorTestCountDownLabel.position = CGPoint(x: 0, y: 300)
              addChild(colorTestCountDownLabel)
              colorTestCountDownLabel.isHidden = true
            
           // stage3Timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(stage3countDown), userInfo: nil, repeats: true)
            startCountDownTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(startCountDown), userInfo: nil, repeats: true)
            stageTimer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(addNewLine), userInfo: 78, repeats: true)
        }
    }
    
//  MARK: Touches Began
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var collBallName: String = ""
        var collBallColor: UIColor = .black
        let touch = touches.first
        if let location = touch?.location(in: self){
            startTouch = location
            characterPosition = character.position
            let nodesArray = self.nodes(at: location)
            
            
            tempResult.chosenButtonText.removeAll()
            
            if(stageKey == 0 ){ // tutorial elle set ettiğimiz kısım
                
            }else if(stageKey == 1){ // düz oyun
// MARK: Touch stage 2 - 3.5
                
            }else if(stageKey == 2 || (stageKey == 3 && stage3QuestionType == 0)){ // butonlar lazım
                
                collBallName =  getCollidedBallName(ball: collidedBallName)
                
                if (nodesArray.first?.name == "colorBtn1" || nodesArray.first?.name == "clrBtnLbl1"){
                    colorButton1.texture = SKTexture(imageNamed: "colorBtnPushed")
                        if(colorButtonLabel1.text == collBallName){
                            getPoint = colorTestCountDown * 5
                            score = score + getPoint
                            tempResult.isChooseRigth = true
                        }else{
                            tempResult.isChooseRigth = false
                    }
                    colorTestCountDownLabel.isHidden = true
                }else if(nodesArray.first?.name == "colorBtn2" || nodesArray.first?.name == "clrBtnLbl2"){
                    colorButton2.texture = SKTexture(imageNamed: "colorBtnPushed")
                        if(colorButtonLabel2.text == collBallName){
                            getPoint = colorTestCountDown * 5
                            score = score + getPoint
                            tempResult.isChooseRigth = true
                        }else{
                                tempResult.isChooseRigth = false
                        }
                    colorTestCountDownLabel.isHidden = true
                }else if(nodesArray.first?.name == "colorBtn3" || nodesArray.first?.name == "clrBtnLbl3"){
                    colorButton3.texture = SKTexture(imageNamed: "colorBtnPushed")
                        if(colorButtonLabel3.text == collBallName){
                            getPoint = colorTestCountDown * 5
                            score = score + getPoint
                            tempResult.isChooseRigth = true
                        }else{
                                tempResult.isChooseRigth = false
                        }
                    colorTestCountDownLabel.isHidden = true
                }else if(nodesArray.first?.name == "colorBtn4" || nodesArray.first?.name == "clrBtnLbl4"){
                    colorButton4.texture = SKTexture(imageNamed: "colorBtnPushed")
                        if(colorButtonLabel4.text == collBallName){
                            getPoint = colorTestCountDown * 5
                            score = score + getPoint
                            tempResult.isChooseRigth = true
                        }else{
                                tempResult.isChooseRigth = false
                        }
                    colorTestCountDownLabel.isHidden = true
                }else if(nodesArray.first?.name == "colorBtn5" || nodesArray.first?.name == "clrBtnLbl5"){
                    colorButton5.texture = SKTexture(imageNamed: "colorBtnPushed")
                        if(colorButtonLabel5.text == collBallName){
                            getPoint = colorTestCountDown * 5
                            score = score + getPoint
                            tempResult.isChooseRigth = true
                        }else{
                                tempResult.isChooseRigth = false
                        }
                    colorTestCountDownLabel.isHidden = true
                }
                
                buttonTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(buttonReloader), userInfo: "can", repeats: true)
 // MARK: Touch stage 3.5
            }else if((stageKey == 3 && stage3QuestionType == 1)){
                collBallColor =  getCollidedBallColor(ball: collidedBallName)
                
                if (nodesArray.first?.name == "colorBtn1" || nodesArray.first?.name == "clrBtnLbl1"){
                    colorButton1.texture = SKTexture(imageNamed: "colorBtnPushed")
                        if(colorButtonLabel1.fontColor == collBallColor){
                            getPoint = colorTestCountDown * 5
                            score = score + getPoint
                            tempResult.isChooseRigth = true
                        }else{
                                tempResult.isChooseRigth = false
                        }
                    colorTestCountDownLabel.isHidden = true
                }else if(nodesArray.first?.name == "colorBtn2" || nodesArray.first?.name == "clrBtnLbl2"){
                    colorButton2.texture = SKTexture(imageNamed: "colorBtnPushed")
                        if(colorButtonLabel2.fontColor == collBallColor){
                            getPoint = colorTestCountDown * 5
                            score = score + getPoint
                            tempResult.isChooseRigth = true
                        }else{
                                tempResult.isChooseRigth = false
                        }
                    colorTestCountDownLabel.isHidden = true
                }else if(nodesArray.first?.name == "colorBtn3" || nodesArray.first?.name == "clrBtnLbl3"){
                    colorButton3.texture = SKTexture(imageNamed: "colorBtnPushed")
                        if(colorButtonLabel3.fontColor == collBallColor){
                            getPoint = colorTestCountDown * 5
                            score = score + getPoint
                            tempResult.isChooseRigth = true
                        }else{
                                tempResult.isChooseRigth = false
                        }
                    colorTestCountDownLabel.isHidden = true
                }else if(nodesArray.first?.name == "colorBtn4" || nodesArray.first?.name == "clrBtnLbl4"){
                    colorButton4.texture = SKTexture(imageNamed: "colorBtnPushed")
                        if(colorButtonLabel4.fontColor == collBallColor){
                            getPoint = colorTestCountDown * 5
                            score = score + getPoint
                            tempResult.isChooseRigth = true
                        }else{
                                tempResult.isChooseRigth = false
                        }
                    colorTestCountDownLabel.isHidden = true
                }else if(nodesArray.first?.name == "colorBtn5" || nodesArray.first?.name == "clrBtnLbl5"){
                    colorButton5.texture = SKTexture(imageNamed: "colorBtnPushed")
                        if(colorButtonLabel5.fontColor == collBallColor){
                            getPoint = colorTestCountDown * 5
                            score = score + getPoint
                            tempResult.isChooseRigth = true
                        }else{
                                tempResult.isChooseRigth = false
                        }
                    colorTestCountDownLabel.isHidden = true
                }
                
                buttonTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(buttonReloader), userInfo: "can", repeats: true)
                
// MARK: Touch stage 4.5
            }else if(stageKey == 4 && stage3QuestionType == 0){ // butonlar lazım
                           collBallName =  getCollidedBallName(ball: collidedBallName)
                           
                           if (nodesArray.first?.name == "colorBtn1" || nodesArray.first?.name == "clrBtnLbl1"){
                            isGotPoint = true
                               colorButton1.texture = SKTexture(imageNamed: "colorBtnPushed")
                                   if(colorButtonLabel1.text == collBallName){
                                       getPoint = colorTestCountDown * 5
                                       score = score + getPoint
                                    tempResult.isChooseRigth = true
                                   }else{
                                       getPoint = -5
                                       score = score + getPoint
                                    tempResult.isChooseRigth = false
                                   }
                               colorTestCountDownLabel.isHidden = true
                           }else if(nodesArray.first?.name == "colorBtn2" || nodesArray.first?.name == "clrBtnLbl2"){
                            isGotPoint = true
                               colorButton2.texture = SKTexture(imageNamed: "colorBtnPushed")
                                   if(colorButtonLabel2.text == collBallName){
                                       getPoint = colorTestCountDown * 5
                                       score = score + getPoint
                                    tempResult.isChooseRigth = true
                                   }else{
                                       getPoint = -5
                                       score = score + getPoint
                                    tempResult.isChooseRigth = false
                                   }
                               colorTestCountDownLabel.isHidden = true
                           }else if(nodesArray.first?.name == "colorBtn3" || nodesArray.first?.name == "clrBtnLbl3"){
                            isGotPoint = true
                               colorButton3.texture = SKTexture(imageNamed: "colorBtnPushed")
                                   if(colorButtonLabel3.text == collBallName){
                                       getPoint = colorTestCountDown * 5
                                       score = score + getPoint
                                    tempResult.isChooseRigth = true
                                   }else{
                                       getPoint = -5
                                       score = score + getPoint
                                    tempResult.isChooseRigth = false
                                   }
                               colorTestCountDownLabel.isHidden = true
                           }else if(nodesArray.first?.name == "colorBtn4" || nodesArray.first?.name == "clrBtnLbl4"){
                            isGotPoint = true
                               colorButton4.texture = SKTexture(imageNamed: "colorBtnPushed")
                                   if(colorButtonLabel4.text == collBallName){
                                       getPoint = colorTestCountDown * 5
                                       score = score + getPoint
                                    tempResult.isChooseRigth = true
                                   }else{
                                       getPoint = -5
                                       score = score + getPoint
                                    tempResult.isChooseRigth = false
                                   }
                               colorTestCountDownLabel.isHidden = true
                           }else if(nodesArray.first?.name == "colorBtn5" || nodesArray.first?.name == "clrBtnLbl5"){
                            isGotPoint = true
                               colorButton5.texture = SKTexture(imageNamed: "colorBtnPushed")
                                   if(colorButtonLabel5.text == collBallName){
                                       getPoint = colorTestCountDown * 5
                                       score = score + getPoint
                                    tempResult.isChooseRigth = true
                                   }else{
                                    getPoint = -5
                                    score = score + getPoint
                                    tempResult.isChooseRigth = false
                                }
                               colorTestCountDownLabel.isHidden = true
                           }
//                if(stage4point > 0){
//
//                }else if(stage4point == 0){
//                    stage4point = -5
//                    getPoint = -5
//                    score = score + getPoint
//                }else if(stage4point == -5){
//
//                }
                
                           buttonTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(buttonReloader), userInfo: "can", repeats: true)
               
// MARK: Touch stage 4.5
            }else if((stageKey == 4 && stage3QuestionType == 1)){
                                collBallColor =  getCollidedBallColor(ball: collidedBallName)
                                
                                if (nodesArray.first?.name == "colorBtn1" || nodesArray.first?.name == "clrBtnLbl1"){
                                    isGotPoint = true
                                    colorButton1.texture = SKTexture(imageNamed: "colorBtnPushed")
                                        if(colorButtonLabel1.fontColor == collBallColor){
                                            getPoint = colorTestCountDown * 5
                                            score = score + getPoint
                                            tempResult.isChooseRigth = true
                                        }else{
                                            getPoint = -5
                                            score = score + getPoint
                                            tempResult.isChooseRigth = false
                                        }
                                    colorTestCountDownLabel.isHidden = true
                                }else if(nodesArray.first?.name == "colorBtn2" || nodesArray.first?.name == "clrBtnLbl2"){
                                    isGotPoint = true
                                    colorButton2.texture = SKTexture(imageNamed: "colorBtnPushed")
                                        if(colorButtonLabel2.fontColor == collBallColor){
                                            getPoint = colorTestCountDown * 5
                                            score = score + getPoint
                                            tempResult.isChooseRigth = true
                                        }else{
                                            getPoint = -5
                                            score = score + getPoint
                                            tempResult.isChooseRigth = false
                                        }
                                    colorTestCountDownLabel.isHidden = true
                                }else if(nodesArray.first?.name == "colorBtn3" || nodesArray.first?.name == "clrBtnLbl3"){
                                    isGotPoint = true
                                    colorButton3.texture = SKTexture(imageNamed: "colorBtnPushed")
                                        if(colorButtonLabel3.fontColor == collBallColor){
                                            getPoint = colorTestCountDown * 5
                                            score = score + getPoint
                                            tempResult.isChooseRigth = true
                                        }else{
                                            getPoint = -5
                                            score = score + getPoint
                                            tempResult.isChooseRigth = false
                                        }
                                    colorTestCountDownLabel.isHidden = true
                                }else if(nodesArray.first?.name == "colorBtn4" || nodesArray.first?.name == "clrBtnLbl4"){
                                    isGotPoint = true
                                    colorButton4.texture = SKTexture(imageNamed: "colorBtnPushed")
                                        if(colorButtonLabel4.fontColor == collBallColor){
                                            getPoint = colorTestCountDown * 5
                                            score = score + getPoint
                                            tempResult.isChooseRigth = true
                                        }else{
                                            getPoint = -5
                                            score = score + getPoint
                                            tempResult.isChooseRigth = false
                                        }
                                    colorTestCountDownLabel.isHidden = true
                                }else if(nodesArray.first?.name == "colorBtn5" || nodesArray.first?.name == "clrBtnLbl5"){
                                    isGotPoint = true
                                    colorButton5.texture = SKTexture(imageNamed: "colorBtnPushed")
                                        if(colorButtonLabel5.fontColor == collBallColor){
                                            getPoint = colorTestCountDown * 5
                                            score = score + getPoint
                                            tempResult.isChooseRigth = true
                                        }else{
                                            getPoint = -5
                                            score = score + getPoint
                                            tempResult.isChooseRigth = false
                                        }
                                    colorTestCountDownLabel.isHidden = true
                                }
                
//                               if(stage4point > 0){ // doğru cevap vermiş bi kere bişe yapma
//
//                               }else if(stage4point == 0){ // yanlış cevap verirse -5 ver
//                                   stage4point = -5
//                                   getPoint = -5
//                                   score = score + getPoint
//                               }else if(stage4point == -5){ // 1 kere yanlış verdiyse elleşme
//
//                               }
                
                                buttonTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(buttonReloader), userInfo: "can", repeats: true)
                            }
            
            
// MARK: Touch buttons will be removed
        if(nodesArray.first?.name == "menuButton" ){//stagelere göre ayır
                
                döndön = false
            
                if (stageKey != 0 ){
                    stageTimer.invalidate()
                }
                if (stageKey == 3 || stageKey == 4){
                   // stage3Timer.invalidate()
                    stageTimer.invalidate()
                }
                
                    if let scene = SKScene(fileNamed: "MenuScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    // Present the scene
                    let transition = SKTransition.doorsCloseHorizontal(withDuration: 1.0)
                    self.view!.presentScene(scene, transition: transition)
                }
               // stageTimer.invalidate() gerekli mi bilmiyorum
               // buttonTimer.invalidate()
            }
            
            tempResult.pointFromColorTest = getPoint
            tempResult.colorDecisionTime = getPoint/5
            
        }
        
    }
    
// MARK: Karakteri kaydır
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            character.run(SKAction.move(to: CGPoint(x:  characterPosition.x + location.x - startTouch.x, y: -270), duration: 0.1))
        }
    }
    
// MARK: ADD NEW LINE STAGE 2 & 3 BAŞLANGICI
    @objc func addNewLine(){ //count koy ona ulaşınca girmeyi bıraksın
        //character.zPosition = 50
        isGotPoint = false
        physicsWorld.contactDelegate = self
        
        if(lineCount > 0){
            resultArray.append(tempResult)
        }
        tempResult.currentLine = lineCount
        if(stageKey == 2 ){
            tempResult.stageNumber = 2
            setColorViewTab(isHidden: false)
            setColorQuestionText()
            setColorQuestion(isHidden: false)
            quesType.isHidden = true
            setColorLabels(isHidden: true)
            setColorButtons(isHidden: true)
          //  colorTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(activateColors), userInfo: "a", repeats: true)
        }else if(stageKey == 3){
            tempResult.stageNumber = 3
            setColorViewTab(isHidden: false)
            setColorQuestionText()
            setColorQuestion(isHidden: false)
            quesType.isHidden = false
            setColorLabels(isHidden: true)
            setColorButtons(isHidden: true)
        }else if(stageKey == 4){
            tempResult.stageNumber = 4
            setColorViewTab(isHidden: false)
            setColorQuestionText()
            setColorQuestion(isHidden: false)
            quesType.isHidden = false
            setColorLabels(isHidden: true)
            setColorButtons(isHidden: true)
        }
    
        if (stageKey == 1 && lineCount > 19) { // 20 olur 19 olacak
            stageTimer!.invalidate()
            endGameScreen()
        }else if(stageKey == 2 && lineCount > 19){ // 19 olacak
           // stage3Timer.invalidate()
            stageTimer.invalidate()
            endGameScreen()
        }else if(stageKey == 3 && lineCount > 19){
           // stage3Timer.invalidate()
            stageTimer.invalidate()
            endGameScreen()
        }else if(stageKey == 4 && lineCount > 19){
           // stage3Timer.invalidate()
            stageTimer.invalidate()
            endGameScreen()
        }else{
            let ballCount = Int.random(in: 2 ... 5)
            tempResult.fallingBallCount = ballCount
            addLine(bCount: ballCount)
            lineCount = lineCount + 1
        }
        remainingLineCount = remainingLineCount - 1
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
        
        var randArray : [Int] = []
        randArray = randomArrayGenaratorWithoutDuplicates(each: 5)
        tempResult.ballColors.removeAll()
        //labellamaya yolla
        for a in 0..<bCount{
            addBallwithoutSize(at: CGPoint (x: initX, y: 640), name: balls[randArray[a]])
            initX = initX + deltaX
            tempResult.ballColors.append(balls[randArray[a]])
        }
        
        arrangeButtonLabels(colorArr: randArray)
        
        //renameColorLabels(ballNo: randArray)
        
    }
  
//  MARK: Stage 2 içim yazıldı
    func addBallwithoutSize (at position: CGPoint, name: String) {
        let ball = SKSpriteNode(imageNamed: name)
        ball.name = name
        ball.size = CGSize(width: 90, height: 90)
        ball.position = position
        ball.zPosition = 0
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.restitution = 0.4
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        addChild(ball)
    }
    
    func renameColorLabels(ballNo: [Int]){
        
        let incomeCount = ballNo.count
        
        
        
        for _ in 0..<incomeCount{

        }
        
        
        // 5 butonumuz kaç buton geleceğine bakıp ona göre random üreteceğiz.
        
        
        
    }

    
//  MARK: Static Line add
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
    
//  MARK: AFTER COLLISION
    func collisionBetween(character: SKNode, ball: SKNode) {
        physicsWorld.contactDelegate = nil
        //character.zPosition = 1
        collidedBallName = ball.name!
        tempResult.capturedBallColor = collidedBallName
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
        tempResult.pointFormCollision = getPoint
        stageCount = stageCount + 1
        if(stageKey == 0){ // tutorial ise yakaladıkça oyun devam edecek
            nextRow(row: stageCount)
        }
        
    }
    
    // MARK: Score CallBack
    
    func scoreCalculate(ballName: String, randomNo: Int) -> Int {
        
        switch ballName {
        case "ballGrey":
            switch randomNo {
            case 1:
                return 2
            case 2:
                return 2
            case 3:
                return 2
            case 4:
                return 2
            case 5:
                return -1
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
        case "ballCyan":
            switch randomNo {
            case 1:
                return -3
            case 2:
                return 6
            case 3:
                return 6
            case 4:
                return 6
            case 5:
                return 6
            case 6:
                return -3
            case 7:
                return 6
            case 8:
                return 6
            case 9:
                return 6
            case 10:
                return 6
            default:
                print("farklı bir şey çarptı!!!")
            }

        case "ballBlue":
            switch randomNo {
            case 1:
                return 10
            case 2:
                return -5
            case 3:
                return 10
            case 4:
                return -5
            case 5:
                return 10
            case 6:
                return -5
            case 7:
                return 10
            case 8:
                return 10
            case 9:
                return 10
            case 10:
                return 10
            default:
                print("farklı bir şey çarptı!!!")
            }

        case "ballYellow":
            switch randomNo {
            case 1:
                return -7
            case 2:
                return 14
            case 3:
                return -7
            case 4:
                return 14
            case 5:
                return 14
            case 6:
                return -7
            case 7:
                return 14
            case 8:
                return -7
            case 9:
                return 14
            case 10:
                return 14
            default:
                print("farklı bir şey çarptı!!!")
            }

        case "ballGreen":
            switch randomNo {
            case 1:
                return -9
            case 2:
                return 18
            case 3:
                return -9
            case 4:
                return 18
            case 5:
                return -9
            case 6:
                return 18
            case 7:
                return -9
            case 8:
                return 18
            case 9:
                return -9
            case 10:
                return 18
            default:
                print("farklı bir şey çarptı!!!")
            }

        case "ballPurple":
            switch randomNo {
            case 1:
                return -11
            case 2:
                return 22
            case 3:
                return -11
            case 4:
                return 22
            case 5:
                return -11
            case 6:
                return 22
            case 7:
                return -11
            case 8:
                return -11
            case 9:
                return -11
            case 10:
                return 22
            default:
                print("farklı bir şey çarptı!!!")
            }
        case "ballRed":
            switch randomNo {
            case 1:
                return 26
            case 2:
                return -13
            case 3:
                return -13
            case 4:
                return 26
            case 5:
                return -13
            case 6:
                return -13
            case 7:
                return -13
            case 8:
                return 26
            case 9:
                return -13
            case 10:
                return -13
            default:
                print("farklı bir şey çarptı!!!")
            }
        default:
            print("farklı bir şey çarptı!!!")
        }
        return 0
    }
        
    
//  MARK: Static Lane Genarator
    
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
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        if let sparkParticles = SKEmitterNode(fileNamed: "MyParticle") {
            sparkParticles.position.x = character.position.x - 80.0
            sparkParticles.position.y = character.position.y
            addChild(sparkParticles)
        }
        
        ball.removeFromParent()
        if(stageKey == 2 || stageKey == 3 || stageKey == 4){
            setColorQuestion(isHidden: true)
            quesType.isHidden = true
            setColorLabels(isHidden: false)
            setColorButtons(isHidden: false)
            
        //    colorTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(deActivateColors), userInfo: "ada", repeats: true)
            colorTestCountDown = 3
            colorTestCountDownLabel.isHidden = false
            buttonCountDown = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(colorTestCountDownFunc), userInfo: "adas", repeats: true)
        }
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
        if let someNode:SKSpriteNode = self.childNode(withName: "colorView") as? SKSpriteNode{
            colorViewTab = someNode
            print("colorViewTab linked")
        }
        
        

        //colorButtonLabel1
    }
    
// MARK: Risky Ball View
    
    func setRiskyBallsView(hide: Bool){
        if(hide == false){
            riskViewBallGrey.zPosition = 11
            riskViewBallCyan.zPosition = 11
            riskViewBallBlue.zPosition = 11
            riskViewBallYellow.zPosition = 11
            riskViewBallGreen.zPosition = 11
            riskViewBallPurple.zPosition = 11
            riskViewBallRed.zPosition = 11
        }else{
            riskViewBallGrey.zPosition = 9
            riskViewBallCyan.zPosition = 9
            riskViewBallBlue.zPosition = 9
            riskViewBallYellow.zPosition = 9
            riskViewBallGreen.zPosition = 9
            riskViewBallPurple.zPosition = 9
            riskViewBallRed.zPosition = 9
            }
//        colorQuestionLabel.position = CGPoint(x: 0, y: -540)
//        colorQuestionLabel.verticalAlignmentMode = .center
//        colorQuestionLabel.text = "%90  %80  %70  %60  %50  %40  %30\n\n\n +2     +4      +8     +10    +12   +15   +20"
//
//        colorQuestionLabel.fontName = "AvenirNext-Bold"
//        colorQuestionLabel.fontColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
//        colorQuestionLabel.fontSize = 35.0

    }
 // MARK: Link Risky Balls
    func linkRiskyBallsView(){
        
        if let someNode:SKSpriteNode = self.childNode(withName: "grayBallRisk") as? SKSpriteNode{
            riskViewBallGrey = someNode
            print("grayBallRisk linked")
        }
        if let someNode:SKSpriteNode = self.childNode(withName: "cyanBallRisk") as? SKSpriteNode{
            riskViewBallCyan = someNode
            print("cyanBallRisk linked")
        }
        if let someNode:SKSpriteNode = self.childNode(withName: "blueBallRisk") as? SKSpriteNode{
            riskViewBallBlue = someNode
            print("blueBallRisk linked")
        }
        if let someNode:SKSpriteNode = self.childNode(withName: "yellowBallRisk") as? SKSpriteNode{
            riskViewBallYellow = someNode
            print("yellowBallRisk linked")
        }
        if let someNode:SKSpriteNode = self.childNode(withName: "greenBallRisk") as? SKSpriteNode{
            riskViewBallGreen = someNode
            print("greenBallRisk linked")
        }
        if let someNode:SKSpriteNode = self.childNode(withName: "purpleBallRisk") as? SKSpriteNode{
            riskViewBallPurple = someNode
            print("purpleBallRisk linked")
        }
        if let someNode:SKSpriteNode = self.childNode(withName: "redBallRisk") as? SKSpriteNode{
            riskViewBallRed = someNode
            print("redBallRisk linked")
        }
        
        
        
        
    }
    
    
    
     @objc func buttonReloader(){
        buttonTimer!.invalidate()
        colorButton1.texture = SKTexture(imageNamed: "colorBtn")
        colorButton2.texture = SKTexture(imageNamed: "colorBtn")
        colorButton3.texture = SKTexture(imageNamed: "colorBtn")
        colorButton4.texture = SKTexture(imageNamed: "colorBtn")
        colorButton5.texture = SKTexture(imageNamed: "colorBtn")
        
    }
    
    
    func setColorLabels(isHidden: Bool){
        
        if(isHidden == true){
            colorButtonLabel1.isHidden = true
            colorButtonLabel2.isHidden = true
            colorButtonLabel3.isHidden = true
            colorButtonLabel4.isHidden = true
            colorButtonLabel5.isHidden = true
//            colorButtonLabel1.isUserInteractionEnabled = false
//            colorButtonLabel2.isUserInteractionEnabled = false
//            colorButtonLabel3.isUserInteractionEnabled = false
//            colorButtonLabel4.isUserInteractionEnabled = false
//            colorButtonLabel5.isUserInteractionEnabled = false
//          colorButtonLabel1.zPosition = 9
//          colorButtonLabel2.zPosition = 9
//          colorButtonLabel3.zPosition = 9
//          colorButtonLabel4.zPosition = 9
//          colorButtonLabel5.zPosition = 9
        }else{
            colorButtonLabel1.isHidden = false
            colorButtonLabel2.isHidden = false
            colorButtonLabel3.isHidden = false
            colorButtonLabel4.isHidden = false
            colorButtonLabel5.isHidden = false
//            colorButtonLabel1.isUserInteractionEnabled = true
//            colorButtonLabel2.isUserInteractionEnabled = true
//            colorButtonLabel3.isUserInteractionEnabled = true
//            colorButtonLabel4.isUserInteractionEnabled = true
//            colorButtonLabel5.isUserInteractionEnabled = true
//          colorButtonLabel1.zPosition = 15
//          colorButtonLabel2.zPosition = 15
//          colorButtonLabel3.zPosition = 15
//          colorButtonLabel4.zPosition = 15
//          colorButtonLabel5.zPosition = 15

        }

    }
    func setColorButtons(isHidden: Bool){
        if(isHidden == true){
             colorButton1.isHidden = true
             colorButton2.isHidden = true
             colorButton3.isHidden = true
             colorButton4.isHidden = true
             colorButton5.isHidden = true
//             colorButton1.isUserInteractionEnabled = false
//             colorButton2.isUserInteractionEnabled = false
//             colorButton3.isUserInteractionEnabled = false
//             colorButton4.isUserInteractionEnabled = false
//             colorButton5.isUserInteractionEnabled = false
//           colorButton1.zPosition = 9
//           colorButton2.zPosition = 9
//           colorButton3.zPosition = 9
//           colorButton4.zPosition = 9
//           colorButton5.zPosition = 9
         }else{
             colorButton1.isHidden = false
             colorButton2.isHidden = false
             colorButton3.isHidden = false
             colorButton4.isHidden = false
             colorButton5.isHidden = false
//            colorButton1.isUserInteractionEnabled = true
//            colorButton2.isUserInteractionEnabled = true
//            colorButton3.isUserInteractionEnabled = true
//            colorButton4.isUserInteractionEnabled = true
//            colorButton5.isUserInteractionEnabled = true
//           colorButton1.zPosition = 11
//           colorButton2.zPosition = 11
//           colorButton3.zPosition = 11
//           colorButton4.zPosition = 11
//           colorButton5.zPosition = 11
         }
    }
    func setColorQuestion(isHidden: Bool){
        
        if(isHidden == true){
            colorQuestionLabel.isHidden = true
         }else{
            colorQuestionLabel.isHidden = false
         }
    }
    
    func setColorQuestionText(){
        if(stageKey == 2){
            colorQuestionLabel.text = "Match the ball color with\nthe name of the color!"
        }else if(stageKey == 3 || stageKey == 4 ){
            let randNumber = Int.random(in: 0 ... 1)
            stage3QuestionType = randNumber
            if(randNumber == 0){
                colorQuestionLabel.text = "Match the ball color with\nthe name of the color!"
                quesType.texture = SKTexture(imageNamed: "text1")
                quesType.size = CGSize(width: 100, height: 100)
            }else if(randNumber == 1){
                colorQuestionLabel.text = "Match the ball color with\nthe color of the text!"
                quesType.texture = SKTexture(imageNamed: "color1")
                quesType.size = CGSize(width: 100, height: 100)
            }
            
            let move11 = SKAction.move(to:.init(x: 0, y: 0), duration: 0.25)
            let scaleUp11 = SKAction.scale(by: 2.0, duration: 0.2)
            let scaleDown11 = SKAction.scale(by: 0.5, duration: 0.2)
            let dönme11 = SKAction.rotate(byAngle: 0.28 , duration: 0.1)
            let dönme22 = SKAction.rotate(byAngle: -0.28 , duration: 0.1)
            let move22 = SKAction.move(to:.init(x: 235, y: -565), duration: 0.2)
            let actions44 = [move11, scaleUp11, scaleDown11, dönme11, dönme22, move22]
            //     let sequence = SKAction.sequence(actions)
            let anlık33 = SKAction.sequence(actions44)
            quesType.run(anlık33)
            
            
        }
        tempResult.colorQuestionText = colorQuestionLabel.text!
        colorQuestionLabel.fontName = "AvenirNext-Bold"
        colorQuestionLabel.fontColor = .systemPink
        colorQuestionLabel.fontSize = 40.0
    }
    
    func setColorViewTab(isHidden: Bool){

        if(isHidden == true){
            colorViewTab.isHidden = true
         }else{
            colorViewTab.isHidden = false
         }
    }
    
    @objc func activateColors(){ //count koy ona ulaşınca girmeyi bıraksın
      //  colorTimer.invalidate()
        setColorQuestion(isHidden: true)
        quesType.isHidden = true
        setColorLabels(isHidden: false)
        setColorButtons(isHidden: false)
    }
    
    @objc func deActivateColors(){ //count koy ona ulaşınca girmeyi bıraksın
        colorTimer.invalidate()
        setColorQuestion(isHidden: true)
        quesType.isHidden = true
        setColorLabels(isHidden: true)
        setColorButtons(isHidden: true)
    }
    
    @objc func colorTestCountDownFunc(){
        colorTestCountDown = colorTestCountDown - 1
        if(colorTestCountDown == 0){
            colorTestCountDownLabel.isHidden = true
            buttonCountDown.invalidate()
            setColorQuestion(isHidden: true)
            quesType.isHidden = true
            setColorLabels(isHidden: true)
            setColorButtons(isHidden: true)
            
                       
            if( stageKey == 4 && isGotPoint == false){
                    getPoint = -5
                    score = score + getPoint
            }
        }
    }
    
    @objc func startCountDown(){ //count koy ona ulaşınca girmeyi bıraksın
        self.stage3clock = self.stage3clock - 1
        if(stage3clock == -2){
            print("times up")
            startCountDownTimer.invalidate()
        }
    }
    
 // MARK: Arrange Button Labels
    
// balls = ["ballRed","ballBlue","ballCyan","ballGreen","ballGrey","ballPurple","ballYellow"]
    func arrangeButtonLabels(colorArr: [Int]){
        
        var shuffledColArr = colorArr.shuffled()

        var nameArry: [String] = []
        
        for a in 0..<shuffledColArr.count{
            
            if(shuffledColArr[a] == 0){
                nameArry.append("RED")
            }else if(shuffledColArr[a] == 1){
                nameArry.append("BLUE")
            }else if(shuffledColArr[a] == 2){
                nameArry.append("CYAN")
            }else if(shuffledColArr[a] == 3){
                nameArry.append("GREEN")
            }else if(shuffledColArr[a] == 4){
                nameArry.append("GRAY")
            }else if(shuffledColArr[a] == 5){
                nameArry.append("PURPLE")
            }else if(shuffledColArr[a] == 6){
                nameArry.append("YELLOW")
            }
        
        }
        
        
        
        let shuffledFontArr = shuffledColArr.shuffled()
        
        var fontColorArry: [UIColor] = []
                        
        for a in 0..<shuffledFontArr.count{
            
            if(shuffledFontArr[a] == 0){
                fontColorArry.append(.red)
            }else if(shuffledFontArr[a] == 1){
                fontColorArry.append(.blue)
            }else if(shuffledFontArr[a] == 2){
                fontColorArry.append(.cyan)
            }else if(shuffledFontArr[a] == 3){
                fontColorArry.append(.green)
            }else if(shuffledFontArr[a] == 4){
                fontColorArry.append(.gray)
            }else if(shuffledFontArr[a] == 5){
                fontColorArry.append(.purple)
            }else if(shuffledFontArr[a] == 6){
                fontColorArry.append(.yellow)
            }
        
        }
        tempResult.buttonTexts.removeAll()
        tempResult.buttonCollors.removeAll()
        tempResult.buttonTexts = nameArry
        tempResult.buttonCollors = fontColorArry
                
        colorButtonLabel1.text = nameArry[0]
        colorButtonLabel1.fontColor = fontColorArry[0]
        colorButtonLabel1.fontName = "AvenirNext-Bold"
        colorButtonLabel2.text = nameArry[1]
        colorButtonLabel2.fontColor = fontColorArry[1]
        colorButtonLabel2.fontName = "AvenirNext-Bold"
        colorButtonLabel3.text = nameArry[2]
        colorButtonLabel3.fontColor = fontColorArry[2]
        colorButtonLabel3.fontName = "AvenirNext-Bold"
        colorButtonLabel4.text = nameArry[3]
        colorButtonLabel4.fontColor = fontColorArry[3]
        colorButtonLabel4.fontName = "AvenirNext-Bold"
        colorButtonLabel5.text = nameArry[4]
        colorButtonLabel5.fontColor = fontColorArry[4]
        colorButtonLabel5.fontName = "AvenirNext-Bold"
        
    }
    
// MARK: Random Array Generator Without Duplication
    
    func randomArrayGenaratorWithoutDuplicates(each: Int) -> [Int]{
        
        var noDuplicateArray : [Int] = []
        var noDupArraySize : Int = 0
        var randNumber: Int = 0
        var a : Int = 0
        var flag : Bool = false
        
        while( a < each ){
            
            randNumber = Int.random(in: 0 ... 6)
            
            for b in 0..<noDupArraySize{
                if(randNumber  == noDuplicateArray[b]){
                    flag = true
                }
            }
            
            if(flag == false){
                noDuplicateArray.append(randNumber)
                a = a + 1
            }
            noDupArraySize = noDuplicateArray.count
            flag = false

        }
        
        return noDuplicateArray
        
    }
    
// MARK: Get Collided Ball Properties
    
    func getCollidedBallName(ball: String) -> String{
        switch ball {
        case "ballRed":
            return "RED"
        case "ballBlue":
            return "BLUE"
        case "ballCyan":
            return "CYAN"
        case "ballGreen":
            return "GREEN"
        case "ballGrey":
            return "GRAY"
        case "ballPurple":
            return "PURPLE"
        case "ballYellow":
            return "YELLOW"
        default:
            print("Wrong Name in collidedBall")
            return "ERROR"
        }
    }
    
    func getCollidedBallColor(ball: String) -> UIColor{
        switch ball {
        case "ballRed":
            return .red
        case "ballBlue":
            return .blue
        case "ballCyan":
            return .cyan
        case "ballGreen":
            return .green
        case "ballGrey":
            return .gray
        case "ballPurple":
            return .purple
        case "ballYellow":
            return .yellow
        default:
            print("Wrong Name in collidedBall")
            return .black
        }
    }
    
//    @objc func setGetPointLabelFontSize(){ //count koy ona ulaşınca girmeyi bıraksın
//        getPointTimer.invalidate()
//        getPointLabel.fontSize = 80
//    }
//    @objc func setGetPointLabelFontSize1(){ //count koy ona ulaşınca girmeyi bıraksın
//        getPointTimer1.invalidate()
//        getPointLabel.fontSize = 100
//    }
//    @objc func setGetPointLabelFontSize2(){ //count koy ona ulaşınca girmeyi bıraksın
//        getPointTimer2.invalidate()
//        getPointLabel.fontSize = 80
//    }
//    @objc func setGetPointLabelFontSize3(){ //count koy ona ulaşınca girmeyi bıraksın
//        getPointTimer3.invalidate()
//        getPointLabel.fontSize = 50
//    }
    
// MARK: End Game Screen
    
    func endGameScreen(){
        
        colorViewTab.size.height = 360
        colorViewTab.size.width = 440
        colorViewTab.position = CGPoint(x: 0 , y: 0 )
        colorViewTab.blendMode = .alpha
        colorViewTab.zPosition = 30
        colorQuestionLabel.isHidden = false
        colorQuestionLabel.text = "STAGE \(stageKey)\nCOMPLETED\nSCORE: \(score)"
        colorQuestionLabel.fontName = "AvenirNext-Bold"
        colorQuestionLabel.horizontalAlignmentMode = .center
        colorQuestionLabel.verticalAlignmentMode = .center
        colorQuestionLabel.fontColor = .systemPink
        colorQuestionLabel.zPosition = 31
        colorQuestionLabel.fontSize = 45.0
        colorQuestionLabel.position = CGPoint(x: 0 , y: 40 )
        menuButtonNode.isHidden = false
        menuButtonNode.position = CGPoint(x: 100 , y: -90 )
        menuButtonNode.zPosition = 32
        quesType.isHidden = true
        
        let scaleUp2 = SKAction.scale(to: CGSize(width: 95 , height: 95), duration: 1.0)
        let scaleDown2 = SKAction.scale(to: CGSize(width: 80 , height: 80), duration: 1.0)
        let actions2 = [scaleUp2,scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2,scaleUp2, scaleDown2]
        let sekans2 = SKAction.sequence(actions2)
      //  while(döndön == true){
        menuButtonNode.run(sekans2)
     //   }
        
        
//        pauseStageButtonNode.position = CGPoint(x: -130 , y: -90 )
//        pauseStageButtonNode.zPosition = 32
//        playStageButtonNode.position = CGPoint(x: 130 , y: -90 )
//        playStageButtonNode.zPosition = 32
        
        character.zPosition = 33
        
        //dataSave().getData(dataFromStage: resultArray)
        
        saveToFile()
    }
    
    
    func saveToFile(){
        
        
        
        
        let id = userDefaults.integer(forKey: "id")
        
        var fName = "Output"
        
        if(stageKey == 1){
            fName = "Output_Stage_1"
        }else if(stageKey == 2){
            fName = "Output_Stage_2"
        }else if(stageKey == 3){
            fName = "Output_Stage_3"
        }else if(stageKey == 4){
            fName = "Output_Stage_4"
        }else{
            fName = "Output_Stage_9"
        }
        let fileName = fName
        let dir = try? FileManager.default.url(for: .documentDirectory,
              in: .userDomainMask, appropriateFor: nil, create: false)

        // If the directory was found, we write a file to it and read it back
        if let fileURL = dir?.appendingPathComponent(fileName).appendingPathExtension("txt") {
            
            var inString = ""
            do {
                inString = try String(contentsOf: fileURL)
            } catch {
                print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
            }
            print("Read from the file: \(inString)")
            
            var outData = ""
            
            for a in 0..<(resultArray.count){
                let line = resultArray[a]
                let lineData = "\(line.currentLine) . " + "#\(line.fallingBallCount)Balls = " + "\(line.ballColors) " + " -< \(line.capturedBallColor) Captured - " + "PointBall: \(line.pointFormCollision) - " + "Q: \(line.colorQuestionText) - " + "ButtonsTexts = \(line.buttonTexts) & " + "ButtonColors\(line.buttonCollors) - " + "* Choose: \(line.isChooseRigth) * " + "PointColor: \(line.pointFromColorTest) - " + "Time: \(line.colorDecisionTime) - " + "\n"
                outData.append(contentsOf: lineData)
            }
            
            
            let outString = inString + "\n" +  "id: \(id)  " + "\n" + "\(outData) "
            do {
                try outString.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {
                print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
            }
            

            
        }
    }
    
    
}
