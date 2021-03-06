//
//  StartScene.swift
//  HRGame
//
//  Created by Can Babaoğlu on 1.11.2019.
//  Copyright © 2019 Can Babaoğlu. All rights reserved.
//

import SpriteKit

class StartScene: SKScene, SKPhysicsContactDelegate {

    var isClick:Bool = false
    var goTimer:Timer!

    var startTouch = CGPoint()
    var starfield:SKEmitterNode!
    let userDefaults = UserDefaults.standard
    
    var returnMenuButtonNode:SKSpriteNode!
    var returnMenuLabelNode:SKLabelNode!
    
    var startStageButtonNode:SKSpriteNode!
    var startStageLabelNode:SKLabelNode!
    
    var character:SKSpriteNode = SKSpriteNode()
    var characterPosition = CGPoint()
    var stageKey = Int(0)
    
    var infoLabelNode:SKLabelNode!
    var stageLabelNode:SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        stageKey = userDefaults.integer(forKey: "stageKey")
        
        starfield = (self.childNode(withName: "starfield") as! SKEmitterNode)
        starfield.advanceSimulationTime(10)
        
        if let someNode:SKSpriteNode = self.childNode(withName: "returnMenu") as? SKSpriteNode{
            returnMenuButtonNode = someNode
            print("returnMenuButtonNode linked")
        }
        if let someNode:SKSpriteNode = self.childNode(withName: "startStage") as? SKSpriteNode{
            startStageButtonNode = someNode
            print("startStageButtonNode linked")
        }
        
        physicsWorld.contactDelegate = self
        
        if let somePlayer:SKSpriteNode = self.childNode(withName: "player") as? SKSpriteNode{
            character = somePlayer
            print("character worked")
        }else{
            print("character failed")
        }
        
        let move = SKAction.move(to:.init(x: 82, y: -500), duration: 1)
        let scale = SKAction.scale(by: 2.5, duration: 1.5)
        let dönme = SKAction.rotate(byAngle: 6.28 , duration: 1)
        let actions = [dönme, move, scale]
   //     let sequence = SKAction.sequence(actions)
        let anlık = SKAction.group(actions)
        character.run(anlık)
        
        character.name = "character"
        //character.physicsBody = SKPhysicsBody( rectangleOf: character.size)
        character.physicsBody?.isDynamic = false
        character.zPosition = 3
        
        returnMenuButtonNode.physicsBody = SKPhysicsBody(circleOfRadius: returnMenuButtonNode.size.width / 2.0)
        returnMenuButtonNode.physicsBody?.restitution = 0.4
        returnMenuButtonNode.physicsBody!.contactTestBitMask = returnMenuButtonNode.physicsBody!.collisionBitMask
        returnMenuButtonNode.physicsBody?.affectedByGravity = false
        returnMenuButtonNode.physicsBody?.isDynamic = false
        returnMenuButtonNode.zPosition = 1
        
        startStageButtonNode.physicsBody = SKPhysicsBody(circleOfRadius: startStageButtonNode.size.width / 2.0)
        startStageButtonNode.physicsBody?.restitution = 0.4
        startStageButtonNode.physicsBody!.contactTestBitMask = startStageButtonNode.physicsBody!.collisionBitMask
        startStageButtonNode.physicsBody?.affectedByGravity = false
        startStageButtonNode.physicsBody?.isDynamic = false
        startStageButtonNode.zPosition = 1
        

        let background = SKSpriteNode(imageNamed: "background2")
        background.size.width = self.frame.size.width * 1.7
        background.size.height = self.frame.size.height * 1.8
        background.position = CGPoint(x: (frame.size.width / 2) - 190, y: (frame.size.height / 2) - 380)
        background.zPosition = -3
        addChild(background)
        
        if let someNode:SKLabelNode = (self.childNode(withName: "astageLabel") as! SKLabelNode){
            stageLabelNode = someNode
            print("stageLabelNode linked")
        }
        
        if let someNode:SKLabelNode = (self.childNode(withName: "stageInfoLabel") as! SKLabelNode){
            infoLabelNode = someNode
            print("stageLabelNode linked")
        }
        

        if(userDefaults.integer(forKey: "stageKey") == 0 ){
            stageLabelNode.text = "TUTORIAL"
            infoLabelNode.fontSize = 34
            infoLabelNode.verticalAlignmentMode = .center
            infoLabelNode.text = "You will be informed \n about game in \n tutorial stage. \n If you ready swipe \n character to start."
        }else if(userDefaults.integer(forKey: "stageKey") == 1){
            stageLabelNode.text = "STAGE 1"
            infoLabelNode.fontSize = 34
            infoLabelNode.verticalAlignmentMode = .center
            infoLabelNode.text = "At this stage you should catch falling balls. Each ball gives youa different score (green scores below the balls). There is a risk of penalty (minus half of the ball scores). The risk probability written in the balls. Becareful! If you are ready, swipe the character to the start button."
            
        }else if(userDefaults.integer(forKey: "stageKey") == 2){
            stageLabelNode.text = "STAGE 2"
            infoLabelNode.fontSize = 34
            infoLabelNode.verticalAlignmentMode = .center
            infoLabelNode.text = "At this stage, there is an additional color matching question. When you catch a ball, colored buttons will appear at the bottom. You should match the ball color with the color name that will appears at the bottom. Keep in mind the button countdown is 3 seconds."
        }else if(userDefaults.integer(forKey: "stageKey") == 3){
            stageLabelNode.text = "STAGE 3"
            infoLabelNode.fontSize = 34
            infoLabelNode.verticalAlignmentMode = .center
            infoLabelNode.text = "At this stage,  there are two different color matching questions.  According the question you should match the ball color with the name of the color or color of the texts. Keep in mind the button countdown is still 3 seconds."
        }else if(userDefaults.integer(forKey: "stageKey") == 4){
            stageLabelNode.text = "STAGE 4"
            infoLabelNode.fontSize = 34
            infoLabelNode.verticalAlignmentMode = .center
            infoLabelNode.text = "At this stage,  if you choose a wrong color match you will get 5 point penalty.  If you don’t choose any button you will get same penalty (5 point). Keep in mind the button countdown is still 3 seconds."
        }else{

        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            character.run(SKAction.move(to: CGPoint(x:  characterPosition.x + location.x - startTouch.x, y: -505), duration: 0.1))
        }
        
        if(character.position.x - 70 > 120 && isClick == false){
            isClick = true
            startStageButtonNode.texture = SKTexture(imageNamed: "colorBtnPushed")
            print("sağda")
            if let sparkParticles = SKEmitterNode(fileNamed: "MyParticle") {
                sparkParticles.position.x = character.position.x - 80.0
                sparkParticles.position.y = character.position.y
                addChild(sparkParticles)
            }
            goTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(startStage), userInfo: nil, repeats: true)
            
        }
        
        if(character.position.x - 70 < -120 && isClick == false){
            isClick = true
            returnMenuButtonNode.texture = SKTexture(imageNamed: "colorBtnPushed")
            print("solda")
            if let sparkParticles = SKEmitterNode(fileNamed: "MyParticle") {
                sparkParticles.position.x = character.position.x - 80.0
                sparkParticles.position.y = character.position.y
                addChild(sparkParticles)
            }
            goTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(returnMenu), userInfo: nil, repeats: true)
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let touch = touches.first
        if let location = touch?.location(in: self){
            startTouch = location
            characterPosition = character.position
            let nodesArray = self.nodes(at: location)
            
        }
        
    }
    
    
    @objc func startStage() {
        goTimer.invalidate()
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.5)
                self.view!.presentScene(scene, transition: transition)
            }

    }
    
    @objc func returnMenu() {
        goTimer.invalidate()
                if let scene = SKScene(fileNamed: "MenuScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                let transition = SKTransition.doorsCloseHorizontal(withDuration: 1.0)
                self.view!.presentScene(scene, transition: transition)
            }

    }
    
    
    
}

