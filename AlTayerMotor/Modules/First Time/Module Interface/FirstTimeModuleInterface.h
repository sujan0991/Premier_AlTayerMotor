//
//  FirstTimeModuleInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRegisteredVehicle;
@class MUser;

@protocol FirstTimeModuleInterface <NSObject>

- (void)updateView;
- (void)showTabBarInterface;
- (void)findCities;
- (void)findBrands;
- (void)findRegisteredVehicles;
- (void)findVehicleModelsByBrand:(NSInteger)brandId;
- (void)presentEditInterfaceWithData:(MRegisteredVehicle *)registeredVehicle;
- (void)showDeletePopupWithRegisteredVehicle:(MRegisteredVehicle *)vehicle;

- (void)showCitySelectionAlert:(NSArray *)cities;
- (void)showSkipWarningAlertWithUser:(MUser *)user;
- (void)showBrandSelectionAlert:(NSArray *)brands;
- (void)showVehicleModelSelectionAlert:(NSArray *)models;
- (void)showYearSelectionAlert:(NSArray *)models;
- (void)showDateSelectionAlert:(NSString *)currentDate;

- (void)addRegisteredVehicle:(MRegisteredVehicle *)vehicle;
- (void)saveRegisteredVehicle:(MRegisteredVehicle *)vehicle
           withCurrentVehicle:(MRegisteredVehicle *)oldVehicle;
- (void)storeUserInfo:(MUser *)user
           andVehicle:(MRegisteredVehicle *)vehicle
       withOldVehicle:(MRegisteredVehicle *)oldVehicle;

@end