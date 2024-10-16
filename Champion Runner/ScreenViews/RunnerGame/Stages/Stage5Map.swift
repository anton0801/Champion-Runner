import Foundation
import SpriteKit

class Stage5Map: Stage {
    func buildStage(scene: RunnerGameScene, cameraNode: SKCameraNode) {
        
    }
    
    func createPersonage(scene: RunnerGameScene, cameraNode: SKCameraNode) -> SKSpriteNode {
        let personage = SKSpriteNode(imageNamed: UserDefaults.standard.string(forKey: "selectedSkin") ?? "skin_1")
        personage.position = CGPoint(x: 350, y: 200)
        personage.physicsBody = SKPhysicsBody(rectangleOf: personage.size)
        personage.physicsBody?.isDynamic = true
        personage.physicsBody?.affectedByGravity = true
        personage.physicsBody?.categoryBitMask = 1
        personage.physicsBody?.collisionBitMask = 2 | 3 | 4 | 5
        personage.physicsBody?.contactTestBitMask = 2 | 3 | 4 | 5
        scene.addChild(personage)
        return personage
    }
}
