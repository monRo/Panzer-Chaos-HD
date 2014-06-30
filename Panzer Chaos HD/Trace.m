//
//  Trace.m
//  Panzer Chaos HD
//
//  Created by Андрей on 30.06.14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "Trace.h"
#import "ActionSprite.h"

@interface Trace ()

@property (nonatomic, assign) float traceDelay;
@property (nonatomic, assign) float traceDuration;

@end

@implementation Trace

+ (Trace *)createFor:(ActionSprite *)sprite
{
    return [[self alloc] initFor:sprite];
}

- (id)initFor:(ActionSprite *)sprite
{
    NSDictionary *heroDict = [[GameEngine sharedManager] getAllForCurrentLevel];
    NSDictionary *hero = [NSDictionary dictionaryWithDictionary:[heroDict objectForKey:@"Hero"]];
    NSDictionary *trace = [NSDictionary dictionaryWithDictionary:[hero objectForKey:@"Trace"]];
    
    if (self =[super initWithImageNamed:[NSString stringWithString:[trace objectForKey:@"Sprite"]]]) {
        _traceDelay = [[trace objectForKey:@"Delay"] floatValue];
        _traceDuration = [[trace objectForKey:@"Duration"] floatValue];
        self.position = sprite.position;
        
        id fade = [CCActionFadeOut actionWithDuration:_traceDuration];
        id call = [CCActionCallBlock actionWithBlock:^{
            [self removeFromParentAndCleanup:YES];
        }];
        [self runAction:[CCActionSequence actions:fade, call, nil]];
    }
    return self;
}

@end