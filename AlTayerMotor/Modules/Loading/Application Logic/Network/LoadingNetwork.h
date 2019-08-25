//
//  LoadingNetwork.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/2/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadingNetworkInterface.h"
#import "ATMNetwork.h"

@interface LoadingNetwork : ATMNetwork

@property (nonatomic, weak) id<LoadingNetworkInterface> apiNetworkInterface;

- (void)getToken;
- (void)getBrandsSince:(NSString *)date;
- (void)getPreownedBrandsSince:(NSString *)date;
- (void)getCities;
- (void)getLocations;
- (void)getDrivingExperience;
- (void)getGlobalSettings;
@end
