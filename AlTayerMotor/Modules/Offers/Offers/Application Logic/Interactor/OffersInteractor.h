//
//  OffersInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OffersInteractorIO.h"
#import "OffersNetworkInterface.h"

@class OffersDataManager;
@class OffersNetwork;

@interface OffersInteractor : NSObject <OffersInteractorInput, OffersNetworkInterface>

@property (nonatomic, weak) id<OffersInteractorOutput> output;

- (instancetype)initWithDataManager:(OffersDataManager *)dataManager
                         andNetwork:(OffersNetwork *)network;

@end
