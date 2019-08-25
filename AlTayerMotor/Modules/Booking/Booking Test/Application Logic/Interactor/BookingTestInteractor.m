//
//  BookingTestInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/17/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingTestInteractor.h"
#import "BookingTestDataManager.h"
#import "BookingTestNetwork.h"
#import "Mresponse.h"
#import "MBookingTestRequest.h"

@interface BookingTestInteractor()

@property (strong, nonatomic) BookingTestNetwork *apiNetwork;
@property (nonatomic, strong) BookingTestDataManager *dataManager;

@end

@implementation BookingTestInteractor

- (instancetype)initWithDataManager:(BookingTestDataManager *)dataManager
                         andNetwork:(BookingTestNetwork *)network
{
    if (self = [super init]) {
        self.dataManager = dataManager;
        self.apiNetwork = network;
    }
    
    return self;
}

#pragma mark - Interactor input
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

- (void)findUserInfo
{
    MUser *user = [self.dataManager findUserInfo];
    [self.output foundUserInfo:user];
}

- (void)findCities
{
    NSArray *cities = [self.dataManager findCities];
    // Convert from City to MCity
    NSArray *mCities = [cities linq_select:^id(City *city) {
        return [[MCity alloc] initWithDatabaseObject:city];
    }];
    [self.output foundCities:mCities];
}

- (void)findLocations
{
    NSArray *locations = [self.dataManager findLocations];
    // Convert from Location to MLocation
    NSArray *mLocations = [locations linq_select:^id(Location *location) {
        return [[MLocation alloc] initWithDatabaseObject:location];
    }];
    [self.output foundLocations:mLocations];
}

- (void)postBookingService:(MBookingTestRequest *)request
{
    [self.apiNetwork postBookingTest:request];
}

#pragma mark - network
- (void)networkError:(NSError *)error
{
    [self.output postBookingTestFailed];
}

- (void)networkDidLoad:(MResponse *)response inRequest:(MBookingTestRequest *)request
{
    MPayloadResult *payload = (MPayloadResult *)response.payload;
    if (payload && payload.success) {
        [self.output postBookingTestSuccessWithRequest:request];
    } else {
        [self.output postBookingTestFailed];
    }
    
}


@end
