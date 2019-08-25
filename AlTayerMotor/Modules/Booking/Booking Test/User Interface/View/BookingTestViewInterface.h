//
//  BookingTestViewInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MUser;
@class MBrand;
@class MVehicleModel;
@class MCity;
@class MLocation;

@protocol BookingTestViewInterface <NSObject>
- (void)updateBrands:(NSArray *)brands;
- (void)updateVehicleModels:(NSArray *)models;
- (void)updateUserInfo:(MUser *)user;
- (void)updateCities:(NSArray *)cities;
- (void)updateLocations:(NSArray *)locations;

- (void)setInitializeBrand:(MBrand *)brand;

- (void)didSelectBrand:(MBrand *)brand;
- (void)didSelectModel:(MVehicleModel *)model;
- (void)didSelectLocation:(MLocation *)location;
- (void)didSelectCity:(MCity *)city;
- (void)didSelectBirthday:(NSDate *)birthday;

- (void)didClearForm;

@end
