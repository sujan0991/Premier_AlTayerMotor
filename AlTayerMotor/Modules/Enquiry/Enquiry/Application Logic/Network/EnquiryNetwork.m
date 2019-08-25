//
//  EnquiryNetwork.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "EnquiryNetwork.h"
#import "HttpsManager.h"
#import "EnquiryNetworkInterface.h"

@implementation EnquiryNetwork

- (void)postEnquiry:(MEnquiryRequest *)request
{
    [[HttpsManager sharedManager] postEnquiryRequest:request withCompletion:^(MResponse *response, NSError *error) {
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
