//
//  LatestOffersInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LatestOffersInteractorIO.h"
#import "LatestOffersNetworkInterface.h"

@class LatestOffersNetwork;

@interface LatestOffersInteractor : NSObject <LatestOffersInteractorInput, LatestOffersNetworkInterface>


@property (nonatomic, weak) id<LatestOffersInteractorOutput> output;

- (instancetype)initWithNetwork:(LatestOffersNetwork *)apiNetwork;

@end
