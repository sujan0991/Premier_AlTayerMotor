//
//  InsuranceDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "InsuranceDataManager.h"
#import "CoreDataStore.h"
#import "MUser.h"

@implementation InsuranceDataManager

- (NSArray *)findCities
{
    return [self.dataStore fetchAllCities];
}

- (NSArray *)findDrivingExperiences
{
    return [self.dataStore fetchAllDrivingExperiences];
}

- (MUser *)findUserInfo
{
    MUser *user = [self.dataStore getUserInfo];
    return user;
}

@end
