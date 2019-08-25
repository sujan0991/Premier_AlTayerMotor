//
//  VehicleDetailsInteractor.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/30/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleDetailsInteractorIO.h"

@class VehicleDetailsNetwork;
@class VehicleDetailsDataManager;

@interface VehicleDetailsInteractor : NSObject <VehicleDetailsInteractorInput>

@property (weak, nonatomic) id<VehicleDetailsInteractorOutput> output;

-(instancetype)initWithDataManager:(VehicleDetailsDataManager*)dataManager;

@end