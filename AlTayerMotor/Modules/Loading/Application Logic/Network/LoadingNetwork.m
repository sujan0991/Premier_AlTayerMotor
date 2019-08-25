//
//  LoadingNetwork.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/2/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LoadingNetwork.h"
#import "HttpsManager.h"
#import "MToken.h"
#import "MBrand.h"
#import "MVehicleModel.h"
#import "MResponse.h"

@implementation LoadingNetwork

- (void)getToken
{
    [[HttpsManager sharedManager] generateTokenWithCompletion:^(NSDictionary *response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface networkError:error inApi:LoadingApiTypeToken];
                return ;
            }

            MToken *token = [[MToken alloc] initWithDict:response];
            MResponse *response = [MResponse new];
            MPayloadToken *payload = [MPayloadToken new];
            payload.token = token;
            response.payload = payload;
            [_apiNetworkInterface networkDidLoad:response fromApi:LoadingApiTypeToken];
        }
    }];
}

- (void)getBrandsSince:(NSString *)date
{
    [[HttpsManager sharedManager] getBrandsSince:date withCompletion:^(MResponse *response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface networkError:error inApi:LoadingApiTypeBrand];
                return ;
            }
            
            [_apiNetworkInterface networkDidLoad:response fromApi:LoadingApiTypeBrand];
        }
    }];
}

- (void)getPreownedBrandsSince:(NSString *)date
{
    [[HttpsManager sharedManager] getPreownedBrandsSince:date withCompletion:^(MResponse *response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface networkError:error inApi:LoadingApiTypePreownedBrand];
                return ;
            }
            
            [_apiNetworkInterface networkDidLoad:response fromApi:LoadingApiTypePreownedBrand];
        }
    }];
}

- (void)getCities
{
    [[HttpsManager sharedManager] getCitiesWithCompletion:^(MResponse *response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface networkError:error inApi:LoadingApiTypeCity];
                return ;
            }
            
            [_apiNetworkInterface networkDidLoad:response fromApi:LoadingApiTypeCity];
        }
    }];
}

- (void)getLocations
{
    [[HttpsManager sharedManager] getLocationsWithCompletion:^(MResponse *response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface networkError:error inApi:LoadingApiTypeLocation];
                return ;
            }
            
            [_apiNetworkInterface networkDidLoad:response fromApi:LoadingApiTypeLocation];
        }
    }];
}

- (void)getDrivingExperience
{
    [[HttpsManager sharedManager] getDrivingExperiencesWithCompletion:^(MResponse *response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface networkError:error inApi:LoadingApiTypeDrivingExperiences];
                return ;
            }
            
            [_apiNetworkInterface networkDidLoad:response fromApi:LoadingApiTypeDrivingExperiences];
        }
    }];
}

- (void)getGlobalSettings
{
    [[HttpsManager sharedManager] getGlobalSettingsWithCompletion:^(MResponse *response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface networkError:error inApi:LoadingApiTypeGlobalSettings];
                return ;
            }
            
            [_apiNetworkInterface networkDidLoad:response fromApi:LoadingApiTypeGlobalSettings];
        }
    }];
}

@end
