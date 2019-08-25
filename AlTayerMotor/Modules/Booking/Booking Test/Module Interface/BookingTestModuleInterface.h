//
//  BookingTestModuleInterface.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBookingTestRequest;

@protocol BookingTestModuleInterface <NSObject>

- (void)findBrands;
- (void)findVehicleModelsByBrand:(NSInteger)brandId;
- (void)findUserInfo;
- (void)findCities;
- (void)findLocations;

- (void)showCitySelectionAlert:(NSArray *)cities;
- (void)showBrandSelectionAlert:(NSArray *)brands;
- (void)showVehicleModelSelectionAlert:(NSArray *)models;
- (void)showLocationSelectionAlert:(NSArray *)locations;
- (void)showBirthdaySelectionAlert:(NSDate *)birthday;

- (void)sendBookingTestRequest:(MBookingTestRequest *)request;

@end
