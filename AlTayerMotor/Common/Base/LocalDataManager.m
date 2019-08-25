//
//  DataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/2/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LocalDataManager.h"
#import "UICKeyChainStore.h"
#import "MToken.h"
#import "DateManager.h"

#define kToken          @"token"
#define kExpiredIn      @"expiredIn"
#define kLoggedInTime   @"loggedInTime"
#define kBearer         @"bearer"
#define kShowFirstTimeInterface @"show_first_time_interface"
#define kLanguage       @"current_language"
#define kLastUpdateBrands           @"last-update-brands"
#define kLastUpdatePreownedBrands   @"last-update-preowned-brands"

@interface LocalDataManager()
@property (nonatomic, strong) UICKeyChainStore *keychain;
@property (nonatomic, strong) MToken *mToken;
@end

@implementation LocalDataManager

+ (id)sharedManager {
    static LocalDataManager *sharedDataManager = nil;
    @synchronized(self) {
        if (sharedDataManager == nil)
            sharedDataManager = [[self alloc] init];
    }
    return sharedDataManager;
}

- (UICKeyChainStore *)keychain
{
    if (!_keychain) {
        _keychain = [UICKeyChainStore keyChainStoreWithService:@"se.niteco.altayer"];
    }
    
    return _keychain;
}

- (MToken *)token
{
    if (!_mToken) {
        if (_keychain[kToken] && ![_keychain[kToken] isEqual:[NSNull null]]) {
            _mToken = [MToken new];
            _mToken.accessToken = _keychain[kToken];
            _mToken.expiresIn = [_keychain[kExpiredIn] integerValue];
            _mToken.logedInTime = [_keychain[kLoggedInTime] doubleValue];
            _mToken.bearer = _keychain[kBearer];
        }
    }
    
    return _mToken;
}

- (void)setToken:(MToken *)token
{
    _mToken = token;
    _keychain[kToken] = _mToken.accessToken;
    _keychain[kBearer] = _mToken.bearer;
    [_keychain setValue:@(_mToken.expiresIn) forKey:kExpiredIn];
    [_keychain setValue:@(_mToken.logedInTime) forKey:kLoggedInTime];
}

- (BOOL)shownFirstTime
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kShowFirstTimeInterface];
}

- (void)setShownFirstTime
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:YES forKey:kShowFirstTimeInterface];
    [userDefault synchronize];
}

- (void)resetShownFirstTime
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:NO forKey:kShowFirstTimeInterface];
    [userDefault synchronize];
}

- (AppLanguage)appLanguage
{
    return [_keychain[kLanguage] integerValue];
}

- (void)setAppLanguage:(AppLanguage)appLanguage
{
    [_keychain setValue:@(appLanguage) forKey:kLanguage];
}

- (NSInteger)lastTimeUpdateBrand
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kLastUpdateBrands];
}

- (void)setLastTimeUpdateBrand
{
    NSString *currentDateString = [[[DateManager sharedManager] numberDateFormatter] stringFromDate:[NSDate date]];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:[currentDateString integerValue] forKey:kLastUpdateBrands];
    [userDefault synchronize];
}

- (NSInteger)lastTimeUpdatePreownedBrand
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kLastUpdatePreownedBrands];
}

- (void)setLastTimeUpdatePreownedBrand
{
    NSString *currentDateString = [[[DateManager sharedManager] numberDateFormatter] stringFromDate:[NSDate date]];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:[currentDateString integerValue] forKey:kLastUpdatePreownedBrands];
    [userDefault synchronize];
}

@end