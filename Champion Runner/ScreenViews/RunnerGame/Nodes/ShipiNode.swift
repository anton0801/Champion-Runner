import SpriteKit

class ShipiNode: SKSpriteNode {
    
    init(size: CGSize) {
        let shipi = SKSpriteNode(imageNamed: "shipi")
        shipi.size = size
        
        shipi.physicsBody = SKPhysicsBody(rectangleOf: shipi.size)
        shipi.physicsBody?.isDynamic = false
        shipi.physicsBody?.affectedByGravity = false
        shipi.physicsBody?.categoryBitMask = 3
        shipi.physicsBody?.collisionBitMask = 1
        shipi.physicsBody?.contactTestBitMask = 1
        shipi.name = "shipi"
        
        super.init(texture: nil, color: .clear, size: size)
        addChild(shipi)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
