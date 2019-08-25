//
//  VehiclesModelDisplayData.m
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import "VehicleModelsDisplayData.h"

@implementation VehicleModelsDisplayData

- (instancetype)initWithModels:(NSArray *)models
{
    if (self = [super init]) {
        self.models = models;
    }
    
    return self;
}

@end