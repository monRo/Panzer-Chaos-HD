//
//  MainScreen.m
//  Panzer Chaos
//
//  Created by Andrey Starostenko on 20.06.14.
//  Copyright 2014 NIX. All rights reserved.
//

#import "MainScreenScene.h"
#import "GameScreenScene.h"
#import "HighscoreScreenScene.h"

@implementation MainScreenScene

+ (MainScreenScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;
    
    [self setupBackground];
    [self setupButtonMenu];
    
	return self;
}

- (void)setupBackground{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    NSDictionary *backgroundDict = [[GameEngine sharedManager] getOption];
    
    CCSprite *background = [CCSprite spriteWithImageNamed:[NSString stringWithString:[backgroundDict objectForKey:@"BackgroundArt"]]];
    background.positionType = CCPositionTypePoints;
    background.position = ccp(winSize.width/2, winSize.height/2);
    background.scale = .5;
    [self addChild:background];
}

- (void)setupButtonMenu
{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    NSDictionary *dictionary = [[GameEngine sharedManager] getOption];
    NSDictionary *buttonDict = [NSDictionary dictionaryWithDictionary:[dictionary objectForKey:@"Button"]];
    
    // Start Game Button
    NSDictionary *startDict = [NSDictionary dictionaryWithDictionary:[buttonDict objectForKey:@"StartButton"]];
    
    CCSpriteFrame *normalFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithString:[startDict objectForKey:@"normal"]]];
    CCSpriteFrame *highligterFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithString:[startDict objectForKey:@"highligter"]]];
    CCButton *startButton = [CCButton buttonWithTitle:@"" spriteFrame:normalFrame
                               highlightedSpriteFrame:highligterFrame
                                  disabledSpriteFrame:nil];
    [startButton setTarget:self selector:@selector(pressedStart:)];
   
    // Highscore Button
    NSDictionary *highscoreDict = [NSDictionary dictionaryWithDictionary:[buttonDict objectForKey:@"HighscoreButton"]];
    
    CCSpriteFrame *normalFrame1 = [CCSpriteFrame frameWithImageNamed:[NSString stringWithString:[highscoreDict objectForKey:@"normal"]]];
    CCSpriteFrame *highligterFrame1 = [CCSpriteFrame frameWithImageNamed:[NSString stringWithString:[highscoreDict objectForKey:@"highligter"]]];
    CCButton *highscoreButton = [CCButton buttonWithTitle:@"" spriteFrame:normalFrame1
                               highlightedSpriteFrame:highligterFrame1
                                  disabledSpriteFrame:nil];
    [highscoreButton setTarget:self selector:@selector(pressedHigscore:)];
    
    // LayotBox
    CCLayoutBox *layoutBox = [[CCLayoutBox alloc] init];
    layoutBox.anchorPoint = ccp(0.5, 0.5);
    [layoutBox addChild:highscoreButton];
    [layoutBox addChild:startButton];
    layoutBox.spacing = 10.f;
    layoutBox.direction = CCLayoutBoxDirectionVertical;
    [layoutBox layout];
    layoutBox.position = ccp(winSize.width/2, winSize.height/2 - 25);
    layoutBox.scale = 1.5;
    [self addChild:layoutBox];
}

- (void)pressedStart:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[GameScreenScene scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.3f]];
}

- (void)pressedHigscore:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[HighscoreScreenScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.3f]];
}

@end
