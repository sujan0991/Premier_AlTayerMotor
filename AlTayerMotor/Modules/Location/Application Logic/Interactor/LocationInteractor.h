//
//  LocationInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/8/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationInteractorIO.h"

@class LocationNetwork;
@class LocationDataManager;

@interface LocationInteractor : NSObject<LocationInteractorInput>

@property (weak, nonatomic) id<LocationInteractorOutput> output;

- (instancetype)initWithDataManager:(LocationDataManager *)dataManager;

@end
