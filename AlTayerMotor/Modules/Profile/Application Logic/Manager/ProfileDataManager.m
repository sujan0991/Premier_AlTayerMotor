//
//  ProfileDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ProfileDataManager.h"

#import "RegisteredVehicle.h"
#import "MRegisteredVehicle.h"
#import "CoreDataStore.h"
#import "MUser.h"
#import "MVehicleModel.h"

@implementation ProfileDataManager

- (void)addNewRegisteredVehicle:(MRegisteredVehicle *)vehicle
{
    // Store to database
    RegisteredVehicle *newEntry = [self.dataStore newRegisteredVehicle];
    newEntry.brand_id = @(vehicle.brandId);
    newEntry.model = @(vehicle.model.id);
    newEntry.other_brand = vehicle.otherBrand;
    newEntry.other_model = vehicle.otherModel;
    newEntry.model_year = @(vehicle.year);
    newEntry.registration_number = vehicle.registrationNumber;
    newEntry.registration_expiry = vehicle.registrationExpiry;
    
    [self.dataStore save];
    
    // Refresh local notifications
    [APP_DELEGATE setupRemotePushNotification];
}

- (NSArray *)findAllRegisteredVehicles
{
    return [self.dataStore fetchAllRegisteredVehicles];
}

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

- (MUser *)findUserInfo
{
    MUser *user = [self.dataStore getUserInfo];
    return user;
}

- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber
{
    return [self.dataStore hasAlreadyVehicle:registrationNumber];
}

- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber
{
    [self.dataStore updateRegisteredVehicle:vehicle forOldNumber:registrationNumber];
}

- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number
{
    [self.dataStore deleteRegisteredVehicleByRegistrationNumber:number];
}

@end
