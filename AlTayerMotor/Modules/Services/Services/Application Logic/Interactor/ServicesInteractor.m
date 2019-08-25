//
//  ServicesInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/5/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "ServicesInteractor.h"

@interface ServicesInteractor()
@property (nonatomic, strong) ServicesDataManager *dataManager;
@end



@implementation ServicesInteractor

- (instancetype)initWithDataManager:(ServicesDataManager *)dataManager
{
    if (self = [super init]) {
        self.dataManager = dataManager;
    }
    
    return self;
}

#pragma mark - Input
- (void)findRegisteredVehicles
{
    NSArray *vehicles = [self.dataManager findRegisteredVehicles];
    [self.output foundRegisteredVehicles:vehicles];
}

- (void)deleteRegisteredVehicleByRegistrationNumber:(NSString *)number
{
    [self.dataManager deleteRegisteredVehicleByRegistrationNumber:number];
}

@end
