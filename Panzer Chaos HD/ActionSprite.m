//
//  ActionSprite.m
//  Panzer Chaos HD
//
//  Created by Andrey Starostenko on 27.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "ActionSprite.h"


@implementation ActionSprite

-(void)idle
{
    if (_actionState != kActionStateIdle)
    {
        [self stopAllActions];
        [self runAction:_idleAction];
        _actionState = kActionStateIdle;
        _velocity = CGPointZero;
    }
}

- (void)randomDirection
{
    int x = arc4random()%3;
    switch (x) {
        case 0:
            self.rotation = 0;
            break;
        case 1:
            self.rotation = 180;
            break;
        case 2:
            self.rotation = 270;
            break;
        case 3:
            self.rotation = 90;
            break;
        default:
            break;
    }
}

-(void)walkWithDirection:(CGPoint)direction
{
    if (_actionState == kActionStateIdle)
    {
        [self stopAllActions];
        [self runAction:_walkAction];
        _actionState = kActionStateWalk;
    }
    if (_actionState == kActionStateWalk)
    {
        if (direction.x == 0 && direction.y == 1)
        {
            self.rotation = 0;
            _directionState = kDirectionTop;
            _velocity = ccp(direction.x * _walkSpeed, direction.y * _walkSpeed);
            if (_velocity.x >= 0) self.scaleX = 1.0;
            else self.scaleX = 1.0;
        } else if (direction.x == 0 && direction.y == -1)
        {
            self.rotation = 180;
            _directionState = kDirectionBot;
            _velocity = ccp(direction.x * _walkSpeed, direction.y * _walkSpeed);
            if (_velocity.x >= 0) self.scaleX = 1.0;
            else self.scaleX = 1.0;
        } else if (direction.x == 1 && direction.y == 0)
        {
            self.rotation = 90;
            _directionState = kDirectionRight;
            _velocity = ccp(direction.x * _walkSpeed, direction.y * _walkSpeed);
            if (_velocity.x >= 0) self.scaleX = 1.0;
            else self.scaleX = 1.0;
        } else if (direction.x == -1 && direction.y == 0)
        {
            self.rotation = 270;
            _directionState = kDirectionLeft;
            _velocity = ccp(direction.x * _walkSpeed, direction.y * _walkSpeed);
            if (_velocity.x >= 0) self.scaleX = 1.0;
            else self.scaleX = 1.0;
        }
    }
}

-(void)attack
{
    if (_actionState == kActionStateIdle || _actionState == kActionStateAttack || _actionState == kActionStateWalk)
    {
        [self stopAllActions];
        [self runAction:_attackAction];
        _actionState = kActionStateAttack;
    }
}

- (void)update:(CCTime)delta
{
    if (_actionState == kActionStateWalk)
    {
        _desiredPosition = ccpAdd(_position, ccpMult(_velocity, delta));
    }
}

-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
}

-(void)hurtWithDamage:(float)damage
{
    if (_actionState != kActionStateKnockedOut)
    {
        [self stopAllActions];
        [self runAction:_hurtAction];
        _actionState = kActionStateHurt;
        _hitPoints -= damage;
        
        if (_hitPoints <= 0.0)
        {
            [self knockout];
        }
    }
}

-(void)knockout
{
    [self stopAllActions];
    [self runAction:_knockedOutAction];
    _hitPoints = 0.0;
    _actionState = kActionStateKnockedOut;
}

@end
