//
//  BrandsDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/27/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;
@class MUser;

@interface BrandsDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray *)findAllBrands;
- (MUser *)findUserInfo;

@end
