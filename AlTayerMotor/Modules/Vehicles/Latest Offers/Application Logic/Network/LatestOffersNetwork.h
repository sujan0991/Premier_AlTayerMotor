//
//  LatestOffersNetwork.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ATMNetwork.h"

@protocol LatestOffersNetworkInterface;

@interface LatestOffersNetwork : ATMNetwork
@property (nonatomic, weak) id<LatestOffersNetworkInterface> apiNetworkInterface;

- (void)getLatestOffers;
@end
