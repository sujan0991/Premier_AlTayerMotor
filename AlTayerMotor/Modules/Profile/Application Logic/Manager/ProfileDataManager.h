//
//  ProfileDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;
@class MRegisteredVehicle;
@class MUser;

@interface ProfileDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray *)findAllRegisteredVehicles;
- (void)addNewRegisteredVehicle:(MRegisteredVehicle *)vehicle;

- (MUser *)findUserInfo;
- (NSArray *)findCities;
- (NSArray *)findBrands;
- (NSArray *)findVehicleModelsByBrand:(NSInteger)brandId;

- (void)addUserInformation:(MUser *)user;
- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber;
- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber;
- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number;

@end
