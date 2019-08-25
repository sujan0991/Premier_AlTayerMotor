//
//  ProfileInteractorIO.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRegisteredVehicle;
@class MUser;

@protocol ProfileInteractorInput <NSObject>
- (void)findUserInfo;
-(void)addRegisteredCar:(MRegisteredVehicle *)car;
-(void)findRegisteredCars;
-(void)findCities;
-(void)findBrands;
-(void)findVehicleModelsByBrand:(NSInteger)brandId;
-(void)addUserInformation:(MUser *)user;
-(BOOL)hasAlreadyVehicle:(NSString *)registrationNumber;
-(void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber;
- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number;
@end

@protocol ProfileInteractorOutput <NSObject>
- (void)foundUserInfo:(MUser *)user;
- (void)foundRegisteredCars:(NSArray *)cars;
- (void)foundCities:(NSArray *)cities;
- (void)foundBrands:(NSArray *)brands;
- (void)foundVehicleModels:(NSArray *)vehicleModels;
@end