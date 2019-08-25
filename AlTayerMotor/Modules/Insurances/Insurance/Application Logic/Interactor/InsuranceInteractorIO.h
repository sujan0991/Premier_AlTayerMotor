//
//  InsuranceInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MUser;
@class MInsuranceRequest;

@protocol InsuranceInteractorInput <NSObject>
- (void)findUserInfo;
- (void)findCities;
- (void)findDrivingExperiences;
- (void)postInsuranceRequest:(MInsuranceRequest *)request;
@end

@protocol InsuranceInteractorOutput <NSObject>
- (void)foundUserInfo:(MUser *)user;
- (void)foundCities:(NSArray *)cities;
- (void)foundDrivingExperiences:(NSArray *)drivingExperiences;

- (void)postInsuranceRequestFailed;
- (void)postInsuranceRequestSuccessWithRequest:(MInsuranceRequest *)request;
@end
