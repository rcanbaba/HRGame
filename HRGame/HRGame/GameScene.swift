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
        physicsBody = SKPhysicsBody (edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        // node set up
        character = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 100))
        character.position = CGPoint (x: 0, y: -640)
        self.addChild(character)
        
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
    
}
