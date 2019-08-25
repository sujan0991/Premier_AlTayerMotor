//
//  VehiclesModelDisplayData.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 10/28/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleModelsDisplayData : NSObject

@property (nonatomic, strong) NSArray *models;


- (instancetype)initWithModels:(NSArray *)models;

@end
