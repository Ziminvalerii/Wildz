//
//  GameScene.swift
//  Wildz
//
//  Created by Tanya Koldunova on 24.10.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    weak var parentVC: GameViewController?
  //  var parentVC: UIViewController?
    var gameManager: GameSceneManager!
    private var prevDate: TimeInterval?
    private var enemyCount: Int = 0
    private var interval: Int = 15
    var divide: Int = 8
  
    lazy var stateMachine: GKStateMachine = GKStateMachine(states: [
        PlayingState(gameSceneManager: gameManager),
        GameOverState(gameSceneManager: gameManager)
    ])
    override func sceneDidLoad() {
        gameManager = GameSceneManager(scene: self)
    }
    
    override func didMove(to view: SKView) {
        
        stateMachine.enter(PlayingState.self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameManager.toucheble.forEach { touchable in
            touchable.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameManager.toucheble.forEach { touchable in
            touchable.touchesMoved(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        gameManager.toucheble.forEach { touchable in
            touchable.touchesEnded(touches, with: event)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    
    override func update(_ currentTime: TimeInterval) {
        gameManager.updatable.forEach { node in
            node.update(timeInterval: currentTime)
        }
        if interval == 0 {
            interval = 3
      //      self.stateMachine.enter(GameOverState.self)
            return
        }
        if Int(currentTime)%interval == 0 && Int(prevDate ?? 0) != Int(currentTime) {
            createEnemies()
            enemyCount += 1
            prevDate = currentTime
            if divide == 0 {
                divide = 3
   //             self.stateMachine.enter(GameOverState.self)
                return
            }
                if enemyCount%divide == 0 {
                    zombieSoundPlay()
                    interval -= 1
                    divide -= 1
                }
        }
      
    }
    
    func createEnemies() {
        let random = Int.random(in: 0..<gameManager.groundNodes.count)
        var enemies: [EnemyProtocol] = [EnemyNode()]
        if enemyCount > 8 {
            enemies.append(MediumEnemyNode())
        }
        if enemyCount > 16 {
            enemies.append(HugeEnemyNode())
        }
        let enemyNode = enemies[Int.random(in: 0 ..< enemies.count)]
        enemyNode.position = CGPoint(x: self.size.width/2, y: 0)
        gameManager.groundNodes[random].addChild(enemyNode)
        enemyNode.move()

    }
}

extension GameScene: Dependable {
    func switchState(state: GameStates) {
        if state == .gameOver {
            stateMachine.enter(GameOverState.self)
        } else if state == .goToGame {
            parentVC?.dissmiss()
        }
    }
}
