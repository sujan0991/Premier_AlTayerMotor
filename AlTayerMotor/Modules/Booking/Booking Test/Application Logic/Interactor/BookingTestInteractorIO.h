//
//  BookingTestInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/17/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MUser;
@class MBookingTestRequest;

@protocol BookingTestInteractorInput <NSObject>
- (void)findBrands;
- (void)findVehicleModelsByBrand:(NSInteger)brandId;
- (void)findUserInfo;
- (void)findCities;
- (void)findLocations;
- (void)postBookingService:(MBookingTestRequest *)request;
@end

@protocol BookingTestInteractorOutput <NSObject>
- (void)foundBrands:(NSArray *)brands;
- (void)foundVehicleModels:(NSArray *)vehicleModels;
- (void)foundUserInfo:(MUser *)user;
- (void)foundCities:(NSArray *)cities;
- (void)foundLocations:(NSArray *)locations;

- (void)postBookingTestFailed;
- (void)postBookingTestSuccessWithRequest:(MBookingTestRequest *)request;

@end