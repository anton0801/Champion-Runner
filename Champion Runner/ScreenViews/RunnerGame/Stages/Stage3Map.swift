import Foundation
import SpriteKit

class Stage3Map: Stage {
    func buildStage(scene: RunnerGameScene, cameraNode: SKCameraNode) {
        let platform1 = PlatformMedium(type: 2, size: CGSize(width: 400, height: 200))
        platform1.position = CGPoint(x: 250, y: 100)
        scene.addChild(platform1)
        
        let platform2 = PlatformFlyingSmall(type: 2, isMovable: true, size: CGSize(width: 100, height: 140))
        platform2.position = CGPoint(x: 550, y: 100)
        scene.addChild(platform2)
        
        let platform3 = PlatformSmall(type: 2, size: CGSize(width: 250, height: 200))
        platform3.position = CGPoint(x: 800, y: 100)
        scene.addChild(platform3)
        
        let pila = PilaNode(isVertical: true, size: CGSize(width: 100, height: 150))
        pila.position = CGPoint(x: 1000, y: 250)
        scene.addChild(pila)
        
        let star = SKSpriteNode(imageNamed: "star")
        star.position = CGPoint(x: 1150, y: 230)
        star.physicsBody = SKPhysicsBody(rectangleOf: star.size)
        star.physicsBody?.isDynamic = false
        star.physicsBody?.affectedByGravity = false
        star.physicsBody?.categoryBitMask = 2
        star.physicsBody?.collisionBitMask = 1
        star.physicsBody?.contactTestBitMask = 1
        scene.addChild(star)
        
        let platform4 = PlatformMedium(type: 2, size: CGSize(width: 400, height: 200))
        platform4.position = CGPoint(x: 1250, y: 100)
        platform4.name = "final"
        scene.addChild(platform4)
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
