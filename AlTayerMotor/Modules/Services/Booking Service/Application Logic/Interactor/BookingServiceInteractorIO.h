//
//  BookingServiceInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/10/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MUser;
@class MRegisteredVehicle;
@class MServiceRequest;
@class MResponse;

@protocol BookingServiceInteractorInput <NSObject>
- (void)findBrands;
- (void)findVehicleModelsByBrand:(NSInteger)brandId;
- (void)findUserInfo;
- (void)findCities;
- (void)findLocations;
- (void)addRegisteredCar:(MRegisteredVehicle *)vehicle;
- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle
                  forOldNumber:(NSString *)registrationNumber;
- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber;
- (void)postBookingService:(MServiceRequest *)request;
@end

@protocol BookingServiceInteractorOutput <NSObject>
- (void)foundBrands:(NSArray *)brands;
- (void)foundVehicleModels:(NSArray *)vehicleModels;
- (void)foundUserInfo:(MUser *)user;
- (void)foundCities:(NSArray *)cities;
- (void)foundLocations:(NSArray *)locations;

- (void)postBookingServiceFailed:(MResponse *)response;
- (void)postBookingServiceSuccessWithRequest:(MServiceRequest *)request;

@end
