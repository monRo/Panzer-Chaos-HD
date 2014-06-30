//
//  Hero.h
//  Panzer Chaos HD
//
//  Created by Andrey Starostenko on 27.06.14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionSprite.h"

@interface Hero : ActionSprite

+ (Hero *)create;
- (void)shoot;

@end
