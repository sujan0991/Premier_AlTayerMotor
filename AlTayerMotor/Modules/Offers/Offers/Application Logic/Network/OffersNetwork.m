//
//  OffersNetwork.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OffersNetwork.h"
#import "HttpsManager.h"
#import "MResponse.h"
#import "OffersNetworkInterface.h"
@implementation OffersNetwork

- (void)getOffers
{
    [[HttpsManager sharedManager] getOffersWithCompletion:^(id response, NSError *error) {
        if (_apiNetworkInterface) {
            if (error) {
                [_apiNetworkInterface didGetError:error];
                return ;
            }
            
            [_apiNetworkInterface didGetOffers:response];
        }
    }];
}
@end
