import SpriteKit

class PlatformFlyingBig: SKSpriteNode {
    
    init(type: Int, size: CGSize) {
        let platformNode = SKSpriteNode(imageNamed: "platform_\(type)_big_flying")
        platformNode.size = size
        
        platformNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: platformNode.size.width - 50, height: platformNode.size.height - 70))
        platformNode.physicsBody?.isDynamic = false
        platformNode.physicsBody?.affectedByGravity = false
        platformNode.physicsBody?.categoryBitMask = 5
        platformNode.physicsBody?.collisionBitMask = 1
        platformNode.physicsBody?.contactTestBitMask = 1
        platformNode.name = "platform_\(type)_big_flying"
        
        super.init(texture: nil, color: .clear, size: size)
        addChild(platformNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
