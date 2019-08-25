//
//  CoreDataStore.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRegisteredVehicle;
@class RegisteredVehicle;
@class MBrand;
@class MUser;
@class User;
@class MVehicleModel;
@class MCity;
@class MDrivingExperience;
@class MPreownedBrand;
@class MPreownedVehicleModel;

typedef void(^DataStoreFetchCompletionBlock)(NSArray *results);

@interface CoreDataStore : NSObject

+ (id)sharedStore;

#pragma mark - User
- (void)saveUserInformation:(MUser *)user;
- (MUser *)getUserInfo;

#pragma mark - Cities
- (NSArray *)fetchAllCities;
- (void)deleteAllCities;
- (void)insertCities:(NSArray *)cities;
- (MCity *)getCityByKey:(NSString *)key;

#pragma mark - Global Settings
- (NSArray*)fetchGlobalSettingsByKey:(NSString*)key;
- (void)deleteAllGlobalSettings;
- (void)insertGlobalSettings:(NSArray *)settings;

#pragma mark - Location
- (NSArray *)fetchAllLocations;
- (NSArray *)fetchServiceLocations;
- (NSArray *)fetchAllShowroomLocations;
- (void)deleteAllLocations;
- (void)insertLocations:(NSArray *)locations;

#pragma mark - Driving Experience
- (NSArray *)fetchAllDrivingExperiences;
- (void)deleteAllDrivingExperiences;
- (void)insertDrivingExperiences:(NSArray *)drivingExperiences;
- (MDrivingExperience *)getDrivingExperienceByKey:(NSString *)key;

#pragma mark - Brands
- (NSArray *)fetchAllBrands;
- (void)syncBrand:(MBrand *)brand;
- (MBrand *)getBrandById:(NSInteger)brandId;
- (void)deleteAllBrands;

#pragma mark - Preowned-Brands
- (NSArray *)fetchAllPreownedBrands;
- (void)syncPreownedBrand:(MPreownedBrand *)brand;
- (MPreownedBrand *)getPreownedBrandById:(NSInteger)brandId;
- (void)deleteAllPreownedBrands;

#pragma mark - Vehicle Models
- (NSArray *)fetchAllVehicleModels;
- (NSArray *)fetchVehicleModelsByBrand:(NSInteger)brandId;
- (MVehicleModel *)getModelById:(NSInteger)modelId;

#pragma mark - Preowned Vehicle Models
- (NSArray *)fetchAllPreownedVehicleModels;
- (NSArray *)fetchPreownedVehicleModelsByBrand:(NSInteger)brandId;
- (MPreownedVehicleModel *)getPreownedModelById:(NSInteger)modelId;

#pragma mark - Registered Vehicles
- (NSArray *)fetchAllRegisteredVehicles;
- (RegisteredVehicle *)newRegisteredVehicle;
- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber;
- (BOOL)hasRegisteredVehicleInDate:(NSString *)expiryDate;
- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber;
- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number;
- (void)deleteAllRegisteredVehicles;
- (NSArray *)expiredRegisteredVehicles;
- (void)save;

@end
