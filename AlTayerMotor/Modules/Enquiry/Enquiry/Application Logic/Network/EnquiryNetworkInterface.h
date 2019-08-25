//
//  EnquiryNetworkInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MResponse;
@class MEnquiryRequest;

@protocol EnquiryNetworkInterface <NSObject>

-(void)networkError:(NSError *)error;
-(void)networkDidLoad:(MResponse*)response inRequest:(MEnquiryRequest *)request;

@end
