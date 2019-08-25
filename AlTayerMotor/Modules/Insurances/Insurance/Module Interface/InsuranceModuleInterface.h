//
//  InsuranceModuleInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MInsuranceRequest;

typedef NS_ENUM(NSInteger, CardSide) {
    CardSideFront,
    CardSideBack
};

@protocol InsuranceModuleInterface <NSObject>
- (void)findUserInfo;
- (void)findCities;
- (void)findDrivingExperiences;

- (void)showCitySelectionAlert:(NSArray *)cities;
- (void)showBirthdaySelectionAlert:(NSDate *)birthday;
- (void)showDrivingExperienceSelectionAlert:(NSArray *)drivingExperiences;
- (void)takePhoto:(CardSide)cardSide;
- (void)deleteCardSide:(CardSide)cardSide;
- (void)clearForm;
- (void)submitRequest:(MInsuranceRequest *)request;

@end
