//
//  VehiclesNetwork.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehiclesNetwork.h"
#import "HttpsManager.h"
#import "VehiclesNetworkInterface.h"
#import "VehiclesFilterDisplayData.h"
#import "MResponse.h"
#import "MVehicle.h"

@implementation VehiclesNetwork

- (void)getVehiclesInBrand:(NSInteger)brandId
                    inPage:(NSInteger)page
                withFilter:(VehiclesFilterDisplayData *)filterData
{
    [[HttpsManager sharedManager] getVehiclesInPage:page inBrand:brandId withFilter:filterData withCompletion:^(NSDictionary *responseDict, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface gotVehiclesError:error];
                return;
            }
            
            MResponse *response = [self responseWithoutPayload:responseDict];
            MPayloadVehiclesList *payload = [MPayloadVehiclesList new];
            
            NSArray *payloadArr = [self payload:responseDict];
            if ([self isArray:payloadArr]) {
                NSMutableArray *vehicles = [@[] mutableCopy];
                [payloadArr enumerateObjectsUsingBlock:^(NSDictionary *vehicleDict, NSUInteger idx, BOOL * _Nonnull stop) {
                    MVehicle *vehicle =[[MVehicle alloc] initWithDict:vehicleDict];
                    [vehicles addObject:vehicle];
                }];
                payload.vehicles = vehicles;
            }
            
            response.payload = payload;
            [_apiNetworkInterface gotVehiclesResponse:response];
        }
    }];
}

- (void)getBrandOffers:(NSInteger)brandId
{
    [[HttpsManager sharedManager] getBrandOffers:brandId withCompletion:^(MResponse *response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface gotOffersError:error];
                return ;
            }
            
            [_apiNetworkInterface gotOffersResponse:response];
        }
    }];
}

@end
