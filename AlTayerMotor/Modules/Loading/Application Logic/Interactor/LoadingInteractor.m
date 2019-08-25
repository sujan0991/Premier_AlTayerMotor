//
//  LoadingInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/2/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LoadingInteractor.h"
#import "LoadingNetwork.h"
#import "LoadingDataManager.h"
#import "MToken.h"
#import "LocalDataManager.h"
#import "DateManager.h"
#import "ATMGlobal.h"
#import "MResponse.h"

@interface LoadingInteractor()
@property (strong, nonatomic) LoadingNetwork *apiNetwork;
@property (nonatomic, strong) LoadingDataManager *dataManager;
@end

@implementation LoadingInteractor

-(instancetype)initWithNetwork:(LoadingNetwork *)apiNetwork andDataManager:(LoadingDataManager*)dataManager
{
    if (self = [super init]) {
        _apiNetwork = apiNetwork;
        _dataManager = dataManager;
    }
    
    return self;
}

#pragma mark - Loading Network Interface
- (void)startSyncing
{
    [_apiNetwork getToken];
}

#pragma mark - Loading Network Delegate
- (void)networkError:(NSError *)error inApi:(LoadingApiType)type
{
    switch (type) {
        case LoadingApiTypeToken:
            [self.output didCompleteSyncing];
            break;
            
        case LoadingApiTypeBrand:
            [self startGetPreownedBrand];
            break;
            
        case LoadingApiTypePreownedBrand:
            [_apiNetwork getCities];
            break;
            
        case LoadingApiTypeCity:
            [_apiNetwork getLocations];
            break;
            
        case LoadingApiTypeLocation:
            [_apiNetwork getDrivingExperience];
            break;
            
        case LoadingApiTypeDrivingExperiences:
            [_apiNetwork getGlobalSettings];
            break;
            
        case LoadingApiTypeGlobalSettings:
            [self.output didCompleteSyncing];
            break;
            
        default:
            [self.output didCompleteSyncing];
            break;
    }
}

- (void)networkDidLoad:(MResponse *)response fromApi:(LoadingApiType)type
{
    switch (type) {
        case LoadingApiTypeToken:
            [[LocalDataManager sharedManager] setToken:[((MPayloadToken *)response.payload) token]];
            [self startGetBrand];
            break;
            
        case LoadingApiTypeBrand:
            [self storeBrandsFromResponse:response];
            [self startGetPreownedBrand];
            break;
            
        case LoadingApiTypePreownedBrand:
            [self storePreownedBrandsFromResponse:response];
            [_apiNetwork getCities];
            break;
            
        case LoadingApiTypeCity:
            [self storeCitiesFromResponse:response];
            [_apiNetwork getLocations];
            break;
            
        case LoadingApiTypeLocation:
            [self storeLocationsFromResponse:response];
            [_apiNetwork getDrivingExperience];
            break;
            
        case LoadingApiTypeDrivingExperiences:
            [self storeDrivingExperiencesFromResponse:response];
            [_apiNetwork getGlobalSettings];
            break;
            
        case LoadingApiTypeGlobalSettings:
            [self storeGlobalSettingsFromResponse:response];
            [self.output didCompleteSyncing];
            break;
            
        default:
            [self.output didCompleteSyncing];
            break;
    }
}


#pragma mark - Actions
- (void)startGetBrand
{
//    if ([ATMGlobal shouldUpdateBrands]) {
//        NSInteger lastUpdateInt = [[LocalDataManager sharedManager] lastTimeUpdateBrand];
//        NSString *lastUpdate = nil;
//        if (lastUpdateInt > 0) {
//            NSDate *lastUpdateDate = [[[DateManager sharedManager] numberDateFormatter] dateFromString:[NSString stringWithFormat:@"%ld", (long)lastUpdateInt]];
//            lastUpdate = [[[DateManager sharedManager] dateFormatter] stringFromDate:lastUpdateDate];
//        } else {
//            lastUpdate = @"2015-01-01";
//        }
//        [_apiNetwork getBrandsSince:lastUpdate];
//    } else {
//        [self startGetPreownedBrand];
//    }
    
    // Force downloading all data everytime
    [_apiNetwork getBrandsSince:@"2015-01-01"];
}

- (void)startGetPreownedBrand
{
//    if ([ATMGlobal shouldUpdatePreownedBrands]) {
//        NSInteger lastUpdateInt = [[LocalDataManager sharedManager] lastTimeUpdatePreownedBrand];
//        NSString *lastUpdate = nil;
//        if (lastUpdateInt > 0) {
//            NSDate *lastUpdateDate = [[[DateManager sharedManager] numberDateFormatter] dateFromString:[NSString stringWithFormat:@"%ld", (long)lastUpdateInt]];
//            lastUpdate = [[[DateManager sharedManager] dateFormatter] stringFromDate:lastUpdateDate];
//        } else {
//            lastUpdate = @"2015-01-01";
//        }
//        [_apiNetwork getPreownedBrandsSince:lastUpdate];
//    } else {
//        [_apiNetwork getCities];
//    }
    
    // Force downloading all data everytime
    [_apiNetwork getPreownedBrandsSince:@"2015-01-01"];
}

- (void)storeBrandsFromResponse:(MResponse *)response
{
    [[LocalDataManager sharedManager] setLastTimeUpdateBrand];
    MPayloadBrandsList *payload = (MPayloadBrandsList *)response.payload;
    [_dataManager syncBrands:payload.brands];
}

- (void)storePreownedBrandsFromResponse:(MResponse *)response
{
    [[LocalDataManager sharedManager] setLastTimeUpdatePreownedBrand];
    MPayloadBrandsList *payload = (MPayloadBrandsList *)response.payload;
    [_dataManager syncPreownedBrands:payload.brands];
}

- (void)storeCitiesFromResponse:(MResponse *)response
{
    MPayloadCitiesList *payload = (MPayloadCitiesList *)response.payload;
    [_dataManager syncCities:payload.cities];
}

- (void)storeDrivingExperiencesFromResponse:(MResponse *)response
{
    MPayloadDrivingExperiencesList *payload = (MPayloadDrivingExperiencesList *)response.payload;
    [_dataManager syncDrivingExperiences:payload.drivingExperiences];
}

- (void)storeLocationsFromResponse:(MResponse *)response
{
    MPayloadLocationsList *payload = (MPayloadLocationsList *)response.payload;
    [_dataManager syncLocations:payload.locations];
}

- (void)storeGlobalSettingsFromResponse:(MResponse *)response
{
    MPayloadGlobalSettingsList *payload = (MPayloadGlobalSettingsList *)response.payload;
    [_dataManager syncGlobalSettings:payload.globalSettings];
}

@end
