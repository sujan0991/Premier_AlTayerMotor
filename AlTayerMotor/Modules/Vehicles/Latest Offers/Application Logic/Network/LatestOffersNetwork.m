//
//  LatestOffersNetwork.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LatestOffersNetwork.h"
#import "HttpsManager.h"
#import "LatestOffersNetworkInterface.h"

@implementation LatestOffersNetwork

- (void)getLatestOffers
{
    [[HttpsManager sharedManager] getLatestOffersWithCompletion:^(MResponse *response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface didGetError:error];
                return ;
            }
            
            [_apiNetworkInterface didGetLatestOffers:response];
        }
    }];
}
@end
