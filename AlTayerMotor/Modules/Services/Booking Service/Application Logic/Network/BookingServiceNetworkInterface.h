//
//  BookingServiceNetworkInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/10/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MResponse;
@class MServiceRequest;

@protocol BookingServiceNetworkInterface <NSObject>

-(void)networkError:(NSError *)error;
-(void)networkDidLoad:(MResponse*)response inRequest:(MServiceRequest *)request;

@end
