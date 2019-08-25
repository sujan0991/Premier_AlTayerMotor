//
//  VehiclesNetworkInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MResponse;

@protocol VehiclesNetworkInterface <NSObject>

-(void)gotVehiclesError:(NSError *)error;
-(void)gotOffersError:(NSError *)error;
-(void)gotVehiclesResponse:(MResponse *)response;
-(void)gotOffersResponse:(MResponse *)response;

@end
