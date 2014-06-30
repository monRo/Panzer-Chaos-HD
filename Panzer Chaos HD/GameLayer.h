//
//  GameLayer.h
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 25.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleDPad.h"

@class HUDLayer, Hero;

@interface GameLayer : CCNode <SimpleDPadDelegate>
{
    CCTiledMap *_tileMap;
    CCTiledMapLayer *_background;
    CCTiledMapLayer *_wall;
    CCTiledMapObjectGroup *_object;
    CCTiledMapLayer *_meta;
    Hero *_hero;
}

@property (weak, nonatomic) HUDLayer *hudLayer;

@end
