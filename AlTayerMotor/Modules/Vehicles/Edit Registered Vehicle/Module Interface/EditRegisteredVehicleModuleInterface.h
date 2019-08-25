//
//  EditRegisteredVehicleModuleInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRegisteredVehicle;

@protocol EditRegisteredVehicleModuleInterface <NSObject>

- (void)findBrands;
- (void)findVehicleModelsByBrand:(NSInteger)brandId;
- (void)saveRegisteredVehicle:(MRegisteredVehicle *)vehicle
           withCurrentVehicle:(MRegisteredVehicle *)oldVehicle;

- (void)showBrandSelectionAlert:(NSArray *)brands;
- (void)showVehicleModelSelectionAlert:(NSArray *)models;
- (void)showYearSelectionAlert:(NSArray *)models;
- (void)showDateSelectionAlert:(NSString *)currentDate;

@end