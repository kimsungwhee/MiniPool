//
//  MyScene.m
//  MiniPool
//
//  Created by Sungwhee Kim on 13-11-1.
//  Copyright (c) 2013年 Kimsungwhee. All rights reserved.
//

#import "MyScene.h"



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
    SKTextureAtlas * images = [SKTextureAtlas atlasNamed:@"images"];
    SKSpriteNode * bgTable = [SKSpriteNode spriteNodeWithTexture:[images textureNamed:@"pocketBall_table"]];
    bgTable.anchorPoint = CGPointMake(0, 0);
    [self addChild:bgTable];
    [self setupTablePhysicsEdge];
    
}

-(void)setupTablePhysicsEdge
{
    SKSpriteNode * leftEdge = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(1,self.size.height - 104)];
    leftEdge.position = CGPointMake(30, self.size.height/2);
    leftEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftEdge.size];
    leftEdge.physicsBody.dynamic = NO;
    [self addChild:leftEdge];
    
    SKSpriteNode * topLeftEdge = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(220, 1)];
    topLeftEdge.position = CGPointMake(48, self.size.height-34+110);
    topLeftEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topLeftEdge.size];
    topLeftEdge.physicsBody.dynamic = NO;
    [self addChild:topLeftEdge];
    
    SKSpriteNode * topRightEdge = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(220, 1)];
    topRightEdge.position = CGPointMake(410, self.size.height-34);
    topRightEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topRightEdge.size];
    topRightEdge.physicsBody.dynamic = NO;
    [self addChild:topRightEdge];
    
    SKSpriteNode * rightEdge = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(1, self.size.height - 104)];
    rightEdge.position = CGPointMake(self.size.width - 30, self.size.height/2);
    rightEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightEdge.size];
    rightEdge.physicsBody.dynamic = NO;
    [self addChild:rightEdge];
    
    SKSpriteNode * bottomLeftEdge = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(220, 1)];
    bottomLeftEdge.position = CGPointMake(158, 34);
    bottomLeftEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomLeftEdge.size];
    bottomLeftEdge.physicsBody.dynamic = NO;
    [self addChild:bottomLeftEdge];
    
    SKSpriteNode * bottomRightEdge = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(220, 1)];
    bottomRightEdge.position = CGPointMake(410, 34);
    bottomRightEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightEdge.size];
    bottomRightEdge.physicsBody.dynamic = NO;
    [self addChild:bottomRightEdge];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode * node = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(20, 20)];
        node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
        node.position = location;
        [self addChild:node];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
