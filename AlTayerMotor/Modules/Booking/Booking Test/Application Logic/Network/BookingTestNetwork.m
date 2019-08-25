//
//  BookingTestNetwork.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/17/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingTestNetwork.h"
#import "HttpsManager.h"
#import "MBookingTestRequest.h"
#import "MResponse.h"

@implementation BookingTestNetwork

- (void)postBookingTest:(MBookingTestRequest *)request
{
    [[HttpsManager sharedManager] postBookTest:request withCompletion:^(MResponse *response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface networkError:error];
                return ;
            }
            
            [_apiNetworkInterface networkDidLoad:response inRequest:request];
        }
    }];
}

@end
