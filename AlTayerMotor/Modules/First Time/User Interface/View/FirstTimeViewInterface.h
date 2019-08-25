//
//  FirstTimeViewInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBrand;
@class MVehicleModel;
@class MCity;

@protocol FirstTimeViewInterface <NSObject>

- (void)showRegisteredCars:(NSArray*)cars;
- (void)updateCities:(NSArray *)cities;
- (void)updateBrands:(NSArray *)brands;
- (void)updateVehicleModels:(NSArray *)models;
- (void)didSelectCity:(MCity *)city;
- (void)didSelectBrand:(MBrand *)brand;
- (void)didSelectModel:(MVehicleModel *)model;
- (void)didSelectYear:(NSInteger)year;
- (void)didSelectDate:(NSString *)date;

@end
