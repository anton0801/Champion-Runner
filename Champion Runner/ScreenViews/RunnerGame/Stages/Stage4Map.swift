import Foundation
import SpriteKit

class Stage4Map: Stage {
    func buildStage(scene: RunnerGameScene, cameraNode: SKCameraNode) {
        let platform1 = PlatformBig(type: 1, size: CGSize(width: 600, height: 200))
        platform1.position = CGPoint(x: 250, y: 100)
        scene.addChild(platform1)
        
        let star = SKSpriteNode(imageNamed: "star")
        star.position = CGPoint(x: 600, y: 250)
        star.physicsBody = SKPhysicsBody(rectangleOf: star.size)
        star.physicsBody?.isDynamic = false
        star.physicsBody?.affectedByGravity = false
        star.physicsBody?.categoryBitMask = 2
        star.physicsBody?.collisionBitMask = 1
        star.physicsBody?.contactTestBitMask = 1
        scene.addChild(star)
        
        let shipi = ShipiNode(size: CGSize(width: 80, height: 80))
        shipi.position = CGPoint(x: 100, y: 200)
        scene.addChild(shipi)
        let shipi2 = ShipiNode(size: CGSize(width: 80, height: 80))
        shipi2.position = CGPoint(x: 100, y: 300)
        scene.addChild(shipi2)
        
        let ship3 = ShipiNode(size: CGSize(width: 80, height: 80))
        ship3.position = CGPoint(x: 600, y: 50)
        scene.addChild(ship3)
        let shipi4 = ShipiNode(size: CGSize(width: 80, height: 80))
        shipi4.position = CGPoint(x: 700, y: 50)
        scene.addChild(shipi4)
        
        let platform2 = PlatformMedium(type: 1, size: CGSize(width: 400, height: 200))
        platform2.position = CGPoint(x: 850, y: 100)
        scene.addChild(platform2)
        
        let shipi6 = ShipiNode(size: CGSize(width: 80, height: 80))
        shipi6.position = CGPoint(x: 1000, y: 650)
        scene.addChild(shipi6)
        
        let platform3 = PlatformSmall(type: 1, size: CGSize(width: 250, height: 200))
        platform3.position = CGPoint(x: 1250, y: 100)
        scene.addChild(platform3)
        
        let platform4 = PlatformFlyingSmall(type: 1, isMovable: true, size: CGSize(width: 100, height: 140))
        platform4.position = CGPoint(x: 1150, y: 300)
        scene.addChild(platform4)
        
        let platform5 = PlatformFlyingMedium(type: 1, size: CGSize(width: 140, height: 180))
        platform5.position = CGPoint(x: 1000, y: 400)
        scene.addChild(platform5)
        
        let platform6 = PlatformFlyingBig(type: 1, size: CGSize(width: 180, height: 220))
        platform6.position = CGPoint(x: 800, y: 500)
        scene.addChild(platform6)
        
        let shipi7 = ShipiNode(size: CGSize(width: 80, height: 80))
        shipi7.position = CGPoint(x: 700, y: 400)
        scene.addChild(shipi7)
        
        let star2 = SKSpriteNode(imageNamed: "star")
        star2.position = CGPoint(x: 800, y: 590)
        star2.physicsBody = SKPhysicsBody(rectangleOf: star.size)
        star2.physicsBody?.isDynamic = false
        star2.physicsBody?.affectedByGravity = false
        star2.physicsBody?.categoryBitMask = 2
        star2.physicsBody?.collisionBitMask = 1
        star2.physicsBody?.contactTestBitMask = 1
        scene.addChild(star2)
        
        let platform7 = PlatformBig(type: 1, size: CGSize(width: 600, height: 200))
        platform7.position = CGPoint(x: 350, y: 500)
        platform7.name = "final"
        scene.addChild(platform7)
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
