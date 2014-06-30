//
//  GameEngine.m
//  Panzer Chaos HD
//
//  Created by Andrey Starostenko on 27.06.14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "GameEngine.h"

@interface GameEngine ()

@property (strong, nonatomic) NSDictionary *plistData;
@property (assign, nonatomic) int level;

@end

@implementation GameEngine

+ (instancetype)sharedManager
{
    static GameEngine* sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[GameEngine alloc] init];
    });
    
    return sharedManager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
        _plistData = [NSDictionary dictionaryWithContentsOfFile: finalPath];
    }
    return self;
}

- (NSDictionary *)getOption
{
    NSDictionary *optionDictionary = [NSDictionary dictionaryWithDictionary:[_plistData objectForKey:@"Options"]];
    return optionDictionary;
}

- (NSDictionary *)getLevel:(int)level
{
    _level = level;
    NSMutableArray *levelArray = [NSMutableArray arrayWithArray:[_plistData objectForKey:@"Level"]];
    NSDictionary* levelDict = [NSDictionary dictionaryWithDictionary:[levelArray objectAtIndex:_level - 1]];
    return levelDict;
}

- (NSDictionary *)getAllForCurrentLevel
{
    NSMutableArray *levelArray = [NSMutableArray arrayWithArray:[_plistData objectForKey:@"Level"]];
    NSDictionary* levelDict = [NSDictionary dictionaryWithDictionary:[levelArray objectAtIndex:_level - 1]];
    return levelDict;
}

@end
