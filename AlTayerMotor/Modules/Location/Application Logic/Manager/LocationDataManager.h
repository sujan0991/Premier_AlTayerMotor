//
//  LocationDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 12/8/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;

@interface LocationDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray *)findLocations;

@end
