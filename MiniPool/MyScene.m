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
static const uint32_t pocketCategory = 0x1 << 2;

#define TEXTUREALTAS [SKTextureAtlas atlasNamed:@"images"]
#define BALL_RADIUS 10.0f
#define TouchRange 70
#define shootPower 100

typedef enum GameStatus{
    gameStatusShoot = 1,
    gameStatusMoving
}GameStatus;

@interface MyScene()<SKPhysicsContactDelegate>
@property (nonatomic, assign) GameStatus gameStatus;
@property (nonatomic, strong) SKSpriteNode * whiteBall;
@property (nonatomic, strong) SKSpriteNode * cueStick;
@property (nonatomic, strong) SKSpriteNode * gunSight;
@property (nonatomic, assign) BOOL canShoot;
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        [self initContentView];
        
    }
    return self;
}

-(void)initContentView{
    
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    SKSpriteNode * bgTable = [SKSpriteNode spriteNodeWithTexture:[TEXTUREALTAS textureNamed:@"pocketBall_table"]];
    bgTable.anchorPoint = CGPointMake(0, 0);
    [self addChild:bgTable];
    [self setupTablePhysicsEdge];
    [self setupBalls];
    [self setupWhiteBall];
    [self setupCueStick];
    [self setupGunSight];
    
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
    leftEdge.physicsBody.restitution = 0.5;
    [self addChild:leftEdge];
    
    SKSpriteNode * topLeftEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(218, 1)];
    topLeftEdge.position = CGPointMake(158, self.size.height-34);
    topLeftEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topLeftEdge.size];
    topLeftEdge.physicsBody.dynamic = NO;
    topLeftEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    topLeftEdge.physicsBody.collisionBitMask = ballCategory;
    topLeftEdge.physicsBody.contactTestBitMask = 0;
    topLeftEdge.physicsBody.restitution = 0.5;
    [self addChild:topLeftEdge];
    
    SKSpriteNode * topRightEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(218, 1)];
    topRightEdge.position = CGPointMake(410, self.size.height-34);
    topRightEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topRightEdge.size];
    topRightEdge.physicsBody.dynamic = NO;
    topRightEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    topRightEdge.physicsBody.collisionBitMask = ballCategory;
    topRightEdge.physicsBody.contactTestBitMask = 0;
    topRightEdge.physicsBody.restitution = 0.5;
    [self addChild:topRightEdge];
    
    SKSpriteNode * rightEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(1, self.size.height - 104)];
    rightEdge.position = CGPointMake(self.size.width - 30, self.size.height/2);
    rightEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightEdge.size];
    rightEdge.physicsBody.dynamic = NO;
    rightEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    rightEdge.physicsBody.collisionBitMask = ballCategory;
    rightEdge.physicsBody.contactTestBitMask = 0;
    rightEdge.physicsBody.restitution = 0.5;
    [self addChild:rightEdge];
    
    SKSpriteNode * bottomLeftEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(218, 1)];
    bottomLeftEdge.position = CGPointMake(158, 34);
    bottomLeftEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomLeftEdge.size];
    bottomLeftEdge.physicsBody.dynamic = NO;
    bottomLeftEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    bottomLeftEdge.physicsBody.collisionBitMask = ballCategory;
    bottomLeftEdge.physicsBody.contactTestBitMask = 0;
    bottomLeftEdge.physicsBody.restitution = 0.5;
    [self addChild:bottomLeftEdge];
    
    SKSpriteNode * bottomRightEdge = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(218, 1)];
    bottomRightEdge.position = CGPointMake(410, 34);
    bottomRightEdge.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightEdge.size];
    bottomRightEdge.physicsBody.dynamic = NO;
    bottomRightEdge.physicsBody.categoryBitMask = tableEdgeCategory;
    bottomRightEdge.physicsBody.collisionBitMask = ballCategory;
    bottomRightEdge.physicsBody.contactTestBitMask = 0;
    bottomRightEdge.physicsBody.restitution = 0.5;
    [self addChild:bottomRightEdge];
    
    SKSpriteNode * leftBottomPocket = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(BALL_RADIUS*2, BALL_RADIUS*2)];
    leftBottomPocket.position = CGPointMake(BALL_RADIUS*2, BALL_RADIUS*2);
    leftBottomPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightEdge.size];
    leftBottomPocket.physicsBody.dynamic = NO;
    leftBottomPocket.physicsBody.categoryBitMask = pocketCategory;
    leftBottomPocket.physicsBody.collisionBitMask = ballCategory;
    leftBottomPocket.physicsBody.contactTestBitMask = ballCategory;
    
    [self addChild:leftBottomPocket];
    
    SKSpriteNode * centerBottomPocket = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(BALL_RADIUS*2, BALL_RADIUS*2)];
    centerBottomPocket.position = CGPointMake(self.size.width/2, BALL_RADIUS*2);
    centerBottomPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightEdge.size];
    centerBottomPocket.physicsBody.dynamic = NO;
    centerBottomPocket.physicsBody.categoryBitMask = pocketCategory;
    centerBottomPocket.physicsBody.collisionBitMask = ballCategory;
    centerBottomPocket.physicsBody.contactTestBitMask = ballCategory;
    
    [self addChild:centerBottomPocket];
    
    SKSpriteNode * rightBottomPocket = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(BALL_RADIUS*2, BALL_RADIUS*2)];
    rightBottomPocket.position = CGPointMake(self.size.width-BALL_RADIUS*2, BALL_RADIUS*2);
    rightBottomPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightEdge.size];
    rightBottomPocket.physicsBody.dynamic = NO;
    rightBottomPocket.physicsBody.categoryBitMask = pocketCategory;
    rightBottomPocket.physicsBody.collisionBitMask = ballCategory;
    rightBottomPocket.physicsBody.contactTestBitMask = ballCategory;
    
    [self addChild:rightBottomPocket];
    
    SKSpriteNode * leftTopPocket = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(BALL_RADIUS*2, BALL_RADIUS*2)];
    leftTopPocket.position = CGPointMake(BALL_RADIUS*2,self.size.height- BALL_RADIUS*2);
    leftTopPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightEdge.size];
    leftTopPocket.physicsBody.dynamic = NO;
    leftTopPocket.physicsBody.categoryBitMask = pocketCategory;
    leftTopPocket.physicsBody.collisionBitMask = ballCategory;
    leftTopPocket.physicsBody.contactTestBitMask = ballCategory;
    
    [self addChild:leftTopPocket];
    
    SKSpriteNode * centerTopPocket = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(BALL_RADIUS*2, BALL_RADIUS*2)];
    centerTopPocket.position = CGPointMake(self.size.width/2, self.size.height- BALL_RADIUS*2);
    centerTopPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightEdge.size];
    centerTopPocket.physicsBody.dynamic = NO;
    centerTopPocket.physicsBody.categoryBitMask = pocketCategory;
    centerTopPocket.physicsBody.collisionBitMask = ballCategory;
    centerTopPocket.physicsBody.contactTestBitMask = ballCategory;
    
    [self addChild:centerTopPocket];
    
    SKSpriteNode * rightTopPocket = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(BALL_RADIUS*2, BALL_RADIUS*2)];
    rightTopPocket.position = CGPointMake(self.size.width-BALL_RADIUS*2, self.size.height- BALL_RADIUS*2);
    rightTopPocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightEdge.size];
    rightTopPocket.physicsBody.dynamic = NO;
    rightTopPocket.physicsBody.categoryBitMask = pocketCategory;
    rightTopPocket.physicsBody.collisionBitMask = ballCategory;
    rightTopPocket.physicsBody.contactTestBitMask = ballCategory;
    
    [self addChild:rightTopPocket];
    
    
}

-(void)setupBalls
{
    NSString * color;
    int col = 5;
    int colCnt = 0;
    int startX = self.size.width- 100;
    int startY = self.size.height/2 + BALL_RADIUS*4;
    float newX;
    float newY;
    for (int i = 0; i < 15; i++) {
        if (i == 10) {
            color = @"blackBall";
        } else if (i % 2 == 0) {
            color = @"yellowBall";
        } else {
            color = @"redBall";
        }
        if (colCnt < col) {
            newY = startY - colCnt * 2 * BALL_RADIUS;
            colCnt++;
        } else {
            startX -= BALL_RADIUS*1.7;
            startY -= BALL_RADIUS;
            newY = startY;
            col--;
            colCnt = 1;
        }
        newX = startX;
        SKSpriteNode * ball = [SKSpriteNode spriteNodeWithTexture:[TEXTUREALTAS textureNamed:color]];
        ball.name = color;
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
        ball.physicsBody.categoryBitMask = ballCategory;
        ball.physicsBody.collisionBitMask = tableEdgeCategory | ballCategory;
        ball.physicsBody.contactTestBitMask = pocketCategory;
        ball.physicsBody.usesPreciseCollisionDetection = YES;
        ball.position = CGPointMake(newX, newY);
        ball.physicsBody.density = 5;
        ball.physicsBody.friction = 0.3;
        ball.physicsBody.restitution = 0.7;
        ball.physicsBody.linearDamping= 1;
        ball.physicsBody.angularDamping = 0.8;
        [self addChild:ball];
    }
    
}

-(void)setupWhiteBall
{
    self.whiteBall = [SKSpriteNode spriteNodeWithTexture:[TEXTUREALTAS textureNamed:@"whiteBall"]];
    self.whiteBall.name = @"whiteBall";
    self.whiteBall.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.whiteBall.size.width/2];
    self.whiteBall.physicsBody.categoryBitMask = ballCategory;
    self.whiteBall.physicsBody.collisionBitMask = tableEdgeCategory | ballCategory;
    self.whiteBall.physicsBody.contactTestBitMask = pocketCategory;
    self.whiteBall.physicsBody.usesPreciseCollisionDetection = YES;
    self.whiteBall.position = CGPointMake(155, 160);
    self.whiteBall.physicsBody.density = 5;
    self.whiteBall.physicsBody.friction = 0.3;
    self.whiteBall.physicsBody.restitution = 0.5;
    self.whiteBall.physicsBody.linearDamping= 1;
    self.whiteBall.physicsBody.angularDamping = 0.8;
    [self addChild:self.whiteBall];
}

-(void)setupCueStick
{
    self.cueStick = [SKSpriteNode spriteNodeWithTexture:[TEXTUREALTAS textureNamed:@"pockball_poll"]];
    self.cueStick.position = self.whiteBall.position;
    self.cueStick.anchorPoint = CGPointMake(1, 0.5);
    self.cueStick.name = @"cueStick";
    self.cueStick.hidden = YES;
    [self addChild:self.cueStick];
}

-(void)setupGunSight
{
    self.gunSight = [SKSpriteNode spriteNodeWithTexture:[TEXTUREALTAS textureNamed:@"gunsight"]];
    self.gunSight.hidden = YES;
    [self addChild:self.gunSight];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.canShoot) {
        return;
    }
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        float diffx = location.x - self.whiteBall.position.x;
        float diffy = location.y - self.whiteBall.position.y;
        float diff = pow(diffx, 2) + pow(diffy, 2);
        if (diff < pow(BALL_RADIUS * 4, 2)) {
            self.cueStick.position = self.whiteBall.position;
            self.cueStick.hidden = NO;
            self.cueStick.zRotation = atan2(diffy,diffx) ;
            self.gameStatus = gameStatusShoot;
        }
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.canShoot) {
        return;
    }
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (self.gameStatus == gameStatusShoot) {
            
            
            float diffx = location.x - self.whiteBall.position.x;
            float diffy = location.y - self.whiteBall.position.y;
            float angle = atan2(diffy, diffx);
            float diff = pow(diffx, 2) + pow(diffy, 2);
            __block CGPoint target;
            CGPoint endPoint =  CGPointMake(cos(angle)*1000+self.whiteBall.position.x, sin(angle)*1000+self.whiteBall.position.y);
            
            [self.physicsWorld enumerateBodiesAlongRayStart:self.whiteBall.position end:endPoint usingBlock:^(SKPhysicsBody *body, CGPoint point, CGVector normal, BOOL *stop) {
                target = point;
                *stop = YES;
            }];
            if (diff > pow(BALL_RADIUS * 4, 2)) {
                self.cueStick.zRotation = atan2(diffy,diffx);
                [self drawLine:CGPointMake(cos(angle)*BALL_RADIUS*1.5+self.whiteBall.position.x, sin(angle)*BALL_RADIUS*1.5+self.whiteBall.position.y) toPoint:CGPointMake(target.x-  cos(angle)*BALL_RADIUS*2,target.y - sin(angle)*BALL_RADIUS*2)];
                self.gunSight.hidden = NO;
                self.gunSight.position = CGPointMake(target.x-  cos(angle)*BALL_RADIUS,target.y - sin(angle)*BALL_RADIUS);
            }else{
                [[self childNodeWithName:@"line"] removeFromParent];
                self.gunSight.position = CGPointMake(target.x-  cos(angle)*BALL_RADIUS,target.y - sin(angle)*BALL_RADIUS);
                self.cueStick.zRotation = atan2(diffy,diffx);
            }
            
            
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.canShoot) {
        return;
    }
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        float diffx = location.x - self.whiteBall.position.x;
        float diffy = location.y - self.whiteBall.position.y;
        float diff = pow(diffx, 2) + pow(diffy, 2);
        if (diff < pow(BALL_RADIUS, 2)) {
            return;
        }
        
    }
    
    if (self.gameStatus == gameStatusShoot) {
        [[self childNodeWithName:@"line"] removeFromParent];
        self.gunSight.hidden = YES;
        self.cueStick.hidden = YES;
        [self.whiteBall.physicsBody applyImpulse:CGVectorMake(cos(self.cueStick.zRotation)*shootPower, sin(self.cueStick.zRotation)*shootPower)];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (![self childNodeWithName:@"whiteBall"]) {
        [self setupWhiteBall];
    }
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"whiteBall" usingBlock:^(SKNode *node, BOOL *stop) {
        if (fabs(node.physicsBody.velocity.dx) <= 1 && fabs(node.physicsBody.velocity.dy) <= 1) {
            self.canShoot = YES;
        }else{
            self.canShoot = NO;
        }
    }];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * ball;
    if (contact.bodyA.categoryBitMask == ballCategory) {
        ball = (SKSpriteNode*)contact.bodyA.node;
    }else{
        ball = (SKSpriteNode*)contact.bodyB.node;
    }
    [ball removeFromParent];
}

-(void)drawLine:(CGPoint)point toPoint:(CGPoint)targetPoint
{
    [[self childNodeWithName:@"line"] removeFromParent];
    SKShapeNode *line = [[SKShapeNode alloc] init];
    line.name = @"line";
    
    CGMutablePathRef myPath = CGPathCreateMutable();
    CGPathMoveToPoint(myPath, NULL, point.x,point.y);
    CGPathAddLineToPoint(myPath, NULL,targetPoint.x,targetPoint.y);
    line.path = myPath;
    
    line.lineWidth = 1.0;
    line.fillColor = [SKColor blueColor];
    line.strokeColor = [SKColor whiteColor];
    line.glowWidth = 0.5;
    
    [self addChild:line];
    CGPathRelease(myPath);
}

@end
