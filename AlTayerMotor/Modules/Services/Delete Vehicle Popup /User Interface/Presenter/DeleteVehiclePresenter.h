//
//  DeleteVehiclePresenter.h
//  AlTayerMotors
//
//  Created by Niteco Macmini 5wdwyl  on 11/12/15.
//  Copyright © 2015 Niteco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeleteVehicleModuleInterface.h"
#import "DeleteVehicleModuleDelegate.h"

@class DeleteVehicleWireframe;
@class MRegisteredVehicle;
@interface DeleteVehiclePresenter : NSObject <DeleteVehicleModuleInterface>

@property (nonatomic, strong) DeleteVehicleWireframe *wireframe;
@property (nonatomic, weak) id<DeleteVehicleModuleDelegate> delegate;
@property (nonatomic, strong) MRegisteredVehicle *vehicle;

@end
