//
//  GameScene.swift
//  HRGame
//
//  Created by Can Babaoğlu on 24.08.2019.
//  Copyright © 2019 Can Babaoğlu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var character = SKSpriteNode()
    var characterPosition = CGPoint()
    var startTouch = CGPoint()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size.height = 1500
        background.position = CGPoint(x: 0, y: 0)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody (edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        character.name = "character"
        character = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 100))
        character.position = CGPoint (x: 0, y: -640)
        character.physicsBody = SKPhysicsBody( rectangleOf: character.size)
        character.physicsBody?.isDynamic = false
        self.addChild(character)
        
        //addBall(at: CGPoint (x: 300, y: 640), name: "ballRed", size: CGSize(width: 80, height: 80))
        addBall(at: CGPoint (x: 200, y: 640), name: "ballBlue", size: CGSize(width: 90, height: 90))
        //addBall(at: CGPoint (x: 100, y: 640), name: "ballCyan", size: CGSize(width: 80, height: 80))
        addBall(at: CGPoint (x: 0, y: 640), name: "ballGreen", size: CGSize(width: 90, height: 90))
        //addBall(at: CGPoint (x: -100, y: 640), name: "ballGrey", size: CGSize(width: 80, height: 80))
        addBall(at: CGPoint (x: -200, y: 640), name: "ballPurple", size: CGSize(width: 90, height: 90))
        //addBall(at: CGPoint (x: -300, y: 640), name: "ballYellow", size: CGSize(width: 80, height: 80))
        
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
            character.run(SKAction.move(to: CGPoint(x:  characterPosition.x + location.x - startTouch.x, y: -640), duration: 0.1))
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
        physicsWorld.gravity = CGVector(dx: 0, dy: -12)
        addChild(ball)
    }
    
    func collisionBetween(character: SKNode, ball: SKNode) {

        switch ball.name {
        case "ballRed":
            destroy(ball: ball)
        case "ballBlue":
            destroy(ball: ball)
        case "ballCyan":
            destroy(ball: ball)
        case "ballGreen":
            destroy(ball: ball)
        case "ballGrey":
            destroy(ball: ball)
        case "ballPurple":
            destroy(ball: ball)
        case "ballYellow":
            destroy(ball: ball)
        default:
            print("farklı bişe çarptı!!!")
        }
        
    }
    
    func destroy(ball: SKNode) {
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
