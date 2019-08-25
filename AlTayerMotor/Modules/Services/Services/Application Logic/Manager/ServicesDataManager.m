//
//  ServicesDataManager.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServicesDataManager.h"
#import "CoreDataStore.h"

@implementation ServicesDataManager

- (NSArray *)findRegisteredVehicles
{
    return [self.dataStore fetchAllRegisteredVehicles];
}

- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number
{
    [self.dataStore deleteRegisteredVehicleByRegistrationNumber:number];
}

@end
