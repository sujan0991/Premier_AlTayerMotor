//
//  VehiclesInteractor.h
//  AlTayerMotor
//
//  Created by Niteco Macmini 5wdwyl  on 10/26/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehiclesInteractorIO.h"
#import "VehiclesNetworkInterface.h"

@class VehiclesDataManager;
@class VehiclesNetwork;

@interface VehiclesInteractor : NSObject <VehiclesInteractorInput, VehiclesNetworkInterface>

@property (nonatomic, weak) id<VehiclesInteractorOutput> output;

- (instancetype)initWithDataManager:(VehiclesDataManager *)dataManager
                         andNetwork:(VehiclesNetwork *)network;

@end
