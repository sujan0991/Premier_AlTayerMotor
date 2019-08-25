//
//  VehiclesInteractor.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehiclesInteractor.h"
#import "VehiclesDataManager.h"
#import "VehiclesNetwork.h"
#import "MResponse.h"
#import "MBrand.h"
#import "MVehicle.h"

@interface VehiclesInteractor()
@property (nonatomic, strong) VehiclesDataManager *dataManager;
@property (nonatomic, strong) VehiclesNetwork *network;
@end

@implementation VehiclesInteractor

- (instancetype)initWithDataManager:(VehiclesDataManager *)dataManager andNetwork:(VehiclesNetwork *)network
{
    if (self = [super init]) {
        self.dataManager = dataManager;
        self.network = network;
    }
    
    return self;
}


#pragma mark - Interactor
- (void)loadAllVehicleModelsInBrandId:(NSInteger)brandId
{
    NSArray *vehicleModels = [self.dataManager loadAllVehicleModelsInBrandId:brandId];
    [self.output didLoadVehicleModels:vehicleModels];
}

- (void)getVehiclesInBrand:(NSInteger)brandId inPage:(NSInteger)page withFilter:(VehiclesFilterDisplayData *)data
{
    [self.network getVehiclesInBrand:brandId inPage:page withFilter:data];
}

- (void)getBrandOffers:(NSInteger)brandId
{
    [self.network getBrandOffers:brandId];
}

#pragma mark - Network
- (void)gotVehiclesError:(NSError *)error
{
    [self.output didGetVehiclesError:error];
}

- (void)gotOffersError:(NSError *)error
{
    [self.output didGetOffersError:error];
}

- (void)gotVehiclesResponse:(MResponse *)response
{
    NSArray *vehicles = ((MPayloadVehiclesList *)response.payload).vehicles;
    [vehicles enumerateObjectsUsingBlock:^(MVehicle *vehicle, NSUInteger idx, BOOL * _Nonnull stop) {
        vehicle.brand = [self.dataManager getBrandById:vehicle.brandId];
    }];
    
    [self.output didGetVehicles:vehicles];
}


-(void)gotOffersResponse:(MResponse *)response
{
    NSArray *offers = ((MPayloadOffersList *) response.payload).offers;
    [self.output didGetOffers:offers];
}

@end
