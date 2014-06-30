//
//  GameScreenScene.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 19.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "GameScreenScene.h"
#import "GameLayer.h"
#import "HUDLayer.h"
#import "SimpleDPad.h"


@implementation GameScreenScene


+ (GameScreenScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    _gameLayer = [GameLayer node];
    [self addChild:_gameLayer z:10];
    
    _hudlayer = [HUDLayer node];
    [self addChild:_hudlayer z:20];
    
    _hudlayer.dPad.delegate = _gameLayer;
    _gameLayer.hudLayer = _hudlayer;
    
	return self;
}

@end
