//
//  EditRegisteredVehicleViewInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBrand;
@class MRegisteredVehicle;
@class MVehicleModel;

@protocol EditRegisteredVehicleViewInterface <NSObject>
- (void)setRegisteredVehicle:(MRegisteredVehicle *)vehicle;
- (void)updateBrands:(NSArray *)brands;
- (void)updateVehicleModels:(NSArray *)models;
- (void)didSelectBrand:(MBrand *)brand;
- (void)didSelectModel:(MVehicleModel *)model;
- (void)didSelectYear:(NSInteger)year;
- (void)didSelectDate:(NSString *)date;
@end
