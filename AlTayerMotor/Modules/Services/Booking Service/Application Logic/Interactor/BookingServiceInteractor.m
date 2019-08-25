//
//  BookingServiceInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/10/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingServiceInteractor.h"
#import "BookingServiceDataManager.h"
#import "BookingServiceNetwork.h"
#import "MResponse.h"

#import "MBrand.h"
#import "Brand.h"

#import "MCity.h"
#import "City.h"

#import "MLocation.h"
#import "Location.h"

@interface BookingServiceInteractor()
@property (strong, nonatomic) BookingServiceNetwork *apiNetwork;
@property (nonatomic, strong) BookingServiceDataManager *dataManager;
@end

@implementation BookingServiceInteractor

- (instancetype)initWithDataManager:(BookingServiceDataManager *)dataManager
                         andNetwork:(BookingServiceNetwork *)network
{
    if (self = [super init]) {
        self.apiNetwork = network;
        self.dataManager = dataManager;
    }
    
    return self;
}

#pragma mark - Interactor
- (void)findBrands
{
    NSArray *brands = [self.dataManager findBrands];
    // Convert from Brand to MBrand
    NSArray *mBrands = [brands linq_select:^id(Brand *brand) {
        return [[MBrand alloc] initWithId:[brand.id integerValue]
                                 withName:brand.name
                               withNameAR:brand.name_ar
                                 withLogo:brand.logo
                                  withUrl:brand.url
                             withRoadside:brand.roadside];
    }];
    [self.output foundBrands:mBrands];
}

- (void)findVehicleModelsByBrand:(NSInteger)brandId
{
    NSArray *vehicleModels = [self.dataManager findVehicleModelsByBrand:brandId];
    [self.output foundVehicleModels:vehicleModels];
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

-   (void)addRegisteredCar:(MRegisteredVehicle *)car
{
    [self.dataManager addNewRegisteredVehicle:car];
}

- (void)updateRegisteredVehicle:(MRegisteredVehicle *)vehicle forOldNumber:(NSString *)registrationNumber
{
    [self.dataManager updateRegisteredVehicle:vehicle forOldNumber:registrationNumber];
}

- (BOOL)hasAlreadyVehicle:(NSString *)registrationNumber
{
    return [self.dataManager hasAlreadyVehicle:registrationNumber];
}

- (void)postBookingService:(MServiceRequest *)request
{
    [self.apiNetwork postBookingService:request];
}

#pragma mark - network
- (void)networkError:(NSError *)error
{
    [self.output postBookingServiceFailed:nil];
}

- (void)networkDidLoad:(MResponse *)response inRequest:(MServiceRequest *)request
{
    MPayloadResult *payload = (MPayloadResult *)response.payload;
    if (payload && payload.success) {
        [self.output postBookingServiceSuccessWithRequest:request];
    } else {
        [self.output postBookingServiceFailed:response];
    }

}

@end
