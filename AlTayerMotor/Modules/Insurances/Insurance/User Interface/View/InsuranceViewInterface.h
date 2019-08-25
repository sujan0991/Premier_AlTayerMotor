//
//  InsuranceViewInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsuranceModuleInterface.h"

@class MUser;
@class MCity;
@class MDrivingExperience;

@protocol InsuranceViewInterface <NSObject>
- (void)updateUserInfo:(MUser *)user;
- (void)updateCities:(NSArray *)cities;
- (void)updateDrivingExperiences:(NSArray *)drivingExperiences;
- (void)didSelectCity:(MCity *)city;
- (void)didSelectDrivingExperience:(MDrivingExperience *)exp;
- (void)didSelectBirthday:(NSDate *)birthday;
- (void)didTakenPhoto:(UIImage*)image forSide:(CardSide)cardSide;
- (void)didDeleteCardSide:(CardSide)cardSide;
- (void)didClearForm;
@end
