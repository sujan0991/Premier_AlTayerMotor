//
//  VehicleDetailsInteractor.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehicleDetailsInteractor.h"

@interface VehicleDetailsInteractor()
@property (nonatomic, strong) VehicleDetailsDataManager *dataManager;
@end

@implementation VehicleDetailsInteractor

-(instancetype)initWithDataManager:(VehicleDetailsDataManager*)dataManager
{
    if (self = [super init]) {
        self.dataManager = dataManager;
    }
    
    return self;
}

@end
