//
//  NewCarsDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/24/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "NewCarsDataManager.h"
#import "CoreDataStore.h"

@implementation NewCarsDataManager

- (NSArray *)findAllBrands
{
    return [self.dataStore fetchAllBrands];
}

@end
