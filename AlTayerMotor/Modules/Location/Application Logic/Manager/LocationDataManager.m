//
//  LocationDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/8/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "LocationDataManager.h"
#import "CoreDataStore.h"

@implementation LocationDataManager

- (NSArray *)findLocations
{
    return [self.dataStore fetchAllLocations];
}

@end
