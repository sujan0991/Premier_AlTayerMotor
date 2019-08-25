//
//  BookingServiceNetwork.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/10/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATMNetwork.h"
#import "BookingServiceNetworkInterface.h"

@class MServiceRequest;

@interface BookingServiceNetwork : ATMNetwork

@property (nonatomic, weak) id<BookingServiceNetworkInterface> apiNetworkInterface;

- (void)postBookingService:(MServiceRequest *)request;

@end
