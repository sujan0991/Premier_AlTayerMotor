//
//  BookingServiceNetwork.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/10/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BookingServiceNetwork.h"
#import "HttpsManager.h"


@implementation BookingServiceNetwork

- (void)postBookingService:(MServiceRequest *)request
{
    [[HttpsManager sharedManager] postBookService:request withCompletion:^(MResponse *response, NSError *error) {
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
