//
//  EnquiryDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/25/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "EnquiryDataManager.h"
#import "CoreDataStore.h"
#import "MUser.h"

@implementation EnquiryDataManager

- (NSArray *)findBrands
{
    return [self.dataStore fetchAllBrands];
}

- (NSArray *)findPreownedBrands
{
    return [self.dataStore fetchAllPreownedBrands];
}

- (NSArray *)findModelsByBrand:(NSInteger)brandId
{
    return [self.dataStore fetchVehicleModelsByBrand:brandId];
}

- (NSArray *)findPreownedModelsByBrand:(NSInteger)brandId
{
    return [self.dataStore fetchPreownedVehicleModelsByBrand:brandId];
}

- (NSArray *)findCities
{
    return [self.dataStore fetchAllCities];
}

- (MUser *)findUserInfo
{
    MUser *user = [self.dataStore getUserInfo];
    return user;
}

- (NSArray *)findEnquiries
{
    return [self.dataStore fetchGlobalSettingsByKey:@"enquiry"];
}

- (NSArray *)findVehicleEnquiries
{
    return [self.dataStore fetchGlobalSettingsByKey:@"vehicle_enquiry"];
}

@end
