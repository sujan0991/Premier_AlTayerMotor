//
//  BookingTestDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/17/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;
@class MUser;

@interface BookingTestDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray *)findCities;
- (NSArray *)findBrands;
- (NSArray *)findLocations;
- (NSArray *)findVehicleModelsByBrand:(NSInteger)brandId;
- (MUser *)findUserInfo;

@end
