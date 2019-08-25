//
//  EditRegisteredVehicleDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "EditRegisteredVehicleDataManager.h"
#import "CoreDataStore.h"

#import "RegisteredVehicle.h"
#import "MRegisteredVehicle.h"
#import "CoreDataStore.h"
#import "MVehicleModel.h"

@implementation EditRegisteredVehicleDataManager

- (NSArray *)findCities
{
    return [self.dataStore fetchAllCities];
}

- (NSArray *)findBrands
{
    return [self.dataStore fetchAllBrands];
}

- (NSArray *)findVehicleModelsByBrand:(NSInteger)brandId
{
    return [self.dataStore fetchVehicleModelsByBrand:brandId];
}

- (void)addUserInformation:(MUser *)user
{
    [self.dataStore saveUserInformation:user];
}

- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber
{
    return [self.dataStore hasAlreadyVehicle:registrationNumber];
}

- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber
{
    [self.dataStore updateRegisteredVehicle:vehicle forOldNumber:registrationNumber];
}


@end
