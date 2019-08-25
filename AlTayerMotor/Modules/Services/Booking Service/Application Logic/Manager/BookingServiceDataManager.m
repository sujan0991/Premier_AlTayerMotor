//
//  BookingServiceDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/10/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingServiceDataManager.h"
#import "CoreDataStore.h"
#import "MUser.h"
#import "MRegisteredVehicle.h"
#import "RegisteredVehicle.h"
#import "MVehicleModel.h"

@implementation BookingServiceDataManager

- (NSArray *)findBrands
{
    return [self.dataStore fetchAllBrands];
}

- (NSArray *)findCities
{
    return [self.dataStore fetchAllCities];
}

- (NSArray *)findLocations
{
    return [self.dataStore fetchServiceLocations];
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

- (void)addNewRegisteredVehicle:(MRegisteredVehicle *)vehicle
{
    // Store to database
    RegisteredVehicle *newEntry = [self.dataStore newRegisteredVehicle];
    newEntry.brand_id = @(vehicle.brandId);
    newEntry.model = @(vehicle.model.id);
    newEntry.model_year = @(vehicle.year);
    newEntry.other_brand = vehicle.otherBrand;
    newEntry.other_model = vehicle.otherModel;
    newEntry.registration_number = vehicle.registrationNumber;
    newEntry.registration_expiry = vehicle.registrationExpiry;
    
    [self.dataStore save];
    
    // Refresh local notifications
    [APP_DELEGATE setupRemotePushNotification];
}

- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber
{
    [self.dataStore updateRegisteredVehicle:vehicle forOldNumber:registrationNumber];
}

- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber
{
    return [self.dataStore hasAlreadyVehicle:registrationNumber];
}

@end
