//
//  OffersDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/23/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;
@class MBrand;

@interface OffersDataManager : NSObject
@property (nonatomic, strong) CoreDataStore *dataStore;

- (MBrand *)getBrandById:(NSInteger)brandId;
- (NSArray *)getOffersSettings;

@end
