//
//  DataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/2/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuViewController.h"

@class MToken;

@interface LocalDataManager : NSObject

+ (id)sharedManager;

- (MToken *)token;
- (void)setToken:(MToken *)token;

- (BOOL)shownFirstTime;
- (void)setShownFirstTime;
- (void)resetShownFirstTime;

- (AppLanguage)appLanguage;
- (void)setAppLanguage:(AppLanguage)appLanguage;

- (NSInteger)lastTimeUpdateBrand;
- (void)setLastTimeUpdateBrand;

- (NSInteger)lastTimeUpdatePreownedBrand;
- (void)setLastTimeUpdatePreownedBrand;

@end
