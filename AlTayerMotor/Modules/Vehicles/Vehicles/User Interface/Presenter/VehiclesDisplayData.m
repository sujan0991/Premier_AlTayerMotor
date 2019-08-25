    //
//  VehiclesDisplayData.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehiclesDisplayData.h"

@interface VehiclesDisplayData()
@property (nonatomic, strong) NSMutableArray *vehicles;
@end

@implementation VehiclesDisplayData

- (instancetype)initWithVehicles:(NSArray *)vehicles
{
    if (self = [super init]) {
        self.vehicles = [vehicles mutableCopy];
    }
    
    return self;
}

- (void)addVehicles:(NSArray*)vehicles {
    if (self.vehicles) {
        [self.vehicles addObjectsFromArray:vehicles];
    } else {
        self.vehicles = [vehicles mutableCopy];
    }
    DLog(@"[%lu]", (unsigned long)self.vehicles.count);
}

@end
