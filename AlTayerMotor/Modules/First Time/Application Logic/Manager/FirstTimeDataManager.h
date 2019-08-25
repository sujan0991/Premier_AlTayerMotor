//
//  FirstTimeDataManager.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;
@class MRegisteredVehicle;
@class MUser;

@interface FirstTimeDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray *)findAllRegisteredVehicles;
- (void)addNewRegisteredVehicle:(MRegisteredVehicle *)vehicle;

- (NSArray *)findCities;
- (NSArray *)findBrands;
- (NSArray *)findVehicleModelsByBrand:(NSInteger)brandId;

- (void)addUserInformation:(MUser *)user;
- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber;
- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber;
- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number;

@end
