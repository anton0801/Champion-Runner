import SpriteKit
import SwiftUI

class RunnerGameScene: SKScene, SKPhysicsContactDelegate {
    
    let stage: String
    var stageMap: Stage
    
    private var cameraNode: SKCameraNode!
    
    private var personage: SKSpriteNode!
    
    private var backBtn: SKSpriteNode!
    
    private var goLeftBtn: SKSpriteNode!
    private var goRightBtn: SKSpriteNode!
    private var jumpBtn: SKSpriteNode!
    
    private var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    private var scoreLabel: SKLabelNode!
    
    private var balance = UserDefaults.standard.integer(forKey: "balance") {
        didSet {
            balanceLabel.text = "\(balance)"
            UserDefaults.standard.set(balance, forKey: "balance")
        }
    }
    private var balanceLabel: SKLabelNode!
    
    init(stage: String) {
        self.stage = stage
        switch stage {
        case "Stage_1":
            stageMap = Stage1Map()
        case "Stage_2":
            stageMap = Stage2Map()
        case "Stage_3":
            stageMap = Stage3Map()
        case "Stage_4":
            stageMap = Stage4Map()
        default:
            stageMap = Stage5Map()
        }
        super.init(size: CGSize(width: 1450, height: 810))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 1450, height: 810)
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.8)
        physicsWorld.contactDelegate = self
        
        cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        self.camera = cameraNode
        self.addChild(cameraNode)
        
        let backgroundStage = SKSpriteNode(imageNamed: "\(stage)_bg")
        // backgroundStage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgroundStage.size = size
        backgroundStage.zPosition = -1
        cameraNode.addChild(backgroundStage)
        
        stageMap.buildStage(scene: self, cameraNode: cameraNode)
        personage = stageMap.createPersonage(scene: self, cameraNode: cameraNode)
        
        let balanceBackground = SKSpriteNode(imageNamed: "balance")
        balanceBackground.position = CGPoint(x: (size.width / 2) - 150, y: (size.height / 2) - 150)
        balanceBackground.size = CGSize(width: 250, height: 100)
        cameraNode.addChild(balanceBackground)
        
        balanceLabel = SKLabelNode(text: "\(balance)")
        balanceLabel.fontSize = 42
        balanceLabel.fontColor = .white
        balanceLabel.fontName = "Alkalami-Regular"
        balanceLabel.position = CGPoint(x: (size.width / 2) - 150, y: (size.height / 2) - 165)
        cameraNode.addChild(balanceLabel)
        
        backBtn = SKSpriteNode(imageNamed: "btn_back")
        backBtn.position = CGPoint(x: -(size.width / 2) + 150, y: (size.height / 2) - 150)
        backBtn.size = CGSize(width: 90, height: 100)
        cameraNode.addChild(backBtn)
        
        let scoreBack = SKSpriteNode(imageNamed: "score_back")
        scoreBack.position = CGPoint(x: 0, y: (size.height / 2) - 150)
        scoreBack.size = CGSize(width: 250, height: 100)
        cameraNode.addChild(scoreBack)
        
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = .white
        scoreLabel.fontName = "Alkalami-Regular"
        scoreLabel.position = CGPoint(x: 60, y: (size.height / 2) - 160)
        cameraNode.addChild(scoreLabel)
        
        goLeftBtn = SKSpriteNode(imageNamed: "arrow_left")
        goLeftBtn.position = CGPoint(x: -(size.width / 2) + 150, y: -(size.height / 2) + 150)
        goLeftBtn.zPosition = 10
        goLeftBtn.size = CGSize(width: 120, height: 140)
        cameraNode.addChild(goLeftBtn)
        
        goRightBtn = SKSpriteNode(imageNamed: "arrow_right")
        goRightBtn.position = CGPoint(x: -(size.width / 2) + 300, y: -(size.height / 2) + 150)
        goRightBtn.zPosition = 10
        goRightBtn.size = CGSize(width: 120, height: 140)
        cameraNode.addChild(goRightBtn)
        
        if UserDefaults.standard.integer(forKey: "control_type") == 1 {
            jumpBtn = SKSpriteNode(imageNamed: "arrow_up")
            jumpBtn.position = CGPoint(x: (size.width / 2) - 150, y: -(size.height / 2) + 150)
            jumpBtn.zPosition = 10
            jumpBtn.size = CGSize(width: 120, height: 140)
            cameraNode.addChild(jumpBtn)
        }
        
        // moveCameraUp(by: 500, duration: 3)
    }
    
    func moveCameraUp(by distance: CGFloat, duration: TimeInterval) {
        let moveAction = SKAction.moveBy(x: 0, y: distance, duration: duration)
        cameraNode.run(moveAction)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesAtPoint = nodes(at: location)
            
            for node in nodesAtPoint {
                if node == goLeftBtn {
                    isMoving = true
                    goLeft()
                    return
                } else if node == goRightBtn {
                    isMoving = true
                    goRight()
                    return
                } else if node == backBtn {
                    NotificationCenter.default.post(name: Notification.Name("go_back"), object: nil)
                    return
                }
                
                if jumpBtn != nil {
                    if node == jumpBtn {
                        jump()
                    }
                } else {
                    jump()
                }
            }
        }
    }
    
    private var isJumped = false
    
    private func jump() {
        if !isJumped {
            isJumped = true
            let jumpAction = SKAction.moveTo(y: personage.position.y + 80, duration: 0.4)
            personage.run(jumpAction) {
                self.isJumped = false
            }
        }
    }
    
    private func goLeft() {
        if isMoving {
            personage.position.x -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.goLeft()
            }
        }
//        let moveLeft = SKAction.move(to: CGPoint(x: personage.position.x - 10, y: personage.position.y), duration: 0.1)
//        personage.run(moveLeft) {
//            self.goLeft()
//        }
    }
    
    private var isMoving = false
    
    private func goRight() {
//        let moveLeft = SKAction.move(to: CGPoint(x: personage.position.x + 10, y: personage.position.y), duration: 0.1)
//        personage.run(moveLeft) {
//            self.goRight()
//        }
        if isMoving {
            personage.position.x += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.goRight()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesAtPoint = nodes(at: location)
            
            for node in nodesAtPoint {
                if node == goLeftBtn {
                    isMoving = false
                    personage.removeAllActions()
                }
                if node == goRightBtn {
                    isMoving = false
                    personage.removeAllActions()
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        if (contactA.categoryBitMask == 1 && contactB.categoryBitMask == 2) ||
            (contactA.categoryBitMask == 2 && contactB.categoryBitMask == 1) {
            let starBody: SKPhysicsBody = contactA.categoryBitMask == 1 ? contactB : contactA
            
            balance += 100
            score += 100
            
            if let node = starBody.node {
                node.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()]))
            }
        }
        
        if (contactA.categoryBitMask == 1 && contactB.categoryBitMask == 3) ||
            (contactA.categoryBitMask == 3 && contactB.categoryBitMask == 1) {
            personage.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.removeFromParent()]))
            gameOver()
        }
        
        if (contactA.categoryBitMask == 1 && contactB.categoryBitMask == 5) ||
            (contactA.categoryBitMask == 5 && contactB.categoryBitMask == 1) {
            let platformNode: SKPhysicsBody = contactA.categoryBitMask == 1 ? contactB : contactA
            
            if let node = platformNode.node,
               let nodeName = node.name  {
                if nodeName == "final" {
                    win()
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if personage.position.y <= 0 {
            gameOver()
        }
    }
    
    private func gameOver() {
        NotificationCenter.default.post(name: Notification.Name("game_over_loss"), object: nil, userInfo: ["score": score])
        isPaused = true
    }
    
    private func win() {
        NotificationCenter.default.post(name: Notification.Name("game_over_win"), object: nil, userInfo: ["score": score])
        isPaused = true
    }
    
    func restartRunnerLevel() -> RunnerGameScene {
        let scene = RunnerGameScene(stage: stage)
        view?.presentScene(scene)
        return scene
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: RunnerGameScene(stage: "Stage_4"))
            .ignoresSafeArea()
    }
}
