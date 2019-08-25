//
//  BrandsDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "BrandsDataManager.h"
#import "CoreDataStore.h"
#import "MUser.h"

@implementation BrandsDataManager

- (NSArray *)findAllBrands
{
    return [self.dataStore fetchAllPreownedBrands];
}

- (MUser *)findUserInfo
{
    MUser *user = [self.dataStore getUserInfo];
    return user;
}

@end
