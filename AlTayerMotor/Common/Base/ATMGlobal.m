//
//  ATMGlobal.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/22/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ATMGlobal.h"
#import "DateManager.h"
#import "LocalDataManager.h"
#import "CoreDataStore.h"
#import "MGlobalSetting.h"

@implementation ATMGlobal

+ (AppLanguage)getAppLanguage
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:kAppLanguage];
}

+ (void)setAppLanguage:(AppLanguage)language
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:language forKey:kAppLanguage];
    [userDefaults synchronize];
}

+ (BOOL)isEnglish
{
    return [ATMGlobal getAppLanguage] == AppLanguageEnglish;
}


+ (BOOL)hasShownTutorial
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:kUserDefaultsShowTutorial];
}

+ (void)setShownTutorial
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:kUserDefaultsShowTutorial];
    [userDefaults synchronize];
}

+ (NSString *)getImageLink
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *imageLink = [userDefaults stringForKey:kImageLink];
    return (imageLink && imageLink.length > 0) ? imageLink : kURLDomain;
}

+ (void)setImageLink:(NSString *)link
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:link forKey:kImageLink];
    [userDefaults synchronize];
}

+ (void)callDealer
{
//    CoreDataStore *coreDataStore = [CoreDataStore sharedStore];
//    NSArray *phones = [coreDataStore fetchGlobalSettingsByKey:@"phone"];
//
//    if (phones && phones.count > 0) {
//        MGlobalSetting *firstPhone = [[phones linq_where:^BOOL(MGlobalSetting *setting) {
//            return [setting.key isEqualToString:@"call_800_motors"];
//        }] linq_firstOrNil];
//        
//        if (firstPhone &&) {
//            [ATMGlobal callPhoneNumber:[firstPhone name]];
//        }
//        
//        return;
//    }
    [ATMGlobal callPhoneNumber:kContactDealer];
}

+ (NSString *)preownedDisclaimerMessage {
    NSString *message = LOCALIZED(@"TEXT DEFAULT PREOWNED DISCLAIMER MESSAGE");
    
    CoreDataStore *coreDataStore = [CoreDataStore sharedStore];
    NSArray *messages = [coreDataStore fetchGlobalSettingsByKey:@"preowned_disclaimer_message"];
    if (messages && messages.count > 0) {
        MGlobalSetting *firstMessage = [[messages linq_where:^BOOL(MGlobalSetting *setting) {
            return [setting.key isEqualToString:@"preowned_disclaimer_message"];
        }] linq_firstOrNil];
        
        if (firstMessage) {
            return [firstMessage name];
        }
    }
    
    return message;
}

+ (void)callPhoneNumber:(NSString *)phoneNumber
{
    static UIWebView *webView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webView = [UIWebView new];
    });
    NSCharacterSet *charSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet];
    NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    NSString *escapedPhoneString = [cleanedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"tel:%@",escapedPhoneString]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Call facility is not available!"
                                    message:@""
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction
                          actionWithTitle:LOCALIZED(@"TEXT OK")
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction *action)
                          {
                              
                          }]];
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}

+ (NSArray *)yearsSelection
{
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:currentDate];
    NSInteger currentMonth = [components month];
    NSString *yearString = [[[DateManager sharedManager] yearFormatter] stringFromDate:currentDate];
    NSInteger currentYear = [yearString integerValue];
    
    NSMutableArray *years = [@[] mutableCopy];
    
    if (currentMonth > 3) {
        [years insertObject:@(currentYear + 1) atIndex:0];
    }
    
    for (int i = 0; i <= 30; i++) {
        [years addObject:@(currentYear-i)];
    }
    
    

    return years;
}

+ (BOOL)shouldUpdateBrands
{
    NSInteger lastUpdate = [[LocalDataManager sharedManager] lastTimeUpdateBrand];
    NSInteger currentDate = [[[[DateManager sharedManager] numberDateFormatter] stringFromDate:[NSDate date]] integerValue];
    
    return lastUpdate < currentDate;
}

+ (BOOL)shouldUpdatePreownedBrands
{
    NSInteger lastUpdate = [[LocalDataManager sharedManager] lastTimeUpdatePreownedBrand];
    NSInteger currentDate = [[[[DateManager sharedManager] numberDateFormatter] stringFromDate:[NSDate date]] integerValue];
    
    return lastUpdate < currentDate;
}

+ (NSInteger)reminderLastShownDate {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:kUserDefaultsReminderLastShownDate];
}

+ (void)reminderSetLastShownDate:(NSInteger)dateNumber
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:dateNumber forKey:kUserDefaultsReminderLastShownDate];
    [userDefaults synchronize];
}

+ (CGFloat)offerImageHeight {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    return (screenWidth * 465.0) / 400.0;
}

+ (CGFloat)vehicleServicesRowHeight {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    DLog(@"%f - %f", screenWidth, (((screenWidth - 32) * 900) / 1900) + 6);
    return (((screenWidth - 32) * 900) / 1900) + 6;
}

@end
