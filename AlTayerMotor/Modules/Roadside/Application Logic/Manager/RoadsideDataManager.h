//
//  RoadsideDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/11/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;

@interface RoadsideDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray *)findAllBrands;

@end
