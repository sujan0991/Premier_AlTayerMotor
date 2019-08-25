//
//  EnquiryNetwork.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/15/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATMNetwork.h"

@protocol EnquiryNetworkInterface;
@class MEnquiryRequest;

@interface EnquiryNetwork : ATMNetwork

@property (nonatomic, weak) id<EnquiryNetworkInterface> apiNetworkInterface;

- (void)postEnquiry:(MEnquiryRequest *)request;

@end
