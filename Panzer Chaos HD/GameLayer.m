//
//  GameLayer.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 25.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "GameLayer.h"
#import "ActionSprite.h"
#import "Hero.h"

@implementation GameLayer

#pragma mark -
#pragma mark - Init

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    self.UserInteractionEnabled = YES;
    [self initMap];
    [self initHero];
    [self initTurrets];
    
    return self;
}

- (void)initMap
{
    NSDictionary *mapDict = [[GameEngine sharedManager] getLevel:1];
    
    _tileMap = [CCTiledMap tiledMapWithFile:[NSString stringWithString:[mapDict objectForKey:@"Map"]]];
    _background = [_tileMap layerNamed:@"background"];
    _wall = [_tileMap layerNamed:@"wall"];
    _object = [_tileMap objectGroupNamed:@"objects"];
    _meta = [_tileMap layerNamed:@"Meta"];
    _meta.visible = NO;
    [self addChild:_tileMap z:-1];
    [self setContentSize:[_tileMap contentSize]];
}

- (void)initHero
{
    _hero = [Hero create];
    _hero.positionType = CCPositionTypePoints;
    CGPoint heroPosition = [self objectPosition:_object object:@"player"];
    _hero.position = ccp(heroPosition.x, heroPosition.y);
    [_tileMap addChild:_hero z:3];
    [self setViewPointCenter:_hero.position];
    [_hero idle];
}

- (void)initTurrets
{
//    _enemy = [NSMutableArray array];
//    for (int i = 0; i < [_object.objects count]; i ++)
//    {
//        Turrets *turret = [Turrets create];
//        [_enemy addObject:turret];
//        turret.positionType = CCPositionTypePoints;
//        CGPoint enemyPosition = [self objectPosition:_object object:[NSString stringWithFormat:@"enemy%d", i]];
//        turret.position = ccp(enemyPosition.x, enemyPosition.y);
//        [_tileMap addChild:turret z:1];
//        turret.desiredPosition = turret.position;
//        [turret randomDirection];
//        [turret idle];
//    }
}

#pragma mark -
#pragma mark - Touched

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [_hero attack];
    
    if (_hero.actionState == kActionStateAttack)
    {
        [_hero shoot];
    }
}

#pragma mark -
#pragma mark - Delegate Method

- (void)simpleDPad:(SimpleDPad *)simpleDPad didChangeDirectionTo:(CGPoint)direction
{
    [_hero walkWithDirection:direction];
}

- (void)simpleDPad:(SimpleDPad *)simpleDPad isHoldingDirection:(CGPoint)direction
{
    [_hero walkWithDirection:direction];
}

- (void)simpleDPadTouchEnded:(SimpleDPad *)simpleDPad
{
    if (_hero.actionState == kActionStateWalk)
    {
        [_hero idle];
    }
}

#pragma mark -
#pragma mark - Custom Method

- (void)update:(CCTime)delta
{
    [_hero update:delta];
    [self updatePositions];
    [self setViewPointCenter:_hero.position];
}

-(void)updatePositions {
    float posX = MIN(_tileMap.mapSize.width * _tileMap.tileSize.width - _hero.centerToSides, MAX(_hero.centerToSides, _hero.desiredPosition.x));
    float posY = MIN(_tileMap.mapSize.height * _tileMap.tileSize.height - _hero.centerToBottom, MAX(_hero.centerToBottom, _hero.desiredPosition.y));
    CGPoint tileCoord = [self tileCoordForPosition:CGPointMake(posX, posY)];
    int tileGid = [_meta tileGIDAt:tileCoord];
    if (tileGid) {
        NSDictionary *properties = [_tileMap propertiesForGID:tileGid];
        if (properties) {
            NSString *collision = properties[@"Collidable"];
            if (collision && [collision isEqualToString:@"True"]) {
                return;
            }
        }
    }
    _hero.position = ccp(posX, posY);
}

- (void)setViewPointCenter:(CGPoint) position
{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    int x = MAX(position.x, winSize.width/2);
    int y = MAX(position.y, winSize.height/2);
    x = MIN(x, (_tileMap.mapSize.width * _tileMap.tileSize.width) - winSize.width / 2);
    y = MIN(y, (_tileMap.mapSize.height * _tileMap.tileSize.height) - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    
    self.position = viewPoint;
}

- (CGPoint)objectPosition:(CCTiledMapObjectGroup *)group object:(NSString *)object {
    
    CGPoint point;
    NSMutableDictionary* dic = [group objectNamed:object];
    point.x = [[dic valueForKey:@"x"] intValue];
    point.y = [[dic valueForKey:@"y"] intValue];
    return point;
}

- (CGPoint)tileCoordForPosition:(CGPoint)position
{
    int x = position.x / _tileMap.tileSize.width;
    int y = ((_tileMap.mapSize.height * _tileMap.tileSize.height) - position.y) / _tileMap.tileSize.height;
    return ccp(x, y);
}

- (CGRect)getRectFromSprite:(ActionSprite *)sprite
{
    return CGRectMake(sprite.position.x - sprite.contentSize.width/2, sprite.position.y - sprite.contentSize.height/2,
                      sprite.contentSize.width, sprite.contentSize.height);
}

@end
