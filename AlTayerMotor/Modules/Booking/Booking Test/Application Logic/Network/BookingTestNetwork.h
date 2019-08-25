//
//  BookingTestNetwork.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/17/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookingTestNetworkInterface.h"

@class MBookingTestRequest;

@interface BookingTestNetwork : NSObject

@property (nonatomic, weak) id<BookingTestNetworkInterface> apiNetworkInterface;

- (void)postBookingTest:(MBookingTestRequest *)request;

@end
