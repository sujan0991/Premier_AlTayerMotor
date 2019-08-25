//
//  BookingTestNetworkInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/17/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MResponse;
@class MBookingTestRequest;

@protocol BookingTestNetworkInterface <NSObject>
-(void)networkError:(NSError *)error;
-(void)networkDidLoad:(MResponse*)response inRequest:(MBookingTestRequest *)request;
@end
