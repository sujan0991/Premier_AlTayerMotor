//
//  EditRegisteredVehicleInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 1/4/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

#import "EditRegisteredVehicleInteractor.h"
#import "EditRegisteredVehicleDataManager.h"
#import "MRegisteredVehicle.h"

@interface EditRegisteredVehicleInteractor()
@property (nonatomic, strong) EditRegisteredVehicleDataManager* dataManager;
@end

@implementation EditRegisteredVehicleInteractor

- (instancetype)initWithDataManager:(EditRegisteredVehicleDataManager *)dataManager
{
    if (self = [super init]) {
        self.dataManager = dataManager;
    }
    return self;
}


#pragma mark - Profile Interactor
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

- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber
{
    return [self.dataManager hasAlreadyVehicle:registrationNumber];
}

- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber
{
    [self.dataManager updateRegisteredVehicle:vehicle forOldNumber:registrationNumber];
    [self.output completeUpdatingRegisteredVehicle];
}

@end
