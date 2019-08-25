//
//  ProfileModuleInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRegisteredVehicle;
@class MUser;

@protocol ProfileModuleInterface <NSObject>

- (void)updateView;
- (void)findUserInfo;
- (void)findCities;
- (void)findBrands;
- (void)findRegisteredVehicles;
- (void)findVehicleModelsByBrand:(NSInteger)brandId;
- (void)presentEditInterfaceWithData:(MRegisteredVehicle *)registeredVehicle;
- (void)showDeletePopupWithRegisteredVehicle:(MRegisteredVehicle *)vehicle;

- (void)showCitySelectionAlert:(NSArray *)cities;
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
