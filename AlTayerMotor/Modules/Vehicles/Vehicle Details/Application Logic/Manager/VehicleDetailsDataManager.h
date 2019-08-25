//
//  VehicleDetailsDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;

@interface VehicleDetailsDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

@end
