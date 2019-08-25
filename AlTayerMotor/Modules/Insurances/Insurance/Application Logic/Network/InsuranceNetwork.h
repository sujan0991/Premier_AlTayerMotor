//
//  InsuranceNetwork.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsuranceNetworkInterface.h"

@class MInsuranceRequest;

@interface InsuranceNetwork : NSObject

@property (nonatomic, weak) id<InsuranceNetworkInterface> apiNetworkInterface;

- (void)postInsuranceRequest:(MInsuranceRequest *)request;

@end
