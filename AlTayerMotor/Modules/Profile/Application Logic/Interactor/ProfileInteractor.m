//
//  ProfileInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ProfileInteractor.h"
#import "ProfileDataManager.h"
#import "MRegisteredVehicle.h"

@interface ProfileInteractor()
@property (nonatomic, strong) ProfileDataManager *dataManager;
@end

@implementation ProfileInteractor

- (instancetype)initWithDataManager:(ProfileDataManager *)dataManager
{
    if (self = [super init]) {
        self.dataManager = dataManager;
    }
    
    return self;
}


#pragma mark - Profile Interactor
- (void)findUserInfo
{
    MUser *user = [self.dataManager findUserInfo];
    [self.output foundUserInfo:user];
}

-(void)addRegisteredCar:(MRegisteredVehicle *)car
{
    [self.dataManager addNewRegisteredVehicle:car];
    [self findRegisteredCars];
}

-(void)findRegisteredCars
{
    NSArray *cars = [self.dataManager findAllRegisteredVehicles];
    [self.output foundRegisteredCars:cars];
}

-(void)findCities
{
    NSArray *cities = [self.dataManager findCities];
    [self.output foundCities:cities];
}

- (void)findBrands
{
    NSArray *brands = [self.dataManager findBrands];
    [self.output foundBrands:brands];
}

- (void)findVehicleModelsByBrand:(NSInteger)brandId
{
    NSArray *vehicleModels = [self.dataManager findVehicleModelsByBrand:brandId];
    [self.output foundVehicleModels:vehicleModels];
}

- (void)addUserInformation:(MUser *)user
{
    [self.dataManager addUserInformation:user];
}

- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber
{
    return [self.dataManager hasAlreadyVehicle:registrationNumber];
}

- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber
{
    [self.dataManager updateRegisteredVehicle:vehicle forOldNumber:registrationNumber];
    [self findRegisteredCars];
}

- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number
{
    [self.dataManager deleteRegisteredVehicleByRegistrationNumber:number];
}

@end
