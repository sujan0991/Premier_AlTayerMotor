//
//  InsuranceNetworkInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/16/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MResponse;
@class MInsuranceRequest;

@protocol InsuranceNetworkInterface <NSObject>

-(void)networkError:(NSError *)error;
-(void)networkDidLoad:(MResponse*)response inRequest:(MInsuranceRequest *)request;

@end
