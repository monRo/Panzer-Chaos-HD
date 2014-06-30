//
//  Hero.m
//  Panzer Chaos HD
//
//  Created by Andrey Starostenko on 27.06.14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "Hero.h"
#import "Bullet.h"
#import "GameLayer.h"

@implementation Hero

+ (Hero *)create
{
    return [[self alloc] init];
}

- (id)init
{
    NSDictionary *heroDict = [[GameEngine sharedManager] getAllForCurrentLevel];
    NSDictionary *hero = [NSDictionary dictionaryWithDictionary:[heroDict objectForKey:@"Hero"]];
    NSDictionary *currHero = [NSDictionary dictionaryWithDictionary:[hero objectForKey:@"Animation Sprite"]];
    
    if ((self = [super initWithImageNamed:[NSString stringWithString:[[NSMutableArray arrayWithArray:[currHero objectForKey:@"Idle Animation"]] objectAtIndex:0]]]))
    {
        int i;
        
        //idle animation
        NSMutableArray *idleFrames = [NSMutableArray array];
        for(int i = 0; i < 5; ++i)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:
                                          [NSString stringWithString:[[NSMutableArray arrayWithArray:[currHero objectForKey:@"Idle Animation"]] objectAtIndex:i]]];
            [idleFrames addObject:spriteFrame];
        }
        CCAnimation *animation = [CCAnimation animationWithSpriteFrames:idleFrames delay:1.0/6.0];
        self.idleAction = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:animation]];
        
        //attack animation
        NSMutableArray *attackFrames = [NSMutableArray array];
        for (i = 0; i < 3; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:
                                          [NSString stringWithString:[[NSMutableArray arrayWithArray:[currHero objectForKey:@"Attack Animation"]] objectAtIndex:i]]];
            [attackFrames addObject:spriteFrame];
        }
        CCAnimation *attackAnimation = [CCAnimation animationWithSpriteFrames:attackFrames delay:1.0/24.0];
        
        self.attackAction = [CCActionSequence actions:[CCActionAnimate actionWithAnimation:attackAnimation], [CCActionCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //walk animation
        NSMutableArray *walkFrames = [NSMutableArray array];
        for (i = 0; i < 3; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:
                                          [NSString stringWithString:[[NSMutableArray arrayWithArray:[currHero objectForKey:@"Walk Animation"]] objectAtIndex:i]]];
            [walkFrames addObject:spriteFrame];
        }
        CCAnimation *walkAnimation = [CCAnimation animationWithSpriteFrames:walkFrames delay:1.0/12.0];
        self.walkAction = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:walkAnimation]];
        
        //hurt animation
        NSMutableArray *hurtFrames = [NSMutableArray array];
        for (i = 0; i < 5; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:
                                          [NSString stringWithString:[[NSMutableArray arrayWithArray:[currHero objectForKey:@"Hurt Animation"]] objectAtIndex:i]]];
            [hurtFrames addObject:spriteFrame];
        }
        CCAnimation *hurtAnimation = [CCAnimation animationWithSpriteFrames:hurtFrames delay:1.0/12.0];
        self.hurtAction = [CCActionSequence actions:[CCActionAnimate actionWithAnimation:hurtAnimation], [CCActionCallFunc actionWithTarget:self selector:@selector(idle)], nil];
        
        //knocked out animation
        NSMutableArray *knockedOutFrames = [NSMutableArray array];
        for (i = 0; i <= 4; i++)
        {
            CCSpriteFrame *spriteFrame = [CCSpriteFrame frameWithImageNamed:
                                          [NSString stringWithString:[[NSMutableArray arrayWithArray:[currHero objectForKey:@"Knocked Out Animation"]] objectAtIndex:i]]];
            [knockedOutFrames addObject:spriteFrame];
        }
        CCAnimation *knockedOutAnimation = [CCAnimation animationWithSpriteFrames:knockedOutFrames delay:1.0/12.0];
        self.knockedOutAction = [CCActionSequence actions:[CCActionAnimate actionWithAnimation:knockedOutAnimation], [CCActionBlink actionWithDuration:2.0 blinks:10.0], nil];
        
        self.userInteractionEnabled = YES;
        self.desiredPosition = self.position;
        self.centerToBottom = self.boundingBox.size.width/2;
        self.centerToSides = self.boundingBox.size.height/2;
        self.hitPoints = [[hero objectForKey:@"Hit Point"] floatValue];
        self.damage = [[hero objectForKey:@"Damage"] floatValue];
        self.walkSpeed = [[hero objectForKey:@"Walk Speed"] floatValue];
        
    }
    return self;
}

- (void)shoot
{
    int direction;
    switch (self.directionState) {
        case kDirectionTop:
            direction = 0;
            break;
        case kDirectionBot:
            direction = 180;
            break;
        case kDirectionLeft:
            direction = 270;
            break;
        case kDirectionRight:
            direction = 90;
            break;
        default:
            break;
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:direction], @"rotation",
                                                                    [NSValue valueWithCGPoint:self.position], @"position",
                                                                    nil];
    Bullet *bullet = [Bullet createWithparametrs:dict];
    [self.parent addChild:bullet];
}

-(void)knockout
{
    [super knockout];
}

@end
