//
//  BookingTestDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/17/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingTestDataManager.h"
#import "CoreDataStore.h"
#import "MUser.h"

@implementation BookingTestDataManager

- (NSArray *)findBrands
{
    return [self.dataStore fetchAllBrands];
}

- (NSArray *)findCities
{
    return [self.dataStore fetchAllCities];
}

- (NSArray *)findVehicleModelsByBrand:(NSInteger)brandId
{
    return [self.dataStore fetchVehicleModelsByBrand:brandId];
}

- (MUser *)findUserInfo
{
    MUser *user = [self.dataStore getUserInfo];
    return user;
}

- (NSArray *)findLocations {
    return [self.dataStore fetchAllShowroomLocations];
//    return [self.dataStore fetchAllLocations];
}

@end
