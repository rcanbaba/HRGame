//
//  MenuScene.swift
//  HRGame
//
//  Created by Can Babaoğlu on 28.09.2019.
//  Copyright © 2019 Can Babaoğlu. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {

    var starfield:SKEmitterNode!
    
    var newGameButtonNode:SKSpriteNode!
    var stageButtonNode:SKSpriteNode!
    var stageLabelNode:SKLabelNode!
    var exitGameButtonNode:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        starfield = (self.childNode(withName: "starfield") as! SKEmitterNode)
        starfield.advanceSimulationTime(10)
        
        let background = SKSpriteNode(imageNamed: "background2")
        background.size.width = self.frame.size.width * 1.7
        background.size.height = self.frame.size.height * 1.8
        background.position = CGPoint(x: (frame.size.width / 2) - 190, y: (frame.size.height / 2) - 160)
        background.zPosition = -3
        addChild(background)
        
        newGameButtonNode = (self.childNode(withName: "newGameButton") as! SKSpriteNode)
        stageButtonNode = (self.childNode(withName: "stageButton") as! SKSpriteNode)
        stageButtonNode.texture = SKTexture(imageNamed: "stageButton")
        exitGameButtonNode = (self.childNode(withName: "exitGameButton") as! SKSpriteNode)
        stageLabelNode = (self.childNode(withName: "stageLabel") as! SKLabelNode)
        
        let userDefaults = UserDefaults.standard
        
        if(userDefaults.integer(forKey: "stageKey") == 0 ){
            stageLabelNode.text = "Tutorial"
        }else if(userDefaults.integer(forKey: "stageKey") == 1){
            stageLabelNode.text = "Stage 1"
        }else if(userDefaults.integer(forKey: "stageKey") == 2){
            stageLabelNode.text = "Stage 2"
        }else if(userDefaults.integer(forKey: "stageKey") == 3){
            stageLabelNode.text = "Stage 3"
        }else{
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            if (nodesArray.first?.name == "newGameButton"){
                
                
                
                //let transition = SKTransition.flipHorizontal(withDuration: 0.5)
               // let gameScene = GameScene(size: self.size)
                //self.view?.presentScene(gameScene,transition: transition)
                
                if let scene = SKScene(fileNamed: "StartScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    // Present the scene
                    let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.5)
                    self.view!.presentScene(scene, transition: transition)
                }
            }else if(nodesArray.first?.name == "stageButton"){
                changeStage()
            }else if(nodesArray.first?.name == "exitGameButton"){
                let scenek = SKScene(fileNamed: "StartScene")
                scenek!.camera!.addChild(exitGameButtonNode)
            }
        }
    }
    
    func changeStage(){
        let userDefaults = UserDefaults.standard
        
        if (stageLabelNode.text == "Tutorial"){
            stageLabelNode.text = "Stage 1"
            userDefaults.set(1 , forKey: "stageKey")
        }else if(stageLabelNode.text == "Stage 1"){
            stageLabelNode.text = "Stage 2"
            userDefaults.set(2 , forKey: "stageKey")
        }else if(stageLabelNode.text == "Stage 2"){
            stageLabelNode.text = "Stage 3"
            userDefaults.set(3 , forKey: "stageKey")
        }else if(stageLabelNode.text == "Stage 3"){
            stageLabelNode.text = "Tutorial"
            userDefaults.set(0 , forKey: "stageKey")
        }else{
            
        }
        userDefaults.synchronize()
    }
    
    
}
