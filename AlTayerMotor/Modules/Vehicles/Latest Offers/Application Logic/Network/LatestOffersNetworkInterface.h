//
//  LatestOffersNetworkInterface.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MResponse;

@protocol LatestOffersNetworkInterface <NSObject>
-(void)didGetLatestOffers:(MResponse *)resposne;
-(void)didGetError:(NSError *)error;
@end
