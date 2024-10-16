import SpriteKit

class PlatformFlyingSmall: SKSpriteNode {
    
    init(type: Int, size: CGSize) {
        let platformNode = SKSpriteNode(imageNamed: "platform_\(type)_small_flying")
        platformNode.size = size
        
        super.init(texture: nil, color: .clear, size: size)
        addChild(platformNode)
    }
    
    init(type: Int, isMovable: Bool, size: CGSize) {
        let platformNode = SKSpriteNode(imageNamed: "platform_\(type)_small_flying")
        platformNode.size = size
        
        platformNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: platformNode.size.width - 50, height: platformNode.size.height - 40))
        platformNode.physicsBody?.isDynamic = false
        platformNode.physicsBody?.affectedByGravity = false
        platformNode.physicsBody?.categoryBitMask = 5
        platformNode.physicsBody?.collisionBitMask = 1
        platformNode.physicsBody?.contactTestBitMask = 1
        platformNode.name = "platform_\(type)_small_flying"
        
        super.init(texture: nil, color: .clear, size: size)
        addChild(platformNode)
        
        if isMovable {
            platformNode.zPosition = 1
            let line = SKSpriteNode(imageNamed: "line_vertical")
            line.zPosition = 1
            addChild(line)
            
            let moveUpFirstAction = SKAction.move(to: CGPoint(x: 0, y: 80), duration: 1)
            let moveUpAction = SKAction.move(to: CGPoint(x: 0, y: 80), duration: 2)
            let moveDownAction = SKAction.move(to: CGPoint(x: 0, y: -80), duration: 2)
            let repeate = SKAction.repeatForever(SKAction.sequence([moveDownAction, moveUpAction]))
            let seq = SKAction.sequence([moveUpFirstAction, repeate])
            platformNode.run(seq)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
