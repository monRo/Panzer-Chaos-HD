//
//  ActionSprite.h
//  Panzer Chaos HD
//
//  Created by Andrey Starostenko on 27.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCAnimation.h"

@class GameLayer;

@interface ActionSprite : CCSprite

@property (strong, nonatomic) GameLayer *gameLayer;
//actions
@property(nonatomic,strong)id idleAction;
@property(nonatomic,strong)id attackAction;
@property(nonatomic,strong)id walkAction;
@property(nonatomic,strong)id hurtAction;
@property(nonatomic,strong)id knockedOutAction;

//states
@property(nonatomic,assign)ActionState actionState;
@property(nonatomic, assign) DirectionState directionState;

//measurements
@property(nonatomic,assign)float centerToSides;
@property(nonatomic,assign)float centerToBottom;

//attributes
@property(nonatomic, assign)float attackRange;
@property(nonatomic, assign)float fireRate;
@property(nonatomic,assign)float walkSpeed;
@property(nonatomic,assign)float hitPoints;
@property(nonatomic,assign)float damage;

//movement
@property(nonatomic,assign)CGPoint velocity;
@property(nonatomic,assign)CGPoint desiredPosition;

//action methods
-(void)idle;
-(void)randomDirection;
-(void)attack;
-(void)hurtWithDamage:(float)damage;
-(void)knockout;
-(void)walkWithDirection:(CGPoint)direction;

//scheduled metho
- (void)update:(CCTime)delta;

@end
