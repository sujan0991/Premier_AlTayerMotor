//
//  BookingServiceViewInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBrand;
@class MUser;
@class MLocation;
@class MVehicleModel;
@class MCity;
@class MRegisteredVehicle;

@protocol BookingServiceViewInterface <NSObject>

- (void)updateBrands:(NSArray *)brands;
- (void)updateVehicleModels:(NSArray *)models;
- (void)updateUserInfo:(MUser *)user;
- (void)updateCities:(NSArray *)cities;
- (void)updateLocations:(NSArray *)locations;

- (void)didSelectBrand:(MBrand *)brand;
- (void)didSelectModel:(MVehicleModel *)model;
- (void)didSelectYear:(NSInteger)year;
- (void)didSelectCity:(MCity *)city;
- (void)didSelectLocation:(MLocation *)location;

- (void)didClearForm;

- (MRegisteredVehicle *)getRegisteredVehicle;

@end
