//
//  PlayingState.swift
//  Wildz
//
//  Created by Tanya Koldunova on 24.10.2022.
//

import Foundation
import GameplayKit

class PlayingState: GKState {
    weak var gameSceneManager: GameSceneManager?
    lazy var backgroundNode: SKSpriteNode = createBackground()
    lazy var castleNode: CastleNode = CastleNode()
    lazy var coinLabel: CoinsLabel = CoinsLabel()
    lazy var scoreLabel: ScoreLabel = ScoreLabel(custom: true)
    
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
    }
    override func didEnter(from previousState: GKState?) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        zombieSoundPlay()
        castleNode.position = CGPoint(x: -scene.size.width/2 + 36, y: 0)
        spawnground(scene: scene)
        let ground = gameSceneManager.groundNodes[Int.random(in: 0..<gameSceneManager.groundNodes.count)]
        let chooseMenu = ChooseNode()
        chooseMenu.position = CGPoint(x: -scene.size.width/2 + chooseMenu.size.width/2 + 2, y: scene.size.height/2 - chooseMenu.size.height/2 - 16)
        coinLabel.position = CGPoint(x: scene.size.width/2 - coinLabel.size.width/2 - 8, y: scene.size.height/2 - coinLabel.size.height/2 - 32)
        scoreLabel.position =  CGPoint(x: 16, y: scene.size.height/2 - scoreLabel.frame.size.height/2 - 32)
        let progressBar = LightningBar()
        progressBar.position = CGPoint(x: scene.size.width/2 - progressBar.size.width/2 - 148, y: scene.size.height/2 - coinLabel.size.height/2 - 32)
        scene.addChild(chooseMenu)
        gameSceneManager.toucheble.append(chooseMenu)
        gameSceneManager.toucheble.append(progressBar)
        gameSceneManager.updatable.append(scoreLabel)
        scene.addChild(backgroundNode)
        scene.addChild(castleNode)
        scene.addChild(coinLabel)
        scene.addChild(scoreLabel)
        scene.addChild(progressBar)
     //   scene.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(createEnemies), SKAction.wait(forDuration: TimeInterval.random(in: 1...10))])))
    }

    
    override func willExit(to nextState: GKState) {
        guard let scene = gameSceneManager?.scene else {return}
        if let scoreNode = scene.childNode(withName: "score node") as? ScoreLabel {
            gameSceneManager?.gameTime = scoreNode.value
        }
        scene.removeAllChildren()
    }

}


extension PlayingState {
    func createBackground()->SKSpriteNode {
        guard let scene = gameSceneManager?.scene else {return SKSpriteNode()}
        let backgroundNode = SKSpriteNode(imageNamed: "background")
        backgroundNode.size = scene.size
        backgroundNode.zPosition = 1.0
        return backgroundNode
    }
    
    func spawnground(scene: SKScene){
        guard let gameSceneManager = gameSceneManager else {return}
        let height = scene.size.height - 100
        print(scene.size.height)
        print(UIScreen.main.bounds.height)
        let count = Int(height)/80
        var start = -scene.size.height/2 + 50 + 40
        for i in 0..<count {
            let node = GroundNode()
            node.position = CGPoint(x: -scene.size.width/2 + 100 + node.size.width/2, y: start)
            scene.addChild(node)
            gameSceneManager.groundNodes.append(node)
            gameSceneManager.toucheble.append(node)
            start += 80
        }
        
    }
    
    func createEnemies() {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        let random = Int.random(in: 0..<gameSceneManager.groundNodes.count)
        let enemyNode = EnemyNode()
        enemyNode.position = CGPoint(x: scene.size.width/2, y: gameSceneManager.groundNodes[random].position.y)
        scene.addChild(enemyNode)
        enemyNode.move()
       
    }
}
