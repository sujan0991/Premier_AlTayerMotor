//
//  OffersDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "OffersDataManager.h"
#import "CoreDataStore.h"
#import "MBrand.h"

@implementation OffersDataManager

- (MBrand *)getBrandById:(NSInteger)brandId
{
    return [self.dataStore getBrandById:brandId];
}

- (NSArray *)getOffersSettings
{
    return [self.dataStore fetchGlobalSettingsByKey:@"offer"];
}

@end
