//
//  VehiclesNetwork.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATMNetwork.h"

@protocol VehiclesNetworkInterface;
@class VehiclesFilterDisplayData;

@interface VehiclesNetwork : ATMNetwork

@property (nonatomic, weak) id<VehiclesNetworkInterface> apiNetworkInterface;

- (void)getVehiclesInBrand:(NSInteger)brandId
                    inPage:(NSInteger)page
                withFilter:(VehiclesFilterDisplayData *)filterData;

- (void)getBrandOffers:(NSInteger)brandId;

@end
