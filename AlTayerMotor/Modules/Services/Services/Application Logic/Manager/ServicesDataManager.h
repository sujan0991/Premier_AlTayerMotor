//
//  ServicesDataManager.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreDataStore;

@interface ServicesDataManager : NSObject

@property (nonatomic, strong) CoreDataStore *dataStore;

- (NSArray *)findRegisteredVehicles;
- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number;

@end
