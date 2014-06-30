//
//  GameEngine.h
//  Panzer Chaos HD
//
//  Created by Andrey Starostenko on 27.06.14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameEngine : NSObject

+ (instancetype)sharedManager;

- (NSDictionary *)getOption;
- (NSDictionary *)getLevel:(int)level;
- (NSDictionary *)getAllForCurrentLevel;

@end
