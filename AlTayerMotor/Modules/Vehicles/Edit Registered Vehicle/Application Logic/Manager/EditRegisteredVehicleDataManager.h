//
//  EditRegisteredVehicleDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;
@class MRegisteredVehicle;

@interface EditRegisteredVehicleDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray *)findCities;
- (NSArray *)findBrands;
- (NSArray *)findVehicleModelsByBrand:(NSInteger)brandId;

- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber;
- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber;

@end
