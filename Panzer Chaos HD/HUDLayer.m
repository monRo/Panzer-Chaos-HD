//
//  HUDLayer.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 24.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "HUDLayer.h"
#import "SimpleDPad.h"

@implementation HUDLayer

-(id)init {
    if ((self = [super init])) {
        self.userInteractionEnabled = YES;
        NSDictionary *dPadDict = [[GameEngine sharedManager] getOption];

        _dPad = [SimpleDPad dPadWithFile:[NSString stringWithString:[dPadDict objectForKey:@"DPad"]] radius:64];
        _dPad.position = ccp(84.0, 89.0);
        _dPad.opacity = 100;
        [self addChild:_dPad];
    }
    return self;
}

@end
