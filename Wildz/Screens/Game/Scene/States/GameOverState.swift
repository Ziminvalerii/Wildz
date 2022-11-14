//
//  GameOverState.swift
//  Wildz
//
//  Created by Tanya Koldunova on 06.11.2022.
//

import Foundation
import GameplayKit

class GameOverState: GKState {
    weak var gameSceneManager: GameSceneManager?
    lazy var backgroundNode: SKSpriteNode = createBackground()
    lazy var gameOverLabel: SKLabelNode = {
        let node = SKLabelNode("Game over", size: 48)
        node.zPosition = 10.0
        return node
    }()
    lazy var scoreLabel: SKLabelNode = {
        let node = SKLabelNode("Your score: 00:00", size: 24)
        node.zPosition = 10.0
        return node
    }()
    lazy var newRecordLabel: SKLabelNode = {
        let node = SKLabelNode("New record", size: 28)
        node.zPosition = 10.0
        return node
    }()
    lazy var goToGameButton: GoToGameButtonNode = GoToGameButtonNode()
    init(gameSceneManager: GameSceneManager) {
        self.gameSceneManager = gameSceneManager
    }
    override func didEnter(from previousState: GKState?) {
        guard let gameSceneManager = gameSceneManager else {return}
        guard let scene = gameSceneManager.scene else {return}
        scene.addChild(backgroundNode)
        gameOverLabel.position = CGPoint(x: 0, y: scene.size.height/2 - gameOverLabel.frame.size.height/2 - 64)
        if let scoreString = gameSceneManager.gameTime {
            scoreLabel.setStrokeText("Your score: \(scoreString.timeString())", size: 32)
            if UserDefaultsValues.bestScore < scoreString {
                UserDefaultsValues.bestScore = scoreString
                congratulationSoundPlay()
                newRecordLabel.position = CGPoint(x: 0, y: scoreLabel.position.y + scoreLabel.frame.size.height/2 + newRecordLabel.frame.size.height/2 + 12)
                scene.addChild(newRecordLabel)
            }
        }
        UserDefaultsValues.coinsCount += gameSceneManager.coinsCount
        goToGameButton.position = CGPoint(x: 0, y: -scene.size.height/2 + goToGameButton.size.height/2 + 64)
        gameSceneManager.toucheble.append(goToGameButton)
        scene.addChild(gameOverLabel)
        scene.addChild(scoreLabel)
        scene.addChild(goToGameButton)
    }

    
    override func willExit(to nextState: GKState) {
    }
    
    func createBackground()->SKSpriteNode {
        guard let scene = gameSceneManager?.scene else {return SKSpriteNode()}
        let backgroundNode = SKSpriteNode(imageNamed: "gameOverBackground")
        backgroundNode.size = scene.size
        backgroundNode.zPosition = 9.0
        return backgroundNode
    }
    
   
}
