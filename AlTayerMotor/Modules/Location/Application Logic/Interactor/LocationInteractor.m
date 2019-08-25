//
//  LocationInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/8/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LocationInteractor.h"
#import "LocationDataManager.h"
#import "MLocation.h"
#import "Location.h"

@interface LocationInteractor()
@property (nonatomic, strong) LocationDataManager *dataManager;
@end


@implementation LocationInteractor

- (instancetype)initWithDataManager:(LocationDataManager *)dataManager
{
    if (self = [super init]) {
        self.dataManager = dataManager;
    }
    
    return self;
}

- (void)findLocations
{
    NSArray *locations = [self.dataManager findLocations];
    // Convert from Location to MLocation
    NSArray *mLocations = [locations linq_select:^id(Location *location) {
        return [[MLocation alloc] initWithDatabaseObject:location];
    }];
    [self.output foundLocations:mLocations];
}

@end
