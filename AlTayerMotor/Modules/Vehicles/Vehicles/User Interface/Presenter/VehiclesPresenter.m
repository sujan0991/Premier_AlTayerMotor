//
//  VehiclesPresenter.m
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/21/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehiclesPresenter.h"
#import "TutorialWireframe.h"
#import "VehiclesWireframe.h"
#import "MBrand.h"
#import "Brand.h"
#import "VehicleModel.h"
#import "MVehicleModel.h"
#import "MPreownedBrand.h"
#import "NSArray+LinqExtensions.h"
#import "VehiclesDisplayData.h"
#import "VehicleModelsDisplayData.h"
#import "VehiclesFilterDisplayData.h"
#import "BrandOffersDisplayData.h"

@interface VehiclesPresenter()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isLoadingVehicles;
@property (nonatomic, assign) BOOL hasNoMoreVehicle;

@end

@implementation VehiclesPresenter

- (instancetype)init
{
    if (self = [super init]) {
        self.page = 1;
    }
    
    return self;
}

#pragma Module Interface
- (void)presentFilterInterfaceWithData:(VehiclesFilterDisplayData *)data
{
    [self.vehiclesWireframe presentFilterVehiclesWithData:data
                                             inNavigation:self.userInterface.navigationController];
}

- (void)presentDetailsInterfaceWithData:(MVehicle *)vehicle
{
    [self.vehiclesWireframe presentDetailsInterfaceWithData:vehicle
                                               inNavigation:self.userInterface.navigationController];
}

- (void)presentOffersInterfaceWithData:(NSArray *)offers withViewedIndex:(NSInteger)index
{
    [self.vehiclesWireframe presentPeekOffersInterfaceWithData:offers
                                               withViewedIndex:index
                                                  inNavigation:self.userInterface.navigationController];
}

- (void)getVehicles
{
    VehiclesFilterDisplayData *filterData = [self.userInterface getFilterData];
    
    if ((!_isLoadingVehicles && !_hasNoMoreVehicle) || (filterData && filterData.filterChanged)) {
        if (filterData && filterData.filterChanged) {
            self.page = 1;
            [self.userInterface reloadVehiclesData];
        }
        _isLoadingVehicles = YES;
        [self.vehiclesInteractor getVehiclesInBrand:[self.userInterface getCurrentBrandId]
                                             inPage:self.page
                                         withFilter:filterData];
    }
}

- (void)getOffers
{
    NSInteger brandId = [self.userInterface getCurrentBrand].id;
    [self.vehiclesInteractor getBrandOffers:brandId];
}

- (void)resetHasLoadMore
{
    _hasNoMoreVehicle = NO;
    _isLoadingVehicles = NO;
}

- (void)loadAllVehicleModelsInBrandId:(NSInteger)brandId
{
    [self.vehiclesInteractor loadAllVehicleModelsInBrandId:brandId];
}

- (BOOL)isLoadingAtFirstPage
{
    return _page == 1 && _isLoadingVehicles;
}


#pragma mark - Interactor
- (void)didLoadVehicleModels:(NSArray *)vehicleModels
{
//    NSArray *models = [vehicleModels linq_select:^id(VehicleModel *vehicleModel) {
//        return [[MVehicleModel alloc] initWithVehicleModel:vehicleModel];
//    }];
    VehicleModelsDisplayData *data = [[VehicleModelsDisplayData alloc] initWithModels:vehicleModels];
    
    [self.userInterface updateVehicleModelsData:data];
}

- (void)didGetVehicles:(NSArray *)vehicles
{
    self.page++;
    VehiclesFilterDisplayData *filterData = [self.userInterface getFilterData];
    VehiclesDisplayData *data = [self.userInterface getVehiclesData];
    if (filterData.filterChanged) {
        filterData.filterChanged = NO;
        [data.vehicles removeAllObjects];
    }
    
    [data addVehicles:vehicles];
    
    _isLoadingVehicles = NO;
    if (vehicles && vehicles.count < 10) {
        _hasNoMoreVehicle = YES;
    }
    
    [self.userInterface reloadVehiclesData];
}

- (void)didGetVehiclesError:(NSError *)error
{
    VehiclesFilterDisplayData *filterData = [self.userInterface getFilterData];
    VehiclesDisplayData *data = [self.userInterface getVehiclesData];
    
    if (filterData.filterChanged) {
        filterData.filterChanged = NO;
        [data.vehicles removeAllObjects];
    }
    
    _isLoadingVehicles = NO;
    [self.userInterface reloadVehiclesData];
}

- (void)didGetOffers:(NSArray *)offers
{
    BrandOffersDisplayData *data = [self.userInterface getOffersData];
    data.offers = offers;
    [self.userInterface reloadVehiclesData];
}

- (void)didGetOffersError:(NSError *)error
{
    BrandOffersDisplayData *data = [self.userInterface getOffersData];
    data.offers = nil;
    [self.userInterface reloadVehiclesData];
}

@end
