//
//  ATMGlobal.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/22/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AppLanguage) {
    AppLanguageEnglish,
    AppLanguageArabian
};


@interface ATMGlobal : NSObject

+ (AppLanguage)getAppLanguage;
+ (void)setAppLanguage:(AppLanguage)language;
+ (BOOL)isEnglish;
+ (BOOL)hasShownTutorial;
+ (void)setShownTutorial;
+ (void)callDealer;
+ (void)callPhoneNumber:(NSString *)phoneNumber;
+ (NSString *)preownedDisclaimerMessage;
+ (NSArray *)yearsSelection;
+ (BOOL)shouldUpdateBrands;
+ (BOOL)shouldUpdatePreownedBrands;
+ (NSString *)getImageLink;
+ (void)setImageLink:(NSString *)link;
+ (NSInteger)reminderLastShownDate;
+ (void)reminderSetLastShownDate:(NSInteger)dateNumber;
+ (CGFloat)offerImageHeight;
+ (CGFloat)vehicleServicesRowHeight;
@end
