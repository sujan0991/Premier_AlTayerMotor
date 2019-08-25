//
//  BookingServiceDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/10/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;
@class MUser;
@class MRegisteredVehicle;

@interface BookingServiceDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray *)findCities;
- (NSArray *)findBrands;
- (NSArray *)findLocations;
- (NSArray *)findVehicleModelsByBrand:(NSInteger)brandId;
- (MUser *)findUserInfo;
- (void)addNewRegisteredVehicle:(MRegisteredVehicle *)vehicle;
- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber;
- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber;

@end
