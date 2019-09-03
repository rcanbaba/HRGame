//
//  GameScene.swift
//  HRGame
//
//  Created by Can Babaoğlu on 24.08.2019.
//  Copyright © 2019 Can Babaoğlu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var character:SKSpriteNode = SKSpriteNode()
    var characterPosition = CGPoint()
    var pad:SKSpriteNode = SKSpriteNode()
    var startTouch = CGPoint()
    var scoreLabel: SKLabelNode!
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
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
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
        
        nextRow(row: stageCount+1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            startTouch = location
            characterPosition = character.position
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            character.run(SKAction.move(to: CGPoint(x:  characterPosition.x + location.x - startTouch.x, y: -400), duration: 0.1))
        }
    }
    
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
    
    func collisionBetween(character: SKNode, ball: SKNode) {

        pad.zPosition = 2
        switch ball.name {
        case "ballRed":
            score = score + 10
            destroy(ball: ball)
        case "ballBlue":
            destroy(ball: ball)
            score = score + 25
        case "ballCyan":
            destroy(ball: ball)
            score = score + -5
        case "ballGreen":
            destroy(ball: ball)
            score = score + -1
        case "ballGrey":
            destroy(ball: ball)
            score = score + 1
        case "ballPurple":
            destroy(ball: ball)
            score = score + 3
        case "ballYellow":
            destroy(ball: ball)
            score = score + 20
        default:
            print("farklı bir şey çarptı!!!")
        }
        stageCount = stageCount + 1
        nextRow(row: stageCount)
    }
    
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
    
    func destroy(ball: SKNode) {
//        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
//            fireParticles.position = ball.position
//            addChild(fireParticles)
//        }
        ball.removeFromParent()
    }
    
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
    
}
