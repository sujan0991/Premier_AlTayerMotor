//
//  FirstTimeInteractor.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/20/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "FirstTimeInteractor.h"
#import "FirstTimeDataManager.h"
#import "MRegisteredVehicle.h"

@interface FirstTimeInteractor()

@property (nonatomic, strong) FirstTimeDataManager *dataManager;

@end

@implementation FirstTimeInteractor

- (instancetype)initWithDataManager:(FirstTimeDataManager *)dataManager
{
    if (self = [super init]) {
        self.dataManager = dataManager;
    }
    
    return self;
}


#pragma mark - First Time Interactor
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
