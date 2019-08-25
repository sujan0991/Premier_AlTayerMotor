//
//  VehiclesDisplayData.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehiclesDisplayData : NSObject

@property (nonatomic, readonly, strong) NSMutableArray *vehicles;

- (instancetype)initWithVehicles:(NSArray *)vehicles;
- (void)addVehicles:(NSArray*)vehicles;
@end
