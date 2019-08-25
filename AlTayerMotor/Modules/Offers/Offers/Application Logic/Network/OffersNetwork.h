//
//  OffersNetwork.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATMNetwork.h"

@protocol OffersNetworkInterface;

@interface OffersNetwork : ATMNetwork
@property (nonatomic, weak) id<OffersNetworkInterface> apiNetworkInterface;

- (void) getOffers;
@end
