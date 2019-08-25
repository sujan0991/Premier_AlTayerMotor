//
//  RoadsideDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "RoadsideDataManager.h"
#import "CoreDataStore.h"

@implementation RoadsideDataManager

- (NSArray *)findAllBrands
{
    return [self.dataStore fetchAllBrands];
}

@end
