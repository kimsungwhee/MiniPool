//
//  MyScene.m
//  MiniPool
//
//  Created by Sungwhee Kim on 13-11-1.
//  Copyright (c) 2013年 Kimsungwhee. All rights reserved.
//

#import "MyScene.h"

static const uint32_t tableEdgeCategory = 0x1 << 0;
static const uint32_t ballCategory = 0x1 << 1;

#define TEXTUREALTAS [SKTextureAtlas atlasNamed:@"images"]

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        [self initContentView];
        
    }
    return self;
}

-(void)initContentView{
    
//    self.physicsWorld.gravity = CGVectorMake(0, 0);
//    SKTextureAtlas * images = [SKTextureAtlas atlasNamed:@"images"];
    SKSpriteNode * bgTable = [SKSpriteNode spriteNodeWithTexture:[TEXTUREALTAS textureNamed:@"pocketBall_table"]];
    bgTable.anchorPoint = CGPointMake(0, 0);
    [self addChild:bgTable];
    [self setupTablePhysicsEdge];
    
}

-(void)setupTablePhysicsEdge
{
    SKSpriteNode * leftEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(1,self.size.height - 104)];
    leftEdge.position = CGPointMake(30, self.size.height/2);
    leftEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftEdge.size];
    leftEdge.physicsBody.dynamic = NO;
    leftEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    leftEdge.physicsBody.collisionBitMask = ballCategory;
    leftEdge.physicsBody.contactTestBitMask = 0;
    [self addChild:leftEdge];
    
    SKSpriteNode * topLeftEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(218, 1)];
    topLeftEdge.position = CGPointMake(158, self.size.height-34);
    topLeftEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topLeftEdge.size];
    topLeftEdge.physicsBody.dynamic = NO;
    topLeftEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    topLeftEdge.physicsBody.collisionBitMask = ballCategory;
    topLeftEdge.physicsBody.contactTestBitMask = 0;
    [self addChild:topLeftEdge];
    
    SKSpriteNode * topRightEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(218, 1)];
    topRightEdge.position = CGPointMake(410, self.size.height-34);
    topRightEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topRightEdge.size];
    topRightEdge.physicsBody.dynamic = NO;
    topRightEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    topRightEdge.physicsBody.collisionBitMask = ballCategory;
    topRightEdge.physicsBody.contactTestBitMask = 0;
    [self addChild:topRightEdge];
    
    SKSpriteNode * rightEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(1, self.size.height - 104)];
    rightEdge.position = CGPointMake(self.size.width - 30, self.size.height/2);
    rightEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightEdge.size];
    rightEdge.physicsBody.dynamic = NO;
    rightEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    rightEdge.physicsBody.collisionBitMask = ballCategory;
    rightEdge.physicsBody.contactTestBitMask = 0;
    [self addChild:rightEdge];
    
    SKSpriteNode * bottomLeftEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(218, 1)];
    bottomLeftEdge.position = CGPointMake(158, 34);
    bottomLeftEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomLeftEdge.size];
    bottomLeftEdge.physicsBody.dynamic = NO;
    bottomLeftEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    bottomLeftEdge.physicsBody.collisionBitMask = ballCategory;
    bottomLeftEdge.physicsBody.contactTestBitMask = 0;
    [self addChild:bottomLeftEdge];
    
    SKSpriteNode * bottomRightEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(218, 1)];
    bottomRightEdge.position = CGPointMake(410, 34);
    bottomRightEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightEdge.size];
    bottomRightEdge.physicsBody.dynamic = NO;
    bottomRightEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    bottomRightEdge.physicsBody.collisionBitMask = ballCategory;
    bottomRightEdge.physicsBody.contactTestBitMask = 0;
    [self addChild:bottomRightEdge];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode * node = [SKSpriteNode spriteNodeWithTexture:[TEXTUREALTAS textureNamed:@"redBall"]];
        node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:node.size.width/2];
        node.position = location;
        [self addChild:node];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
