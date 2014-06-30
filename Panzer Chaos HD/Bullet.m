//
//  Bullet.m
//  Panzer Chaos HD
//
//  Created by Andrey Starostenko on 27.06.14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

+ (Bullet *)createWithparametrs:(NSDictionary *)parametrs
{
    return [[self alloc] initWithParametrs:parametrs];
}

- (id)initWithParametrs:(NSDictionary *)parametrs
{
    NSDictionary *heroDict = [[GameEngine sharedManager] getAllForCurrentLevel];
    NSDictionary *hero = [NSDictionary dictionaryWithDictionary:[heroDict objectForKey:@"Hero"]];
    NSDictionary *bullet = [NSDictionary dictionaryWithDictionary:[hero objectForKey:@"Bullet"]];
    
    if ((self = [super initWithImageNamed:[NSString stringWithString:[bullet objectForKey:@"Sprite"]]]))
    {
        _distance = [[bullet objectForKey:@"distance"] floatValue];
        self.position = [[parametrs objectForKey:@"position"] CGPointValue];
        self.rotation = [[parametrs objectForKey:@"rotation"] floatValue];
        
        float radian = self.rotation * (M_PI / 180);
        CGPoint aimPosition = ccpAdd(self.position, ccp(sin(radian) * _distance , cos(radian) * _distance));
        
        id mov = [CCActionMoveTo actionWithDuration:0.5 position:aimPosition];
        id cal = [CCActionCallBlock actionWithBlock:^{
            [self removeFromParentAndCleanup:YES];
        }];
        [self runAction:[CCActionSequence actions:mov, cal, nil]];
    }
    return self;
}

@end
