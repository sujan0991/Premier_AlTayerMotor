//
//  InsuranceNetwork.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "InsuranceNetwork.h"
#import "HttpsManager.h"
#import "MInsuranceRequest.h"
#import "MResponse.h"

@implementation InsuranceNetwork

- (void)postInsuranceRequest:(MInsuranceRequest *)request
{
    [[HttpsManager sharedManager] postInsuranceRequest:request withCompletion:^(MResponse *response, NSError *error) {
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
