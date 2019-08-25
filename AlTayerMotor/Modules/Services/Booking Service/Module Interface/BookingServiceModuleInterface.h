//
//  BookingServiceModuleInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MServiceRequest;

@protocol BookingServiceModuleInterface <NSObject>

- (void)findBrands;
- (void)findVehicleModelsByBrand:(NSInteger)brandId;
- (void)findUserInfo;
- (void)findCities;
- (void)findLocations;

- (void)showCitySelectionAlert:(NSArray *)cities;
- (void)showBrandSelectionAlert:(NSArray *)brands;
- (void)showVehicleModelSelectionAlert:(NSArray *)models;
- (void)showYearSelectionAlert:(NSArray *)models;
- (void)showLocationSelectionAlert:(NSArray *)locations;

- (void)submitRequest:(MServiceRequest *)request;

@end
