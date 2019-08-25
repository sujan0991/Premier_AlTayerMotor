//
//  OffersNetworkInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MResponse;

@protocol OffersNetworkInterface <NSObject>
- (void)didGetOffers:(MResponse *)offers;
- (void)didGetError:(NSError *)error;
@end
